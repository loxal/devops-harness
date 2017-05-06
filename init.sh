#!/usr/bin/env sh

CANONICAL_LIVEPATCH_TOKEN=INSERT_YOUR_TOKEN_HERE
MINION_USER=minion
MINION_HOME=~/${MINION_USER}/

set_hostname() {
    sudo vim /etc/hosts
    sudo vim /etc/hostname
}

set_hostname

activate_ssh_login() {
    ssh-keygen -t rsa
    sudo mv /root/.ssh/authorized_keys ~/.ssh/
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

update_system() {
    sudo apt update
    sudo apt upgrade
    sudo apt install git

    setup_minion_tool

    sudo cp ubuntu/etc/apt/sources.list /etc/apt/sources.list
}

update_system

setup_minion_tool() {
    MINION_HOME=~/${MINION_USER}/
    git clone https://github.com/loxal/minion.git

    cd $MINION_HOME/miner
    git submodule init
    git submodule update
}

install_cuda_driver() {
    curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    sudo dpkg -i cuda-repo-*.deb
    rm cuda-repo-*.deb
    sudo apt update
#    sudo apt install cuda
#    sudo apt install cuda-core-8-0
#    sudo apt install cuda-toolkit-8-0
    sudo apt install cuda-drivers # sufficient for GPU mining
}

install_cuda_driver

setup_docker() {
    sudo apt install docker.io
    sudo usermod -aG docker $MINION_USER
}

setup_kernel() {
    sudo apt install linux-image-4.10.0-21-generic linux-headers-4.10.0-21 linux-headers-4.10.0-21-generic linux-image-4.10.0-21-generic linux-image-extra-4.10.0-21-generic
    sudo apt remove linux-image-4.8.0-* linux-headers-4.8.0-* linux-image-extra-4.8.0-*

    sudo apt install snapd
    sudo snap install canonical-livepatch
    sudo canonical-livepatch enable $CANONICAL_LIVEPATCH_TOKEN
}

setup_kernel

setup_tor() {
    sudo apt install tor
    sudo cp $MINION_HOME/ubuntu/etc/tor/tor-exit-notice.html /etc/tor/tor-exit-notice.html
    sudo vim /etc/tor/torrc
}

setup_compilation() {
    sudo apt-get install cmake libboost-all-dev
}

setup_compilation

sudo reboot