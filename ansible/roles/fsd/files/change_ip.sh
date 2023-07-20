#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" >> change_ip.log
   exit 1
fi

#睡10秒 等java程序结束
sleep 10

#节点内网IP
inner_ip=$1
#旧管理网节点IP
old_ip=$2
#新管理网节点IP
new_ip=$3
#旧VIP
old_vip=$4
#新VIP
new_vip=$5
#agent id
agent_id=$6
#agent url 参数
agent_params=$7

echo "$inner_ip##$old_ip##$new_ip##$old_vip##$new_vip##$agent_id##$agent_params" >> change_ip.log

echo "$(curl -X POST -s -w \"%{http_code}\" HTTP://$inner_ip:19001/v1/agent/$agent_id/action -H 'Content-Type: application/json' -d \"$agent_params\")" >> change_ip.log
response=$(curl -X POST -s -w "%{http_code}" HTTP://$inner_ip:19001/v1/agent/$agent_id/action -H 'Content-Type: application/json' -d "$agent_params")
if [ "$response" -eq 201 ]; then
    echo "trochilus change ip succ" >> change_ip.log
    #重启服务
    docker restart haproxy

    docker restart keepalived

    docker restart btserver

    docker restart btserver_tracker

else
    echo "trochilus change ip fail" >> change_ip.log
fi