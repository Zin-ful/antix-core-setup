#!/bin/bash
read -p "Is the usb with the right files mounted? (y/n) >>> " confirm

if [[ $confirm == [nN] ]]; then
	exit 1
fi

read -p "Enter username used to login >>> " user

echo "getting NIC info."

sleep 1

echo "1. Broadcom"
echo "2. Intel"
echo "3. Realtek (might wanna skip this guy)"
echo "4. Atheros"
echo "5. Skip"
echo " "
lspci | grep -i network
echo " "

read -p "Based off the output, choose the number matching your Driver" num

case $num in
	1)
		driver="brcmsmac"
		;;	
	2)
		driver="iwlwifi"
		;;
	3)
		driver="r8169"
		;;
	4)
		driver="ath9k"
		;;
	5)
		echo "No driver"
		driver=0
		;;
	*)
		echo "invalid"
		exit 1
		;;
esac

echo "Selected $driver"

echo "continuing install in 5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1

echo "making catastrophic changes"

sleep 1

apt update

apt install extrepo

extrepo enable librewolf

apt update

apt install xserver-xorg-input-libinput xserver-xorg-input-evdev \
xserver-xorg-video-ati xserver-xorg-video-fbdev \
xserver-xorg-video-vesa xterm cmst cbatticon acpi light-locker \
sakura fluxbox-themes-antix tint2 connman pcmanfm clipit \
python3 ssh wireguard putty gcc make wireless-regdb librewolf -y 

read -p "install steam? (y/n) >>> " confirm

if [[ $confirm == [yY] ]]; then
	apt install steam-launcher
	sudo /usr/bin/steamdeps --interactive --update-apt
fi

echo "Setting up user menu"
sleep 1
cat /mnt/usr_menu > /home/$user/.fluxbox/menu
echo "setting up sys menu"
sleep 1
cat /mnt/sys_menu > /etc/X11/fluxbox/fluxbox-menu
echo "setting up startup procs"
sleep 1
cat /mnt/startup > /home/$user/.fluxbox/startup
echo "setting up xinit"
sleep 1
cat /mnt/.xinitrc > /home/$user/.xinitrc
echo "loading wireless module"
sleep 1
if [[ $driver != 0 ]]; then
	echo $driver | tee -a /etc/modules
fi
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
