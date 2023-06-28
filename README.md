# kly-deploy


## 配置主机清单
修改 hosts 文件，将部署环境的节点信息配置进去

## 修改 globals 文件
修改 ceph-globals.yaml 与 globals_vars.yaml

## 部署脚本
首先加载离线资源
```bash
cd /root/deploy/kly-deploy/
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ansible/91-prepare.yaml
```

部署 ceph 环境
```bash
cd /root/deploy/kly-deploy/
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ceph-ansible/ceph-deploy.yaml
```

部署其他服务
```bash
cd /root/deploy/kly-deploy/
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ansible/90-setup.yaml
```

集群资源恢复（仅适用于易教版）
```bash
cd /root/deploy/kly-deploy/tools
./env_recovery.sh
```

更改集群 IP（仅适用于易教版）
```bash
cd /root/deploy/kly-deploy/tools

# 单节点
./update_ipaddress.sh --ipaddr 192.168.100.10 --prefix 24 --gateway 192.168.100.254

# 多节点
./update_ipaddress.sh --ipaddr 192.168.100.10 --ipaddr 192.168.100.11 --ipaddr 192.168.100.12 --vip 192.168.100.251 --prefix 24 --gateway 192.168.100.254
```
