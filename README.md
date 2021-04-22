# MG400_Samples
- TCPMotion.lua
### 説明
外部機器からxyz(float,float,float)をTCPで送信,MG400は送られたxyz位置へ移動

### 使い方
1. MG400内で"TCPMotion.lua"を実行
2. 外部PCから座標を送信
```
Python3 TCP_motion_client.py
```
