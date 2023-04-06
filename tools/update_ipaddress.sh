#!/bin/bash

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [OPTION]...

Available options:
-h, --help          Print this help and exit
-n, --netcard       Specifies the name of the network adapter to be changed.
-i, --ipaddr        The IP address of the current env management network.
-p, --prefix        The netmask prefix of the current env management network.
-g, --gateway       The gateway of the current env management network.
-d, --dns           The dns of the current env management network.
EOF
  exit
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  echo >&2 -e "\033[31m$msg \033[0m"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  netcard=""
  ipaddr=""
  prefix=""
  gateway=""
  dns=""
  global_vars_file=../etc_example/global_vars.yaml
  old_ipaddr=$(grep $(hostname) /etc/hosts | awk '{print $1}')

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -n | --netcard)
      netcard="${2-}"
      shift
      ;;
    -i | --ipaddr)
      ipaddr="${2-}"
      shift
      ;;
    -p | --prefix)
      prefix="${2-}"
      shift
      ;;
    -g | --gateway)
      gateway="${2-}"
      shift
      ;;
    -d | --dns)
      dns="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  if [ -z "${netcard-}" ] || [ -z "${ipaddr-}" ] || [ -z "${prefix-}" ] || [ -z "${gateway-}" ]; then
    die "Missing required parameter:
${GREEN}eg: ./$(basename "${BASH_SOURCE[0]}")  --netcard eth_name --ipaddr 192.168.100.10 --prefix 24 --gateway 192.168.100.254 ${NOFORMAT}"
  fi

  return 0
}

parse_params "$@"

update_network() {
  # 修改 IP 地址和子网掩码
  sudo nmcli connection modify $netcard ipv4.addresses $ipaddr/$prefix
  # 修改网关
  sudo nmcli connection modify $netcard ipv4.gateway $gateway

  if [ ! -z "${dns-}" ]; then
    sudo nmcli connection modify $netcard ipv4.dns $dns
  fi

  # 重启网络连接
  sudo nmcli connection down $netcard >/dev/null && sudo nmcli connection up $netcard >/dev/null

  # 打印修改后的IP地址
  echo "$(date "+%Y-%m-%d %H:%M:%S") New IP address and netmask for $netcard:"
  grep -E 'IPADDR|NETMASK|PREFIX|GATEWAY|DNS' /etc/sysconfig/network-scripts/ifcfg-$netcard
  echo "----------------------------------------------------------------------"

  result=$(ip address show $netcard | grep "$ipaddr/$profix")
  if [ -z "${result}" ]; then
    return 1
  else
    return 0
  fi
}

update_hosts() {
  old_line=$(grep $(hostname) /etc/hosts)
  new_line="$ipaddr $(hostname)"

  sudo sed -i "s#$old_line#$new_line#" /etc/hosts

  # 打印修改后的 hosts
  echo "$(date "+%Y-%m-%d %H:%M:%S") New '/etc/hosts' config is:"
  grep -E $ipaddr /etc/hosts
  echo "----------------------------------------------------------------------"
}

update_ansible() {
  ansible_hosts_file="../etc_example/hosts"
  sed -i 's/'"${old_ipaddr}"'/'"${ipaddr}"'/g' $ansible_hosts_file

  echo "$(date "+%Y-%m-%d %H:%M:%S") New '$ansible_hosts_file' config is:"
  grep -E "api_interface" $ansible_hosts_file
  echo "----------------------------------------------------------------------"
}

update_jave() {
  java_conf_file="/etc/klcloud/fsd/trochilus.sql"

  update_setting_sql="$(cat $java_conf_file | sed -E 's/'"${old_ipaddr}"'/'"${ipaddr}"'/g')" 
  update_server_sql="UPDATE des_server SET ip = '${ipaddr}' WHERE ip = '${old_ipaddr}';"
  update_console_sql="UPDATE des_center_console SET ip = '${ipaddr}' WHERE ip = '${old_ipaddr}';"

  mariadb_root_username=$(echo $(grep -E '^mariadb_root_username:' $global_vars_file | cut -d':' -f2))
  mariadb_root_password=$(echo $(grep -E '^mariadb_root_password:' $global_vars_file | cut -d':' -f2))

  docker exec -it mariadb mysql -u$mariadb_root_username -p$mariadb_root_password -e \
  "$update_setting_sql $update_server_sql $update_console_sql"

  if [ -d /etc/klcloud/trochilus/trochilus.conf ]; then
    rm -rf /etc/klcloud/trochilus/trochilus.conf >/dev/null 
  fi  
  if [ -d /etc/klcloud/btserver ]; then
    rm -rf /etc/klcloud/btserver >/dev/null 
  fi
  ansible-playbook -i ../etc_example/hosts -e @../etc_example/global_vars.yaml \
                   -e @../etc_example/ceph-globals.yaml ../ansible/90-setup.yaml \
                   -t trochilus -t btserver

  echo "----------------------------------------------------------------------"
}

deploy_version=$(grep -E '^deploy_edu:' $global_vars_file | cut -d':' -f2)

if [ $deploy_version != true ]; then
  die "This script is only available in a single node Edition VOI environment!"
fi

update_network
if [ $? -eq 0 ]; then
  update_hosts
  update_ansible
  update_jave
  echo "The environment update success。"
else
    echo "Failed to change the IP address. Please check the environment. "
fi
