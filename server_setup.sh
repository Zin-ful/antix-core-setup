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


apt install python3 ssh wireguard gcc make wireless-regdb build-essential git cmake libpci-dev lmsensors stress s-tui openjdk-17-jdk -y 



echo "Setting up background procs"

read -p "Is this an AMD system? " confirm

if [[ $confirm == [yY] ]]; then
	echo "setting up ryzenadj"
	git clone https://github.com/FlyGoat/RyzenAdj.git
	cd RyzenAdj
	rm -r win32
	mkdir build && cd build
	cmake -DCMAKE_BUILD_TYPE=Release ..
	make
	if [ -d ~/.local/bin ]; then ln -s $(readlink -f ryzenadj) $user/.local/bin/ryzenadj && echo "symlinked to $user/.local/bin/ryzenadj"; fi
	if [ -d ~/.bin ]; then ln -s $(readlink -f ryzenadj) $user/.bin/ryzenadj && echo "symlinked to $user/.bin/ryzenadj"; fi
	cp -r /mnt/ryzenadj /etc/runit/runsvdir/default
	cp /mnt/cpuboost.sh /usr/local/bin
	cd ..
	echo "settings are default to undervolt. use 'sv disable ryzenadj' to disable undervolting. very fast processors will be significantly handicapped otherwise"

fi

read -p "Install Minecraft forge? " confirm

if [[ $confirm == [yY] ]]; then
	mkdir forgemc
	cd forgemc
	
	read -p "Fresh install? copy your servers directory to a USB and i can copy all of it to here. make sure you have the forge install file tho (name it to 'server')" confirm

	if [[ $confirm == [yY] ]]; then
		wget -O forge-1.20.1-47.4.6-installer.jar \
		"https://maven.minecraftforge.net/net/minecraftforge/forge/1.20.1-47.4.6/forge-1.20.1-47.4.6-installer.jar"
		java -jar -Djava.awt.headless=true forge-1.20.1-47.4.6-installer.jar --installServer
		echo "eula=true" > eula.txt
		
	else
		cp -r server/* ./
		java -jar -Djava.awt.headless=true forge-1.20.1-47.4.6-installer.jar --installServer
	fi
	
	
fi

read -p "Install zin-apps?" confirm

if [[ $confirm == [yY] ]]; then
	git clone https://github.com/Zin-ful/zin-minimal-suite	
fi

echo "setting up wireguard"

cp -r /mnt/wgup /etc/runit/runsvdir/default

echo "runit service made"

cp /mnt/wg0.conf /etc/wireguard
cp /mnt/public.key /etc/wireguard
cp /mnt/private.key /etc/wireguard

echo "keys and conf copied"

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
