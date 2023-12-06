# dec/06/2023 22:42:20 by RouterOS 7.6
# software id = 
#
/interface bridge
add name=loopback
/interface ovpn-client
add certificate=profile-5326102559260812480.ovpn cipher=aes256 connect-to=158.160.134.205 \
    mac-address=93:DB:0A:F1:89:71 name=ovpn-out1 port=443 user=daria
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing id
add disabled=no id=172.16.0.1 name=OSPF_ID select-dynamic-id=""
add disabled=no id=172.16.0.1 name=OSPF_ID select-dynamic-id=""
/routing ospf instance
add disabled=no name=ospf-instance-1 originate-default=always router-id=\
    OSPF_ID
/routing ospf area
add disabled=no instance=ospf-instance-1 name=backbone
/ip address
add address=172.16.0.1 interface=loopback network=172.16.0.1
/ip dhcp-client
add interface=ether1
/ip ssh
set forwarding-enabled=both
/system ntp client
set enabled=yes
/system ntp client servers
add address=0.ru.pool.ntp.org
