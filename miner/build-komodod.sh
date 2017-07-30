#!/usr/bin/env bash

sudo apt-get install build-essential pkg-config libcurl-gnutls-dev libc6-dev \
    libevent-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python \
    zlib1g-dev wget bsdmainutils automake libboost-all-dev libssl-dev \
    libprotobuf-dev protobuf-compiler libqt4-dev libqrencode-dev libdb++-dev ntp ntpdate
    
git clone https://github.com/jl777/komodo.git
cd komodo
./zcutil/fetch-params.sh
./zcutil/build.sh -j $(nproc)

cd ~
mkdir .komodo
cd .komodo
vim komodo.conf

#Add the following lines to the komodo.conf file:

#rpcuser=bitcoinrpc
#rpcpassword=password
#txindex=1
#addnode=5.9.102.210
#addnode=78.47.196.146
#addnode=178.63.69.164
#addnode=88.198.65.74
#addnode=5.9.122.241
#addnode=144.76.94.38
#addnode=89.248.166.91

./src/komodo-cli validateaddress R9u7V63TLwJPH1shvAGHRG61aci61yy7RN
./src/komodo-cli dumpprivkey R9u7V63TLwJPH1shvAGHRG61aci61yy7RN
./src/komodo-cli getinfo
./src/komodod -gen -genproclimit=2 -notary -pubkey="76a91406cb23dcc2f6c42c1ca274ee956c3eb8b9b4facf88ac" &

