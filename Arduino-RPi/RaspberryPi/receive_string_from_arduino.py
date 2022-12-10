#!/usr/bin/env python3
 
###############################################################################
# Receive strings From an Arduino.
###############################################################################
 
import serial
 
ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
 
# Get rid of incomplete data.
ser.flush()
 
while (1):
  if(ser.in_waiting > 0):   
    # Read everything until the new line character.
    line = ser.readline().decode('utf-8').rstrip()
     
    print(line)
