# kly-deploy


## 配置主机清单
修改 hosts 文件，将部署环境的节点信息配置进去

## 修改 globals 文件
修改 ceph-globals.yaml 与 globals_vars.yaml

## 部署脚本
首先加载离线资源
```bash
cd kly-deploy
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ansible/91-prepare.yaml
```

部署 ceph 环境
```bash
cd kly-deploy
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ceph-ansible/ceph-deploy.yaml
```

部署其他服务
```bash
cd kly-deploy
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ansible/90-setup.yaml
```

集群资源恢复（仅适用于易教版）
```bash
cd kly-deploy
ansible-playbook -i etc_example/hosts -e @etc_example/global_vars.yaml -e @etc_example/ceph-globals.yaml ansible/92-recovery.yaml
```

更改集群 IP（仅适用于易教版）
```bash
cd kly-deploy/tools/
chmod +x update_ipaddress.sh
./update_ipaddress.sh --netcard ens3 --ipaddr 172.18.31.30 --prefix 22 --gateway 172.18.31.254
```
>  --netcard 网卡的名字  --ipaddr 新的IP地址  --prefix 新的子网掩码前缀 --gateway 新的网关 --dns 新的dns
