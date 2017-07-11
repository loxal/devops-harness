#!/usr/bin/env sh

set +o history
sudo vim /etc/update-manager/release-upgrades
sudo do-release-upgrade -q

set +o history
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ethereum/ethereum-qt -y
sudo add-apt-repository ppa:ethereum/ethereum -y
sudo apt-get update
sudo apt-get install cpp-ethereum -y

sudo apt-get install build-essential linux-source git tor  -y
sudo apt-get dist-upgrade -y

sudo modprobe -r nouveau
ethminer -F http://eth-eu.dwarfpool.com/0xb7b8893021cccdde74bf7c7188386afc4a0d844d/g2-GPU --farm-recheck 200 -G &

curl -O http://us.download.nvidia.com/XFree86/Linux-x86_64/361.28/NVIDIA-Linux-x86_64-361.28.run

sudo apt-get dist-upgrade
sudo modprobe -r nouveau
sudo sh NVIDIA-Linux-x86_64-361.28.run --silent
cat /var/log/nvidia-installer.log

# Install cpp-ethereum derivate
sudo apt-get install cmake libleveldb-dev libjsoncpp-dev libjsonrpccpp-dev nvidia-cuda-toolkit  -y

