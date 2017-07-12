#!/usr/bin/env sh

setup_env() {
    CANONICAL_LIVEPATCH_TOKEN=INSERT_YOUR_TOKEN_HERE
    MINION_USER=alex
    MINION_HOME=~/minion/
    HOSTNAME_NEW=sky
}

set_hostname() {
    sudo vim /etc/hosts
    sudo vim /etc/hostname
    sudo hostname -F /etc/hostname
    exit
}
set_hostname

activate_ssh_login() {
    ssh-keygen -t rsa
    sudo cp /root/.ssh/authorized_keys ~/.ssh/
    sudo chown alex:alex ~/.ssh/authorized_keys
}

add_user() {
    sudo adduser --gecos "" $MINION_USER # interactive
    sudo usermod -aG sudo $MINION_USER
    sudo usermod --lock $MINION_USER
    sudo visudo # %sudo   ALL=(ALL:ALL) NOPASSWD:ALL
    su $MINION_USER

    activate_ssh_login
}
add_user

setup_minion_tool() {
    setup_env
    cd
    git clone https://github.com/loxal/minion.git

    cd $MINION_HOME/miner
    git submodule init
    git submodule update
}

update_system() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y git
    sudo apt install -y screen

    setup_minion_tool

    sudo cp $MINION_HOME/ubuntu/etc/apt/sources.list /etc/apt/sources.list
    sudo apt install -y unattended-upgrades
}
update_system

install_cuda_driver() {
    curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
    sudo dpkg -i cuda-repo-*.deb
    rm cuda-repo-*.deb
    sudo apt update
    sudo apt install -y cuda-drivers
}
#install_cuda_driver

setup_docker() {
    sudo apt install -y docker.io
    sudo usermod -aG docker $MINION_USER
}
setup_docker

setup_essentials() {
    sudo apt-get install -y cmake libboost-all-dev screen unzip openjdk-8-jdk-headless cmake build-essential libboost-all-dev
}
setup_essentials

setup_tor() {
    sudo apt install -y tor
    sudo cp $MINION_HOME/ubuntu/etc/tor/tor-exit-notice.html /etc/tor/tor-exit-notice.html
    sudo vim /etc/tor/torrc
}
setup_tor

setup_kernel() {
    OLD_KERNEL_VERSION=4.8.0-58
    KERNEL_VERSION=4.10.0-27
    sudo apt install -y linux-image-$KERNEL_VERSION-generic linux-headers-$KERNEL_VERSION linux-headers-$KERNEL_VERSION-generic linux-image-$KERNEL_VERSION-generic linux-image-extra-$KERNEL_VERSION-generic
    sudo apt remove -y linux-image-$OLD_KERNEL_VERSION-* linux-headers-$OLD_KERNEL_VERSION-* linux-image-extra-$OLD_KERNEL_VERSION-*
    sudo apt remove -y linux-image-4.8.0-* linux-headers-4.8.0-* linux-image-extra-4.8.0-*

    sudo apt install -y snapd
    sudo snap install canonical-livepatch
    sudo canonical-livepatch enable $CANONICAL_LIVEPATCH_TOKEN

    sudo reboot
}
setup_kernel

setup_nxt_ledger() {
    cd ~/minion/miner
    curl -LO https://bitbucket.org/JeanLucPicard/nxt/downloads/nxt-client-1.11.5.zip
    unzip nxt-client-*.zip
    cd nxt
    ./run.sh &
#    curl 'http://localhost:7876/nxt?requestType=startForging' --data 'secretPhrase=my+secret+phrase'
}
setup_nxt_ledger

setup_heat_ledger() {
#    https://heatbrowser.com/report.html
#    http://heatnodes.org/?page_id=329
#    https://heatwallet.com/nodes.cgi

    HOST_NAME=`hostname`.loxal.net
    SECRET_PHRASE_WITHOUT_BLANK_SPACES=INSERT_SECRET_PHRASE
    HEAT_API_KEY=INSERT_API_KEY
    HEAT_VERSION=1.1.0

    cd ~/minion/miner
    curl -LO https://github.com/Heat-Ledger-Ltd/heatledger/releases/download/v${HEAT_VERSION}/heatledger-${HEAT_VERSION}.zip
    unzip heatledger-*.zip
    cd heatledger-*

    # download blockchain
    curl -LO https://heatbrowser.com/blockchain.tgz
    tar xzvf blockchain.tgz
    rm blockchain.tgz

#    cp conf/heat-default.properties conf/heat.properties
#    cp ../heatledger-vPrevious/conf/heat-default.properties conf/heat.properties
    vim conf/heat.properties

    screen -mS heatledger bin/heatledger

    # on sky.loxal.net or any other server running a HEAT node
    # curl http://localhost:7733/api/v1/tools/hallmark/encode/${HOST_NAME}/200/2016-01-01/${SECRET_PHRASE_WITHOUT_BLANK_SPACES} # obtain hallmark

    # wait until chain is synced
    curl http://localhost:7733/api/v1/mining/start/${SECRET_PHRASE_WITHOUT_BLANK_SPACES}?api_key=${HEAT_API_KEY} # start forging, replace secret phrase’ spaces with “%20”
}
setup_heat_ledger
