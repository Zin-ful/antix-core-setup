#!/bin/bash
read -p "Is the usb with the right files mounted? (y/n) >>> " confirm

if [[ $confirm == [nN] ]]; then
	exit 1
fi

read -p "Enter username used to login >>> " user

echo "getting NIC info."

sleep 1

lspci | grep -i network

echo "continuing install in 5"
#sleep 1
echo "4"
#sleep 1
echo "3"
#sleep 1
echo "2"
#sleep 1
echo "1"
#sleep 1

echo "making catastrophic changes"

sleep 1

#apt update

echo "installing apps"

sleep 1


apt install nano curl unzip zip htop iotop strace ltrace screen dfu-util \
avrdude python3-full python3-venv python3-pip python3-dev gdb libasound2-dev \
portaudio19-dev alsa-utils ssh wireguard uefitool-cli gcc binwalk flashrom make \
wireless-regdb build-essential git cmake libpci-dev lm-sensors micropython-mpremote \
nmap ripgrep picocom minicom lzop acpica-tools \
fdisk parted testdisk \
dmidecode pciutils usbutils spi-tools i2c-tools coreboot-utils efivar efibootmgr \
pipx tcpdump ethtool openjdk-17-jre openjdk-17-jdk -y

echo "downloading micropy for rp2040"

wget https://micropython.org/resources/firmware/rp2-pico-20241130.uf2

sleep 1



sleep 1

read -p "Install zin-apps?" confirm

if [[ $confirm == [yY] ]]; then
	git clone https://github.com/Zin-ful/zin-minimal-suite	
fi

echo "setting up wireguard"

cp -r /mnt/wgup /etc/runit/runsvdir/default

echo "runit service made"

echo "rebooting in 5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
reboot
