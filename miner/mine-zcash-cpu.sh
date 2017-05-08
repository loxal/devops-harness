#!/usr/bin/env bash

kill $(pidof nheqminer_cpu)
#git clone -b Linux https://github.com/nicehash/nheqminer.git; 
#sudo apt-get install cmake build-essential libboost-all-dev

#cd nheqminer
#git reset --hard HEAD
#cd ..
#cd nheqminer/cpu_xenoncat/Linux/asm/
#git checkout Linux
#git pull
#sh assemble.sh
#cd ../../../Linux_cmake/nheqminer_cpu
#rm CMakeCache.txt
#cmake .
#make -j $(nproc)

#./nheqminer_cpu -u t1M5m81rqayq3D1LcGNX5rpFdVpdZXTRXtJ.`hostname`-cpu -l zec-eu1.dwarfpool.com:3335 -t 7 &
~/minion/miner/nheqminer/Linux_cmake/nheqminer_cpu/nheqminer_cpu -u loxal.`hostname`-cpu -l eu.zec.slushpool.com:4444 -t 7 &
#./nheqminer_cpu -u 1CfgS6783Fb8GBEtPaa4DGtDypkC133nAw -l equihash.eu.nicehash.com:3357 -t 6 &
#./nheqminer_cpu -u 1CfgS6783Fb8GBEtPaa4DGtDypkC133nAw -l equihash.eu.nicehash.com:3357 &
#./nheqminer_cpu -u R9u7V63TLwJPH1shvAGHRG61aci61yy7RN -l komodopool.com:7778 &
#./nheqminer_cpu -u loxal.sky -l kmd.suprnova.cc:6250 &
#./nheqminer_cpu -u loxal.sky -l zec-eu.suprnova.cc:2143 &
