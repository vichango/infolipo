# README

The goal of this project is to document one way to take advantage of the OSC broadcasting put in place in an Arduino based project by using an old RaspberryPi as relay.

Contents:

- `RaspberryPi/listen-osc.py` - Listens to OSC messages sent by Max and relays them on the serial port.
- `Arduino/receive-from-rpi` - Listens to the messages relayed by the RPi and turns the built-in LED on or off according to the received MIDI note.

The Max patch `Random OSC.maxpat`  in the `Tools` root folder can be used to generate pseudo random messages using the current predetermined format.

## Installation

### RPi

Instructions followed on a RaspberryPi 1 Model B ([source](https://automaticaddison.com/2-way-communication-between-raspberry-pi-and-arduino/)).

1. Check that Python3 is installed:
  ```sh
  $ python3 --version
  # Python 3.7.3
  ```
2. Install Python's pip module if missing.
  ```sh
  # Install pip, if missing.
  $ python3 -m pip --version
  $ sudo apt install python3-pip
  ```
3. Install the PySerial module.
  ```sh
  $ python3 -m pip install pyserial
  ```
  - Add to path in `.profile`
    ```
    PATH="$HOME/.local/bin:$PATH"
    ```
4. Find out what port is used by the Arduino when connected.
  ```sh
  $ ls /dev/tty*
  # [...] /dev/ttyACM0 [...]
  ```
5. Configure the baud rate for that port to `9600`:
  ```sh
  $ stty -F /dev/ttyACM0 9600
  # Check with: stty -F /dev/ttyACM0
  ```

---

## Further reading

- An OSC library for Python: https://python-osc.readthedocs.io/en/latest/server.html
- The source for the RPi installation also contains scripts demonstrating the 2-way communication between an RPi and an Arduino card via the USB cable: https://automaticaddison.com/2-way-communication-between-raspberry-pi-and-arduino/
- How to program an Arduino with a RPi via SSH: https://dle-dev.com/index.php/en/2020/07/30/program-an-arduino-with-a-raspberry-pi-via-ssh/
