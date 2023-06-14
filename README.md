Copyright © 2021 TechShare Inc. All Rights Reserved.

# MG400_Samples
## ネットワーク連携デモ

### 概要

外部ネットワーク機器とMG400の連携デモ
今回外部ネットワーク機器にはUbuntu18.04のPCを使用
こちらのプログラムはMG400のファームウェアバージョン1.5.6.0以下向けの物です。


### システム構成図

![スライド2](https://user-images.githubusercontent.com/40942409/122858124-b6a65600-d354-11eb-8352-8e0c269af6ed.JPG)

### 使い方
- MG400側
1. WindowsPCのDobotStudio2020を起動しMG400のLAN1と接続
2. Scriptを開き```TCPMotion.lua```を貼り付け実行

- Ubuntu側
1. Ubuntu PCとMG400のLAN2を接続し、IPアドレスをMG400 LAN2のIPアドレス```192.168.2.6```と同一セグメントの```192.168.2.***```に設定
3. ```TCP_motion_client.py```を実行

```
Python3 TCP_motion_client.py
```
Copyright © 2021 TechShare Inc. All Rights Reserved.
