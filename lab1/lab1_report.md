University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Network programming](https://github.com/itmo-ict-faculty/network-programming)
Year: 2023/2024
Group: K34202
Author: Donina Daria Dmitrievna
Lab: Lab1
Date of create: 06.12.2023
Date of finished: 06.12.2023


# Цель работы
Развертывание виртуальной машины на базе платформы Yandex Cloud с установленной системой контроля конфигураций Ansible и установка CHR в VirtualBox.

# Ход работы
### 1. Создание и подготовка виртуальной машины в Yandex Cloud.

В Yandex Cloud создаем виртуальную машину с Ubuntu 18 или выше. Подключиться к виртуальной машине можно по ssh. 
...скрин...

Устанавливаем python3 и Ansible.
```
sudo apt install python3-pip
ls -la /usr/bin/python3.6
sudo pip3 install ansible
ansible --version
```
...скрин...


### 2. Настройка VirtualBox
Установим CHR на VirtualBox.
...скрин...

### 3. Поднятие VPN туннеля.
Создаем Wireguard/OpenVPN/L2TP сервер на облачной виртуальной машине. При этом CHR будет выступать в качестве VPN клиента.
...код...
...скрин...

Проверим работу VPN туннеля между VPN сервером и VPN клиентом на RouterOS (CHR)
...скрин...


# Вывод
В ходе данной работы был 
