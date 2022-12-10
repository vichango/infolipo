#!/usr/bin/env python3

from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import BlockingOSCUDPServer

import serial
import time
 
ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
# Get rid of incomplete data.
ser.flush()

def print_handler(address, *args):
    print(f"{address}: {args}")

def send_to_arduino(address, *args):
    send_string = f("{args}\n")
    ser.write(send_string.encode('utf-8'))

def default_handler(address, *args):
    print(f"DEFAULT {address}: {args}")

dispatcher = Dispatcher()
dispatcher.map("/note*", send_to_arduino)
dispatcher.set_default_handler(default_handler)

ip = "192.168.0.255"
port = 12000

server = BlockingOSCUDPServer((ip, port), dispatcher)
server.serve_forever()  # Blocks forever
