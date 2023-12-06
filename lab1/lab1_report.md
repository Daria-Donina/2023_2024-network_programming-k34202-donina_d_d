University: [ITMO University](https://itmo.ru/ru/) <br/>
Faculty: [FICT](https://fict.itmo.ru) <br/>
Course: [Network programming](https://github.com/itmo-ict-faculty/network-programming) <br/>
Year: 2023/2024 <br/>
Group: K34202 <br/>
Author: Donina Daria Dmitrievna <br/>
Lab: Lab1 <br/>
Date of create: 06.12.2023 <br/>
Date of finished: 06.12.2023 <br/>


# Цель работы
Развертывание виртуальной машины на базе платформы Yandex Cloud с установленной системой контроля конфигураций Ansible и установка CHR в VirtualBox.

# Ход работы
### 1. Создание и подготовка виртуальной машины в Yandex Cloud.

В Yandex Cloud создаем виртуальную машину с Ubuntu 18 или выше (у меня 22.04). Подключиться к виртуальной машине можно по ssh. 
![1](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/8574ed2b-2024-4cd7-945a-08c88399d6f2)

Устанавливаем python3 и Ansible.
```
sudo apt install python3-pip
ls -la /usr/bin/python3.6
sudo pip3 install ansible
ansible --version
```
![2](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/751b7032-7b90-4d77-9285-17ee23c92d44)

### 2. Настройка VirtualBox
Установим CHR на VirtualBox. С сайта Mikrotik скачиваем образ и подключаем его в новую виртуальную машину. Устанавливаем 
тип сетевого подключения - сетевой мост.

![photo_2023-12-07_00-43-06](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/dee6ac57-14fa-497b-af57-a9a8ba11ee8a)

Далее подключаемся к виртуальной машине с CHR и входим в систему Mikrotik. Узнаем ip-адрес.

![photo_2023-12-07_00-44-34](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/0b2f2da0-ec54-407a-9660-5799e6f3f864)

Далее устанавливаем клиент WinBox и вводим полученный адрес, логин и пароль.

![image](https://github.com/Daria-Donina/2023_2024-network_programming-k34202-donina_d_d/assets/43678323/ee188fa7-f194-4af8-ab7c-8e9dd9bb9247)


### 3. Поднятие VPN туннеля.
Создаем Wireguard/OpenVPN/L2TP сервер на облачной виртуальной машине. При этом CHR будет выступать в качестве VPN клиента.
...код...
...скрин...

Проверим работу VPN туннеля между VPN сервером и VPN клиентом на RouterOS (CHR)
...скрин...


# Вывод
В ходе данной работы был 
