#!/bin/sh

# Based on https://github.com/nekonenene/vagrant-ubuntu-gui/blob/master/Vagrantfile

apt-get update

apt-get install -y \
    ubuntu-desktop \
    python3 \
    python3-pip

reboot
