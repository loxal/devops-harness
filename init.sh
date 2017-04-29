#!/usr/bin/env sh

MINION_USER=minion
MINION_HOME=~/minion/

set_hostname() {
    sudo vim /etc/hosts
    sudo vim /etc/hostname
}

set_hostname

update_system() {
    sudo apt update
    sudo apt upgrade
}

update_system

install_cuda_driver() {
    curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    sudo apt update
    sudo apt install cuda
}

install_cuda_driver

sudo adduser --gecos "" $MINION_USER sudo
sudo visudo # %sudo   ALL=(ALL:ALL) NOPASSWD:ALL
su $MINION_USER
# install  docker
# enable docker
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa
cp /root/.ssh/authorized_keys ~/.ssh/


sudo apt install tor
sudo vim /etc/tor/torrc
sudo ln -sf $MINION_HOME/tor-exit-notice.html /etc/tor/tor-exit-notice.html
sudo apt install docker.io
#sudo gpasswd -a $MINION_USER docker ## delete
sudo usermod -aG docker $MINION_USER
# install kernel 4.10
#sudo reboot
