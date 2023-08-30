#!/bin/bash

log_file=/var/log/docker-recovery.log

echo "`date` ------ recover docker containerd check! ---------" | tee -a $log_file

for i in {1..10}; do
    sleep 30
    # 检查 containerd 是否异常
    containerd_status=$(systemctl is-failed containerd)

    if [ "$containerd_status" == "failed" ]; then
        echo "`date` ------ containerd is not active. Performing recovery. ---------" | tee -a $log_file
        # 停止 Docker 服务
        sudo systemctl stop docker
        # 备份 containerd 数据库
        sudo cp -r /var/lib/containerd/ /var/lib/containerd_backup-`date '+%Y-%m-%d-%H:%M:%S'`
        # 清理 containerd 数据库
        sudo rm -rf /var/lib/containerd/*
        # 启动 containerd 服务
        sudo systemctl restart containerd

        containerd_status=$(systemctl is-failed containerd)
        # 如果还是失败，打印错误信息
        if [ "$containerd_status" == "failed" ]; then
            echo "`date` ------ containerd 服务重启失败, 打印日志..." | tee -a $log_file
            # 打印docker服务的日志
            journalctl -u containerd.service | tee -a $log_file
            break
        else
            echo "`date` ------ containerd 服务重启成功 !" | tee -a $log_file
        fi
        sleep 10
        # 启动 docker 服务
        sudo systemctl restart docker
        docker_status=$(systemctl is-active docker)
        echo "`date` ------ docker status is $docker_status ---------" | tee -a $log_file
        echo "`date` ------ Recovery completed ---------" | tee -a $log_file
    else
        echo "`date` ------ containerd is active. No recovery needed ---------" | tee -a $log_file
    fi

    # 检查 docker 是否异常
    docker_status=$(systemctl is-failed docker)
    if [ "$docker_status" == "failed" ]; then
        echo "`date` ------ docker 文件系统损坏，自动修复 ---------" | tee -a $log_file
        # 备份local-kv.db 文件
        cp /var/lib/docker/network/files/local-kv.db /var/lib/docker/network/files/local-kv.db.bak-`date '+%Y-%m-%d-%H:%M:%S'`
        # 删除源文件
        rm -f /var/lib/docker/network/files/local-kv.db

        systemctl restart docker
        recovery_status=$(systemctl is-active docker)
            # 如果还是失败，打印错误信息
            if [ "$recovery_status" == "failed" ]; then
                echo "`date` ------ Docker 服务重启失败, 打印日志..." | tee -a $log_file
                # 打印docker服务的日志
                journalctl -u docker.service | tee -a $log_file
            else
                echo "`date` ------ Docker 服务重启成功 !" | tee -a $log_file
            fi
        echo "`date` ------ Recovery completed ---------" | tee -a $log_file
    else
        echo "`date` ------ docker is active. No recovery needed ---------" | tee -a $log_file
        break
    fi
done