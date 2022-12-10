#!/usr/bin/env python3
 
###############################################################################
# Send strings to an Arduino From a Raspberry Pi.
###############################################################################
 
import serial
import time
 
ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
# Get rid of incomplete data.
ser.flush()
 
while (1):
  send_string = ("Hello Arduino!\n")
  
  # Send.
  ser.write(send_string.encode('utf-8'))
   
  # Wait half a second.
  time.sleep(0.5)
 
  # Receive.
  receive_string = ser.readline().decode('utf-8').rstrip()
 
  print(receive_string)
