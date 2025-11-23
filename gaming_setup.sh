#!/bin/bash

echo "Enter username used to login"

read -p ">>> " user

apt update

apt upgrade -y

apt install xorg xserver-xorg light-locker \
fluxbox-themes-antix connman \
python3 ssh wireguard putty gcc make \
wireless-regdb seamonkey codelite steam-installer \
retroarch -y 

echo "setting up xinit"
sleep 1
echo '#!/bin/bash' > /home/$user/.xinitrc
exec icewm >> /home/$user/.xinitrc
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
