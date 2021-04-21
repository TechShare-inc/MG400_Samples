from socket import socket, AF_INET, SOCK_DGRAM
import os
import struct
import ctypes

class PacketUDP(ctypes.Structure):
    _fields_ = [
        ("x", ctypes.c_float),
        ("y", ctypes.c_float),
        ("z", ctypes.c_float),
    ]

PORT = 6200
ADDRESS = "192.168.2.6" # A1 Atom IP adress

sk = socket(AF_INET, SOCK_DGRAM)


data = PacketUDP(300.0,50.0,100.0)

sk.sendto(data ,(ADDRESS, PORT))

sk.close()
