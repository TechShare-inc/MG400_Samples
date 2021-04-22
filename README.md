# MG400_Samples
## UDPServer.lua
### 説明
外部機器からUDP信号を受信する

### 使い方
1. MG400内で"UDPServer"を実行
2. MG400 LAN2 に外部PCをインターネット接続し,UDPデータを送信
```
nc -u 192.168.2.6 6200
```
## UDPmotion.lua(※注意!! UDPだと送り手がMG400が動作終了したか分からず,次のコマンドの送信タイミングが分からないため使いづらい 非推奨!!)
### 説明
外部機器からxyz(float,float,float)をUDPで送信,MG400は送られたxyz位置へ移動

### 使い方
1. MG400内で"UDPmotion.lua"を実行
2. 外部PCから座標を送信
```
Python3 UDP_send_xyz.py
```

## Go_xyzr.lua
### 説明
Pointsリストを使用しないでPointを定義
