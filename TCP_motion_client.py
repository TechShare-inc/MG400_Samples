# -*- coding : UTF-8 -*-

# 0.ライブラリのインポートと変数定義
import socket
import os
import struct
import ctypes

class PacketMoveXYZ(ctypes.Structure):
    _fields_ = [
        ("id", ctypes.c_float),
        ("x", ctypes.c_float),
        ("y", ctypes.c_float),
        ("z", ctypes.c_float),
    ]


class PacketPomp(ctypes.Structure):
    _fields_ = [
        ("id", ctypes.c_float),
        ("pwr", ctypes.c_float),
        ("dir", ctypes.c_float),
    ]


target_ip = "192.168.2.6"
target_port = 6001
buffer_size = 300000

# 1.ソケットオブジェクトの作成
tcp_client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# 2.サーバに接続
tcp_client.connect((target_ip,target_port))


def move_xyz(x,y,z):

    # 3.サーバにデータを送信
    data = PacketMoveXYZ(1,x,y,z)
    tcp_client.send(data)

    # 4.サーバからのレスポンスを受信
    response = tcp_client.recv(300)
    print("[*]Received a response : {}".format(response))

def pomp(p,d):

    # 3.サーバにデータを送信
    data = PacketPomp(2,p,d)
    tcp_client.send(data)

    # 4.サーバからのレスポンスを受信
    response = tcp_client.recv(300)
    print("[*]Received a response : {}".format(response))


move_xyz(300,0,50)

while True:
    move_xyz(300,-50,50)
    pomp(1,1)
    move_xyz(300,50,50)
    pomp(0,0)
