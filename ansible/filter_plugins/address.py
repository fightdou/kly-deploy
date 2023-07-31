# -*- coding: utf-8 -*-
#
# Copyright 2019 Radosław Piliszek (yoctozepto)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from jinja2.filters import contextfilter
from jinja2.runtime import Undefined

from ansible.errors import AnsibleFilterError
import subprocess,json
import requests

def _call_bool_filter(context, value):
    """Pass a value through the 'bool' filter.
    :param context: Jinja2 Context object.
    :param value: Value to pass through bool filter.
    :returns: A boolean.
    """
    return context.environment.call_filter("bool", value, context=context)

def listintersection(source_list, dest_list):
    """This function returns the intersection of the passed collections

    :return: Returns the value of the unit conversion, is a type type.

    """
    if not isinstance (source_list, list):
         raise ValueError("source_list:[{}] must is a list type".format(source_list))
    if not isinstance (dest_list, list):
         raise ValueError("dest_list:[{}] must is a list type".format(dest_list))

    source_set = set(source_list)
    dest_set = set(dest_list)
    re_list = sorted(list(source_set & dest_set))

    return re_list

@contextfilter
def filter_address(context, network_name, hostname=None):
    """returns IP address on the requested network
    The output is affected by '<network_name>_*' variables:
    '<network_name>_interface' sets the interface to obtain address for.
    '<network_name>_address_family' controls the address family (ipv4/ipv6).
    :param context: Jinja2 Context
    :param network_name: string denoting the name of the network to get IP
                         address for, e.g. 'api'
    :param hostname: to override host which address is retrieved for
    :returns: string with IP address
    """

    # NOTE(yoctozepto): watch out as Jinja2 'context' behaves not exactly like
    # the python 'dict' (but mimics it most of the time)
    # for example it returns a special object of type 'Undefined' instead of
    # 'None' or value specified as default for 'get' method
    # 'HostVars' shares this behavior

    if hostname is None:
        hostname = context.get('inventory_hostname')
        if isinstance(hostname, Undefined):
            raise AnsibleFilterError(
                "'inventory_hostname' variable is unavailable")

    hostvars = context.get('hostvars')
    if isinstance(hostvars, Undefined):
        raise AnsibleFilterError("'hostvars' variable is unavailable")

    host = hostvars.get(hostname)
    if isinstance(host, Undefined):
        raise AnsibleFilterError("'{hostname}' not in 'hostvars'"
                                 .format(hostname=hostname))

    del hostvars  # remove for clarity (no need for other hosts)

    # NOTE(yoctozepto): variable "host" will *not* return Undefined
    # same applies to all its children (act like plain dictionary)

    interface_name = host.get(network_name + '_interface')
    if interface_name is None:
        raise AnsibleFilterError("Interface name undefined "
                                 "for network '{network_name}' "
                                 "(set '{network_name}_interface')"
                                 .format(network_name=network_name))

    address_family = 'ipv4'

    ansible_interface_name = interface_name.replace('-', '_')
    interface = host.get('ansible_' + ansible_interface_name)
    if interface is None:
        raise AnsibleFilterError("Interface '{interface_name}' "
                                 "not present "
                                 "on host '{hostname}'"
                                 .format(interface_name=interface_name,
                                         hostname=hostname))

    af_interface = interface.get(address_family)
    if af_interface is None:
        raise AnsibleFilterError("Address family '{address_family}' undefined "
                                 "on interface '{interface_name}' "
                                 "for host: '{hostname}'"
                                 .format(address_family=address_family,
                                         interface_name=interface_name,
                                         hostname=hostname))

    if address_family == 'ipv4':
        address = af_interface.get('address')

    if address is None:
        raise AnsibleFilterError("{address_family} address missing "
                                 "on interface '{interface_name}' "
                                 "for host '{hostname}'"
                                 .format(address_family=address_family,
                                         interface_name=interface_name,
                                         hostname=hostname))
    return address


