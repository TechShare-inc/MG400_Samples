# MG400_Samples
## UDPServer.lua
### 使い方
1. MG400内で"UDPServer"を実行
2. MG400 LAN2 に外部PCをインターネット接続し,UDPデータを送信
```
nc -u 192.168.2.6 6200
```
## UDPmotion.lua
### 使い方
1. MG400内で"UDPmotion.lua"を実行
2. 外部PCから座標を送信
```
Python3 UDP_send_xyz.py
```
