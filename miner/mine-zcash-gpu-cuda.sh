#!/usr/bin/env bash

# Download https://drive.google.com/drive/folders/0B9EPp8NdigFibDl2MmdXaTFjWDQ

kill $(pidof ewbf.bin)

#~/minion/miner/ewbf-0.3.3b.bin --user loxal.vox-gpu --server eu.zec.slushpool.com --port 4444 --pass x --fee 0 &
#./ewbf.bin --user t1M5m81rqayq3D1LcGNX5rpFdVpdZXTRXtJ.`hostname`-gpu --server zec-eu1.dwarfpool.com --port 3336 --pass x --fee 0.001 &
SCRIPT_LOCATION="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"  # alternatively: $(dirname "$0")
${SCRIPT_LOCATION}/ewbf.bin --user loxal.`hostname`-gpu --server eu.zec.slushpool.com --port 4444 --pass x --fee 0.0 &

#./nheqminer_cuda_tromp -u t1M5m81rqayq3D1LcGNX5rpFdVpdZXTRXtJ -l zec-eu1.dwarfpool.com:3335 -t 0 -cd 0 &
#./nheqminer_cuda_tromp -u loxal.sun-gpu -l eu.zec.slushpool.com:4444 -t 0 -cd 0 &
#./nheqminer_cuda_tromp -u 12JmNnKq88osZD9xXxNkocLA6i37mz73Fj -l equihash.eu.nicehash.com:3357 -t 0 -cd 0 &
#./nheqminer_cpu -u 1CfgS6783Fb8GBEtPaa4DGtDypkC133nAw -l equihash.eu.nicehash.com:3357 -t 6 &
#./nheqminer_cpu -u 1CfgS6783Fb8GBEtPaa4DGtDypkC133nAw -l equihash.eu.nicehash.com:3357 &

#./nheqminer_cuda_tromp -help
#./nheqminer_cuda_tromp -ci

#./nheqminer_cpu -u R9u7V63TLwJPH1shvAGHRG61aci61yy7RN -l komodopool.com:7778 &
#./nheqminer_cpu -u loxal.sky -l kmd.suprnova.cc:6250 &
#./nheqminer_cpu -u loxal.sky -l zec-eu.suprnova.cc:2143 &
#./nheqminer_cuda_tromp -u loxal.sun -l zcl.suprnova.cc:4042 &
