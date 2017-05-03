#!/usr/bin/env bash

kill $(pidof ethminer)
ethminer --opencl --farm http://eth-eu.dwarfpool.com/0xfFf43434509Ed7BE4151f69158b9050c7AF331a8/`hostname`-gpu --disable-submit-hashrate &
