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

def move_xyz(x,y,z):
    data = PacketUDP(x,y,z)
    sk.sendto(data ,(ADDRESS, PORT))

move_xyz(300,0,50)

while True:
    move_xyz(300,-50,50)
    move_xyz(300,50,50)

sk.close()
