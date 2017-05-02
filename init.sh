#!/usr/bin/env sh

CANONICAL_LIVEPATCH_TOKEN=INSERT_YOUR_TOKEN_HERE
MINION_USER=minion

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

activate_ssh_login() {
    ssh-keygen -t rsa
    sudo cp /root/.ssh/authorized_keys ~/.ssh/
}

add_user() {
    sudo adduser --gecos "" $MINION_USER
    sudo usermod -aG sudo $MINION_USER
    sudo usermod --lock $MINION_USER
    sudo visudo # %sudo   ALL=(ALL:ALL) NOPASSWD:ALL
    su $MINION_USER

    activate_ssh_login
}

add_user

MINION_HOME=~/minion/
git clone https://github.com/loxal/minion.git

install_cuda_driver() {
    cd $MINION_HOME
    mkdir tmp

    curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    sudo apt update
#    sudo apt install cuda
#    sudo apt install cuda-core-8-0
#    sudo apt install cuda-toolkit-8-0
    sudo apt install cuda-drivers
}

install_cuda_driver

setup_docker() {
    sudo apt install docker.io
    sudo usermod -aG docker $MINION_USER
#    sudo gpasswd -a $MINION_USER docker ## delete
#    sudo systemctl restart docker
}

setup_kernel() {
    sudo apt install linux-image-4.10.0-20-generic linux-headers-4.10.0-20 linux-headers-4.10.0-20-generic linux-image-4.10.0-20-generic linux-image-extra-4.10.0-20-generic
    sudo apt remove linux-image-4.8.0-* linux-headers-4.8.0-* linux-image-extra-4.8.0-*

    sudo apt install snapd
    sudo snap install canonical-livepatch
    sudo canonical-livepatch enable $CANONICAL_LIVEPATCH_TOKEN
}

setup_kernel

setup_tor() {
    sudo apt install tor
    sudo ln -s $MINION_HOME/tor-exit-notice.html /etc/tor/tor-exit-notice.html
    sudo vim /etc/tor/torrc
}

setup_compilation() {
    sudo apt-get install cmake libboost-all-dev
}

setup_compilation

sudo reboot