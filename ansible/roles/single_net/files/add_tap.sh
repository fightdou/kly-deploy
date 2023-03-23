#!/usr/bin/bash
#---------------------------
tunctl -b
tunctl -t tap0 -u root
ifconfig tap0 192.168.111.111 netmask 255.255.255.0 promisc
