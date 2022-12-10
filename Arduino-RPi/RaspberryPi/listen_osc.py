#!/usr/bin/env python3

from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import BlockingOSCUDPServer

import serial
import time
 
# Sending.
ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
ser.flush() # Get rid of incomplete data.

print("Getting ready.")

def print_and_send(address, *args):
    send_string = f"{args}\n"
    ser.write(send_string.encode('utf-8'))
    print(f"Will send /note {address}: {send_string}")

def default_handler(address, *args):
    print(f"(unknown) not sent {address}: {args}")

dispatcher = Dispatcher()
dispatcher.map("/note*", print_and_send)
dispatcher.set_default_handler(default_handler)

ip = "192.168.0.255"
port = 12000

server = BlockingOSCUDPServer((ip, port), dispatcher)
server.serve_forever() # Blocks forever
