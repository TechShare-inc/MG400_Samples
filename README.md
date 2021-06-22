# MG400_Samples
## ネットワーク連携
### 概念図

![スライド2](https://user-images.githubusercontent.com/40942409/122847881-78ed0180-d343-11eb-8866-aa7265b3f05f.JPG)


### 説明
外部機器からTCPで移動座標をMG400に送る

### 使い方
1. MG400内で"TCPMotion.lua"を実行
2. 外部PCで,以下を実行
```
Python3 TCP_motion_client.py
```
