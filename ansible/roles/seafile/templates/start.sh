#!/bin/bash

mysql -useafile -p{{ seafile_mariadb_password }} -h {{ default_internal_server_visit_ip }} -e 'show databases;'
if `mysql -useafile -p{{ seafile_mariadb_password }} -h {{ default_internal_server_visit_ip }} -e 'show databases;'`; then
    /root/seafile-server-latest/seafile.sh start
    /root/seafile-server-latest/seahub.sh start
    tail -100f /root/logs/seafile.log
else
    exit 1
