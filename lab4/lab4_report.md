University: [ITMO University](https://itmo.ru/ru/) <br/>
Faculty: [FICT](https://fict.itmo.ru) <br/>
Course: [Network programming](https://github.com/itmo-ict-faculty/network-programming) <br/>
Year: 2023/2024 <br/>
Group: K34202 <br/>
Author: Donina Daria Dmitrievna <br/>
Lab: Lab4 <br/>
Date of create: 07.12.2023 <br/>
Date of finished: 07.12.2023 <br/>


# Цель работы
Изучить синтаксис языка программирования P4 и выполнить 2 задания обучающих задания от Open network foundation для ознакомления на практике с P4.

# Ход работы
### 1. Подготовка среды.
Склонирован репозиторий [p4lang/tutorials](https://github.com/p4lang/tutorials), установлен `Vagrant`, через него развернута виртуальная машина.

![image](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/7e69b1ca-c944-4acd-bead-30bed503b401)

На поднятой машине есть два аккаунта - p4 и vagrant.

### 2. Implementing Basic Forwarding
Под учетной записью p4 запущена среда mininet (команда `make run`) и проверена доступность узлов в нем.

![3](https://user-images.githubusercontent.com/57321062/209579016-0e2d3d7b-4862-4508-a9c2-a328ad31b8f1.png)

Необходимо поделючить переадресацию IP-пакетов, для этого изменен файл basic.p4
1. В парсер добавлены заголовки ethernet_t, ipv4_t;

```
﻿parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start { transition parse; }
    
    state parse{
      packet.extract(hdr.ethernet);
      transition select(hdr.ethernet.etherType){
        TYPE_IPV4: parse_ipv4;
        default: accept;
        }
    }
      
    state parse_ipv4{
      packet.extract(hdr.ipv4);
      transition accept;
    }
}
```
2. Изменена функция action ip4_forward:
2.1 Определен выходной порт,
2.2 Обновлен адреса назначения и источника пакетов,
2.3 Изменено значение TTL;
```
action ipv4_forward(macAddr_t dstAddr, egressSpec_t port) {
        standard_metadata.egress_spec= port;
        hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
        hdr.ethernet.dstAddr = dstAddr;
        hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
}
```
3. Добавлена валидация заголовка ipv4.
```
apply {
        if(hdr.ipv4.isValid()){ 
          ipv4_lpm.apply();
        }
    }
```
После внесенных изменений проверена работа измененного скрипта, пересылка пакетов работает

![image](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/d8fe0b5d-bd74-4976-b35c-7201c779ba42)

### 3. Implementing Basic Tunneling
В данном задании необходимо реализовать туннелирование, чтобы общение между коммутаторами в сети осуществлялось по следующей схеме:

![image](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/349753ad-2a8d-4f09-aee0-d706d801d7e5)

Для этого изменен файл basic_tunnel.p4:
1. В парсер добавлена функция реализующая заголовок туннеля;

 ```
header myTunnel_t {
    bit<16> proto_id;
    bit<16> dst_id;
}

   struct headers {
    ethernet_t   ethernet;
    myTunnel_t   myTunnel;
    ipv4_t       ipv4;
}

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        transition parse_ethernet;
    }
```
2. Добавлен action myTunnel_forward;
```
action myTunnel_forward(egressSpec_t port) {
    standard_metadata.egress_spec = port;
}
```
3. Добавлена таблица myTunnel_exact;
```
table myTunnel_exact {
        key = {
            hdr.myTunnel.dst_id: exact;
        }
        actions = {
            myTunnel_forward;
            drop;
        }
        size = 1024;
        default_action = drop();
    }
```

4. Добавлена функция определяющая необходимость применения myTunnel_exact, в зависимости от заголовка;
```
apply {
    if (hdr.ipv4.isValid() && !hdr.myTunnel.isValid()) {
        ipv4_lpm.apply();
    }
    if (hdr.myTunnel.isValid()) {
        myTunnel_exact.apply();
    }
}
```
5. В Депарсер добавлена поддержка внесенных изменений.
```
control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        #// TODO: emit myTunnel header as well
        packet.emit(hdr.myTunnel);
        packet.emit(hdr.ipv4);
    }
}
```

Далее проведена проверка доступности сети.

![image](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/a4a5f3e5-6b66-4fbe-b864-d9f69d5db854)

А также проверка работы скрипта о туннелировании.

![image](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/2786db61-eae8-4bb6-a378-480e5e7dbc13)


# Вывод
Были изучены основы языка программирования P4,
предназначенные для организации процесса обработки сетевого трафика. Полученные знания применены на практике, 
написано 2 программы, позволяющие организовать в заранее созданной сети процессы перенаправления пакетов и туннелирования.
