#!/usr/bin/python
#it is a fix and not apply in production.
#The issue is: If update hosts file directly it will rewrite the information(eg: metadata server) by appcenter or by users.


import shutil
import os

if __name__ == '__main__': 
    hosts_name = "/etc/hosts" 
    tmp_hosts_name = "/opt/qingcloud/conf/hosts.tmp"
    new_hosts_name = "/opt/qingcloud/conf/hosts.new"
    
    hosts = open(hosts_name, 'r')
    tmp_hosts = open(tmp_hosts_name, 'r')
    new_hosts = open(new_hosts_name, 'w')

    host_ip_dict = {}
    writed_host_ip_dict = {}
    for line in tmp_hosts.readlines():
        sp = line.split()
        if len(sp) >= 2:
            host_ip_dict[sp[1]] = sp[0] 
    tmp_hosts.close()

    for line in hosts.readlines():
        if line[:-1].strip() and not line.startswith("#"):
            sp = line.split()
            if len(sp) >= 2:
                ip = sp[0]
                hostnames = sp[1:] 
                for hostname in hostnames:
                    if hostname in host_ip_dict:
                        if host_ip_dict[hostname] != ip and hostname not in writed_host_ip_dict:
                            new_hosts.write(host_ip_dict[hostname] + ' ' + hostname + '\n')
                        elif hostname not in writed_host_ip_dict:
                            new_hosts.write(ip + ' ' + hostname + '\n')
                        writed_host_ip_dict[hostname] = host_ip_dict[hostname]
                    elif hostname not in writed_host_ip_dict:
                        new_hosts.write(ip + ' ' + hostname + '\n')
                        writed_host_ip_dict[hostname] = ip
            else:
                new_hosts.write(line)
        else:
            new_hosts.write(line)

    for host, ip in host_ip_dict.items():
        if host not in writed_host_ip_dict:
            new_hosts.write(ip + ' ' + host + '\n')

    shutil.move("/opt/qingcloud/conf/hosts.new", "/etc/hosts" )

    hosts.close()
    new_hosts.close()