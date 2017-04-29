#!/usr/bin/env sh

git clone git@github.com:loxal/devops-harness.git 

MINION_USER=minion
MINION_HOME=~/minion/

sudo vim /etc/hosts
sudo vim /etc/hostname

sudo apt update
sudo apt upgrade

sudo adduser --disabled-password --gecos $MINION_USER sudo
sudo visudo # %sudo   ALL=(ALL:ALL) NOPASSWD:ALL
su $MINION_USER

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt update
sudo apt install cuda

# install  docker
# enable docker
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa


sudo apt install tor
sudo vim /etc/tor/torrc
sudo ln -sf $MINION_HOME/tor-exit-notice.html /etc/tor/tor-exit-notice.html
sudo apt install docker.io
#sudo gpasswd -a $MINION_USER docker ## delete
sudo usermod -aG docker MINION_USER 
# install kernel 4.10
sudo reboot
