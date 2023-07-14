#!/bin/bash

inventory_file="../etc_example/hosts"
variable_file="../etc_example/global_vars.yaml"

die() {
  local msg=$1
  local code=${2:-1}
  echo -e "\033[31m$msg \033[0m" >&2
  exit "$code"
}

parse_params() {
  declare -a -g ipaddr
  prefix=""
  gateway="" 
  vip=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -i|--ipaddr) ipaddr+=("${2-}") ; shift ;;
      -p|--prefix) prefix="${2-}" ; shift ;;
      -g|--gateway) gateway="${2-}" ; shift ;;
      -v|--vip) vip="${2-}" ; shift ;;
      -?*) die "Unknown option: $1" ;;
      *) break ;;
    esac
    shift
  done

  if [[ -z $ipaddr || -z $prefix || -z $gateway ]]; then
    die "eg: ./$(basename "${BASH_SOURCE[0]}") --ipaddr 192.168.100.10 --ipaddr 192.168.100.11 --ipaddr 192.168.100.12 --vip 192.168.100.100 --prefix 24 --gateway 192.168.100.254"
  fi
}

update_inventory_file() {
  while IFS= read -r line; do
    if [[ -n $line && ! $line =~ ^# ]]; then
      all_data+=("$line")
    fi
  done < "$inventory_file"

  allnodes_contents=()
  is_matching=false
  line_counter=0
  for line in "${all_data[@]}"; do
    if [[ $line =~ ^\[allnodes\] ]]; then
      is_matching=true
    elif $is_matching && ((line_counter < $host_num)); then
      allnodes_contents+=("$line")
      ((line_counter++))
    fi
  done
  echo "${allnodes_contents[@]}"

  for i in "${!allnodes_contents[@]}"; do
    line=${allnodes_contents[$i]}
    if [[ $line == *"new_external_manage_prefix"* ]]; then
      line=$(echo "$line" | sed -E 's/ (new_external_manage_prefix|new_external_manage_ip|new_external_manage_getway)=[^[:space:]]*//g')
    fi
    line=$(echo "$line" | sed "s/$/ new_external_manage_prefix=$prefix new_external_manage_getway=$gateway/")

    ip=${ipaddr[$i]}
    updated_line="$line new_external_manage_ip=$ip"
    new_allnodes_contents+=("$updated_line")
  done

  # 更新 [allnodes] 组的内容
  for i in "${!all_data[@]}"; do
    line=${all_data[$i]}
    if [[ $line == "[allnodes]" ]]; then
      start_index=$i+1
      end_index=$((${start_index}+${#new_allnodes_contents[@]}))
      all_data=("${all_data[@]:0:$start_index}" "${new_allnodes_contents[@]}" "${all_data[@]:$end_index}")
    fi
  done

  # Write the updated all_data array to the inventory file
  printf "%s\n" "${all_data[@]}" > "$inventory_file"
}

exec_ansible_script() {
  if [[ -z $vip ]]; then
    vip=${ipaddr[0]}
  fi

  ansible-playbook -i $inventory_file -e @$variable_file -e new_external_vip_address=$vip ../ansible/97-update-ip.yml  > update-ip.log
  if ! [ "$(grep 'failed='  update-ip.log | awk '{print $6}' | awk -F '=' '{print $2}' | awk '$1 != 0')" = "" ] ; then
    exit 1
  else
    sed -i "s/^external_vip_address:.*/external_vip_address: $vip/" "$variable_file"
  fi
  
}


host_num=$(grep -A9999 "# BEGIN ANSIBLE GENERATED HOSTS" /etc/hosts | grep -B9999 "# END ANSIBLE GENERATED HOSTS" | grep -v "#" | wc -l)
echo "The current environment number of nodes is $host_num"
parse_params "$@"

echo ipaddr="${ipaddr[@]}" prefix=$prefix gateway=$gateway
ipaddr_num=${#ipaddr[@]}
if [ "$ipaddr_num" -ne "$host_num" ]; then
  die "You entered $ipaddr_num IP addresses, but the number of nodes is $host_num"
fi

update_inventory_file
exec_ansible_script
