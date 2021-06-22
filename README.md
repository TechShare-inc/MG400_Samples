# MG400_Samples
## ネットワーク連携デモ

### 概要

外部ネットワーク機器とMG400の連携デモ
今回外部ネットワーク機器にはUbuntu18.04のPCを使用

### システム構成図

![スライド2](https://user-images.githubusercontent.com/40942409/122857996-78a93200-d354-11eb-9375-9722f0346a6e.JPG)

### 使い方
- MG400側
1. DobotStudio2020を起動し,MG400と接続
2. Scriptを開き```TCPMotion.lua```を貼り付け実行

- 外部ネットワーク機器(Python実行環境があるもの)
1. MG400のLAN2と外部ネットワーク機器を接続しIPアドレスをMG400 LAN2のIPアドレス```192.168.2.6```と同一セグメントの```192.168.2.***```に設定
3. ```TCP_motion_client.py```を実行

```
Python3 TCP_motion_client.py
```