@contextfilter
def filter_interface_name(context, network_name, hostname=None):
    """returns IP address on the requested network
    The output is affected by '<network_name>_*' variables:
    '<network_name>_interface' sets the interface to obtain address for.
    '<network_name>_address_family' controls the address family (ipv4/ipv6).
    :param context: Jinja2 Context
    :param network_name: string denoting the name of the network to get IP
                         address for, e.g. 'api'
    :param hostname: to override host which address is retrieved for
    :returns: string with IP address
    """

    # NOTE(yoctozepto): watch out as Jinja2 'context' behaves not exactly like
    # the python 'dict' (but mimics it most of the time)
    # for example it returns a special object of type 'Undefined' instead of
    # 'None' or value specified as default for 'get' method
    # 'HostVars' shares this behavior

    if hostname is None:
        hostname = context.get('inventory_hostname')
        if isinstance(hostname, Undefined):
            raise AnsibleFilterError(
                "'inventory_hostname' variable is unavailable")

    hostvars = context.get('hostvars')
    if isinstance(hostvars, Undefined):
        raise AnsibleFilterError("'hostvars' variable is unavailable")

    host = hostvars.get(hostname)
    if isinstance(host, Undefined):
        raise AnsibleFilterError("'{hostname}' not in 'hostvars'"
                                 .format(hostname=hostname))

    del hostvars  # remove for clarity (no need for other hosts)

    # NOTE(yoctozepto): variable "host" will *not* return Undefined
    # same applies to all its children (act like plain dictionary)

    interface_name = host.get(network_name + '_interface')
    if interface_name is None:
        raise AnsibleFilterError("Interface name undefined "
                                 "for network '{network_name}' "
                                 "(set '{network_name}_interface')"
                                 .format(network_name=network_name))

    ansible_interface_name = interface_name.replace('-', '_')
    interface = host.get('ansible_' + ansible_interface_name)
    if interface is None:
        raise AnsibleFilterError("Interface '{interface_name}' "
                                 "not present "
                                 "on host '{hostname}'"
                                 .format(interface_name=interface_name,
                                         hostname=hostname))

    return interface_name


def put_address_in_context(address, context):
    """puts address in context

    :param address: the address to contextify
    :param context: describes context in which the address appears,
                    either 'url' or 'memcache',
                    affects only IPv6 addresses format
    :returns: string with address in proper context
    """

    if context not in ['url', 'memcache']:
        raise AnsibleFilterError("Unknown context '{context}'"
                                 .format(context=context))

    if ':' not in address:
        return address

    # must be IPv6 raw address

    if context == 'url':
        return '[{address}]'.format(address=address)
    elif context == 'memcache':
        return 'inet6:[{address}]'.format(address=address)

    return address


def _host_vars(context, hostname=None):
    if hostname is None:
        hostname = context.get('inventory_hostname')
        if isinstance(hostname, Undefined):
            raise AnsibleFilterError(
                "'inventory_hostname' variable is unavailable")

    hostvars = context.get('hostvars')
    if isinstance(hostvars, Undefined):
        raise AnsibleFilterError("'hostvars' variable is unavailable")

    host = hostvars.get(hostname)
    if isinstance(host, Undefined):
        raise AnsibleFilterError("'{hostname}' not in 'hostvars'"
                                 .format(hostname=hostname))

    del hostvars  # remove for clarity (no need for other hosts)
    return host

@contextfilter
def filter_node_ceph_osd_num(context, hostname=None):
    hostvars = _host_vars(context, hostname)
    hostname_name = hostvars.get('ansible_hostname')
    cmd = ['ceph','osd','tree-from',hostname_name,'-f','json']
    osd_result = subprocess.run(cmd,capture_output=True,encoding='utf-8')
    osd_json = osd_result.stdout
    osd_info = json.loads(osd_json)
    osd_list = []
    for osd in osd_info['nodes']:
        if osd['type'] == 'host':
            osd_list = osd['children']
            break
    return len(osd_list)

@contextfilter
def filter_node_vcpus(context, hostname=None):
    """Return the available CPU of the target node
    The output is affected by variables:
    '<ansible_processor_vcpus>'  Ansible is automatically generated without setting.
    '<reserved_host_cpus>' Used for node reservation of CPU, defined in ansible variable file for incoming.
    '<cpu_allocation_ratio>' Virtual CPU partition ratio, defined in ansible variable file for incoming.
    :param context: Jinja2 Context
    :param hostname: to override host which vcpus is retrieved for
    :returns: int with vcpus num
    """
    # NOTE(yoctozepto): watch out as Jinja2 'context' behaves not exactly like
    # the python 'dict' (but mimics it most of the time)
    # for example it returns a special object of type 'Undefined' instead of
    # 'None' or value specified as default for 'get' method
    # 'HostVars' shares this behavior

    hostvars = _host_vars(context, hostname)
    host_vcpus = hostvars.get('ansible_processor_vcpus')
    host_reserved_cpus = hostvars.get('reserved_host_cpus')
    if host_reserved_cpus is None:
        _field_none_error('reserved_host_cpus', hostname)
    host_allocation_ratio_cpus = hostvars.get('cpu_allocation_ratio')
    if host_allocation_ratio_cpus is None:
        _field_none_error('cpu_allocation_ratio', hostname)
    cpuNum = (host_vcpus - host_reserved_cpus) * host_allocation_ratio_cpus
    return cpuNum


