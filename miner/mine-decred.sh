#!/usr/bin/env bash

kill $(pidof ccminer)

#~/mine/ccminer/ccminer -o stratum+tcp://decred.mine.zpool.ca:5744 -u 12JmNnKq88osZD9xXxNkocLA6i37mz73Fj  -p c=BTC -a decred --resume-diff=8 --max-diff=64 &
#~/mine/ccminer/ccminer -o stratum+tcp://decred.mine.zpool.ca:5744 -u 12JmNnKq88osZD9xXxNkocLA6i37mz73Fj  -p c=BTC -a decred --resume-diff=8 &
ccminer/ccminer -o stratum+tcp://yiimp.ccminer.org:3252 -u DsYin2eEW4s1WWayTUAerARt9jC3edPVrun  -p c=DCR -a decred --resume-diff=8 --show-diff &
#~/mine/ccminer/ccminer -o stratum+tcp://decred.mine.zpool.ca:5744 -u 12JmNnKq88osZD9xXxNkocLA6i37mz73Fj  -p c=BTC -a decred --background &
