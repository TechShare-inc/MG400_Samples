# MG400_Samples
## ネットワーク連携デモ

### 説明

外部ネットワーク機器とMG400の連携のデモです。  
汎用的なネットワークプロトコルのTCPを使用することで例えば,PC,PLCやシングルボードコンピュータ(Raspberry Pi等)とMG400を連携することができます。  

### 概念図

![スライド2](https://user-images.githubusercontent.com/40942409/122848171-fb75c100-d343-11eb-99d1-82a356a672a0.JPG)

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
