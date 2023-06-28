#!/bin/bash

set -e

inventory_file="../etc_example/hosts"
global_var_file="../etc_example/global_vars.yaml"
ceph_var_file="../etc_example/ceph-globals.yaml"

enable_ceph=$(grep -oP '^\s*enable_ceph:\s*\K.+' "$global_var_file")

ansible-playbook -i "$inventory_file" -e @"$global_var_file" -e @"$ceph_var_file" "../ansible/99-destroy.yaml"

if [[ $enable_ceph == "true" ]]; then
    ansible-playbook -i "$inventory_file" -e @"$global_var_file" -e @"$ceph_var_file" "../ceph-ansible/ceph-destroy.yaml"
fi

ansible-playbook -i $inventory_file -e @$global_var_file -e @$ceph_var_file ../ansible/96-single-net.yml
ansible-playbook -i $inventory_file -e @$global_var_file -e @$ceph_var_file ../ansible/94-internal_ip.yaml
ansible-playbook -i $inventory_file -e @$global_var_file -e @$ceph_var_file ../ansible/91-prepare.yaml

if [[ $enable_ceph == "true" ]]; then
    ansible-playbook -i "$inventory_file" -e @"$global_var_file" -e @"$ceph_var_file" "../ceph-ansible/ceph-deploy.yaml"
fi

ansible-playbook -i $inventory_file -e @$global_var_file -e @$ceph_var_file ../ansible/90-setup.yaml
