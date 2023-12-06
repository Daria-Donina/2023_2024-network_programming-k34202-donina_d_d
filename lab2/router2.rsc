# dec/06/2023 22:45:28 by RouterOS 7.5
# software id = 
#
/interface bridge
add name=loopback
/interface ovpn-client
add certificate=2.ovpn cipher=aes256 connect-to=158.160.134.205 mac-address=\
    C7:2C:96:1C:88:69 name=ovpn-out1 port=443 user=daria
/disk
set sata1 disabled=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing id
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
/system ntp client
set enabled=yes
/system ntp client servers
add address=0.ru.pool.ntp.org