@contextfilter
def filter_vdi_node_mems(context, hostname=None):
    """Return the available CPU of the target node
    The output is affected by variables:
    '<ansible_processor_vcpus>'  Ansible is automatically generated without setting.
    '<reserved_host_cpus>' Used for node reservation of CPU, defined in ansible variable file for incoming.
    '<cpu_allocation_ratio>' Virtual CPU partition ratio, defined in ansible variable file for incoming.
    :param context: Jinja2 Context
    :param hostname: to override host which vcpus is retrieved for
    :returns: int with vcpus num
    """
    # NOTE(yoctozepto): watch out as Jinja2 'context' behaves not exactly like
    # the python 'dict' (but mimics it most of the time)
    # for example it returns a special object of type 'Undefined' instead of
    # 'None' or value specified as default for 'get' method
    # 'HostVars' shares this behavior

    hostvars = _host_vars(context, hostname)
    ceph_bool = hostvars.get('enable_ceph')
    if ceph_bool is None:
        _field_none_error('enable_ceph', hostname)
    host_mems = hostvars.get('ansible_memtotal_mb')
    host_reserved_memory_mb = hostvars.get('reserved_host_memory_mb')
    if host_reserved_memory_mb is None:
        _field_none_error('reserved_host_memory_mb', hostname)
    host_reseverd_system_memory_mb = hostvars.get('reseverd_system_memory_mb')
    if host_reseverd_system_memory_mb is None:
        _field_none_error('reseverd_system_memory_mb', hostname)
    voi_reserved_memory = hostvars.get('voi_reserved_memory')
    if voi_reserved_memory is None:
        _field_none_error('voi_reserved_memory', hostname)

    if host_mems < 32768:
        if 16384 < host_mems < 32768:
            return 16 - voi_reserved_memory
        elif 8192 < host_mems < 16384:
            return 8 - voi_reserved_memory
        else:
            return 4 - voi_reserved_memory

    if ceph_bool:
        ceph_volume_data = hostvars.get('ceph_volume_data')
        if ceph_volume_data is None:
            _field_none_error('ceph_volume_data', hostname)
        bcache_map_list = hostvars.get('bcache_map_list')
        if bcache_map_list is None:
            _field_none_error('bcache_map_list', hostname)
        if ceph_volume_data == [] and bcache_map_list == []:
            osd_num = 0
        else:
            osd_num = filter_node_ceph_osd_num(context,hostname)
        host_reserved_osd_memory_mb = hostvars.get('reserved_osd_memory_mb')
        if host_reserved_osd_memory_mb is None:
            _field_none_error('reserved_osd_memory_mb', hostname)
        host_reserved_mds_memory_mb = hostvars.get('reserved_mds_memory_mb')
        if host_reserved_mds_memory_mb is None:
            _field_none_error('reserved_mds_memory_mb', hostname)
        host_reserved_mon_memory_mb = hostvars.get('reserved_mon_memory_mb')
        if host_reserved_mon_memory_mb is None:
            _field_none_error('reserved_mon_memory_mb', hostname)
        vdi_node_num = ((host_mems - host_reserved_osd_memory_mb * osd_num - host_reserved_mds_memory_mb -
                        host_reserved_mon_memory_mb - host_reseverd_system_memory_mb - host_reserved_memory_mb) // 1024) - voi_reserved_memory
        return vdi_node_num
    else:
        vdi_node_num = ((host_mems - host_reserved_memory_mb - host_reseverd_system_memory_mb ) // 1024) - voi_reserved_memory
        return vdi_node_num

def _field_none_error(field, hostname):
    raise AnsibleFilterError(f"{field} name undefined for host '{hostname}'\
                                 ,set '{field}' in ansible variable")

def get_trochilus_agent_id(hostname,host='127.0.0.1'):
    agent_id=None
    result=requests.get(url=f"http://{host}:9001/v1/agent?mgmt_ip={hostname}&fields=id")
    agents = json.loads(result.text)
    for agent in agents['agents']:
        if agent['id'] is not None and agent['id'] != "":
            agent_id = agent['id']
            break
    if agent_id is None or agent_id == "":
        raise AnsibleFilterError(f"Interface {result.request.url} can not get context, result={agents}")
    return agent_id

class FilterModule(object):

    def filters(self):
        return {
            'filter_interface_name': filter_interface_name,
            'filter_address': filter_address,
            'put_address_in_context': put_address_in_context,
            'listintersection': listintersection,
            'filter_node_ceph_osd_num': filter_node_ceph_osd_num,
            'filter_node_vcpus': filter_node_vcpus,
            'filter_vdi_node_mems': filter_vdi_node_mems,
            'get_trochilus_agent_id': get_trochilus_agent_id
        }
