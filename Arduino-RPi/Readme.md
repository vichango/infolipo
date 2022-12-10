## 2 way communication

1. Check that Python is installed in RPi:
	```sh
	$ python --version
	# Python 2.7.16
	$ python3 --version
	# Python 3.7.3
	```
2. Install the PySerial package.
	- Install Python3's `pip` module if missing:
		```sh
		# Install pip if missing.
		$ python3 -m pip --version).
		$ sudo apt install python3-pip
		```
	- Install package:
		```sh
		$ python3 -m pip install pyserial
		```
	- Add to path in `.profile`
		```
		PATH="$HOME/.local/bin:$PATH"
		```
3. Find out what port is used by the Arduino when connected:
	```sh
	$ ls /dev/tty*
	# [...] /dev/ttyACM0 [...]
	```
	- Use this command for other information: `lsusb`
4. Change the baud rate for that port to `9600`:
	```sh
	$ stty -F /dev/ttyACM0 9600
	# Check with: stty -F /dev/ttyACM0
	```


https://python-osc.readthedocs.io/en/latest/server.html

([Source](https://automaticaddison.com/2-way-communication-between-raspberry-pi-and-arduino/))

## Installing Arduino software in RPi Lite

([Source](https://dle-dev.com/index.php/en/2020/07/30/program-an-arduino-with-a-raspberry-pi-via-ssh/))