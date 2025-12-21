#!/bin/bash

read -p "Enter username used to login >>> " user


sleep 1

apt update

apt install extrepo

extrepo enable librewolf

apt update

apt install xorg xserver-xorg-core icewm acpi light-locker build-essential git \
sakura cmst clipit volumeicon-alsa alsa-utils alsa-ucm-conf pipewire pipewire-pulse wireplumber \
python3 ssh wireguard putty gcc make librewolf flatpak codelite -y

read -p "install steam? (y/n) >>> " confirm

if [[ $confirm == [yY] ]]; then
	apt install steam-installer
fi

echo "Setting up user menu"
sleep 1
cat icemenu > /home/$user/.icewm/menu
echo "setting up startup procs"
sleep 1
cat icestartup > /home/$user/.icewm/startup
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
