#!/usr/bin/env sh

# curl -sf http://me.loxal.net/script/on-start-sky.sh | sh -s -- --yes

runNemServer() {
    cd ~/minion/miner/nem-server
    ./nix.runNis.sh &
    sleep 15m
    ./nix.runNcc.sh &
}

run_misc() {
    ~/minion/miner/mine-zcash-cpu.sh
    ~/minion/miner/mine-zcash-gpu-cuda.sh
    ~/buildAgent/bin/agent.sh start

    runNemServer
}
run_misc

couchbase() {
    docker rm -f couchbase
    docker run -d --name couchbase \
        -p 8091-8094:8091-8094 -p 11210:11210 \
        -v ~/srv/couchbase:/opt/couchbase/var/lib/couchbase \
        couchbase:community
}
couchbase

cassandra() {
    docker rm -f cassandra
    docker run -it -d --name cassandra \
        -p 9042:9042 \
        -v ~/srv/cassandra:/var/lib/cassandra \
        cassandra:3
}
cassandra

quizzer() {
    docker rm -f quizzer
    docker run -d -p 82:8200 -e VAULT_TOKEN=insert_token_here --name quizzer loxal/quizzer:latest
}
quizzer

service_kit() {
    docker rm -f service-kit
    docker run -d -p 80:8080 --name service-kit loxal/service-kit:v1
}
service_kit

teamcity_server() {
    docker rm -f teamcity-server
    docker run -d -t --name teamcity-server  \
        -v ~/srv/teamcity_server:/data/teamcity_server/datadir \
        -v ~/srv/teamcity_server/logs:/opt/teamcity/logs  \
        -p 8111:8111 \
        jetbrains/teamcity-server:latest

#    docker exec teamcity-server /opt/teamcity/buildAgent/bin/agent.sh start
}
teamcity_server

teamcity_agent() {
    docker rm -f teamcity-agent
    docker run -d -t -e SERVER_URL="http://ci.loxal.net:8111" \
        -e AGENT_NAME="rage" \
        --name teamcity-agent \
        -v ~/srv/teamcity_agent:/data/teamcity_agent/conf  \
        jetbrains/teamcity-agent:latest

#    docker exec teamcity-agent apt install openjfx # resolves build problem w/ JavaFx
}
#teamcity_agent

vault() {
    docker-compose up -d
    export VAULT_ADDR=https://sky.loxal.net:8200
}
vault

elasticsearch() {
        docker rm -f elasticsearch
        docker rm -f elas
        docker run --name elasticsearch \
            -p 9200:9200 \
            -p 9300:9300 \
            elasticsearch:alpine

#                -e transport.host=0.0.0.0 \
#        -e discovery.zen.minimum_master_nodes=1 \
}
elasticsearch

heat_ledger() {
    cd ~/minion/miner/heatledger-*
#    screen -mS heatledger bin/heatledger
    bin/heatledger & 
}
heat_ledger

parity() {
    docker rm -f parity
    docker run -d -t --name parity  \
        -p 8080:8080 \
        -p 8180:8180 \
        -p 8545:8545 \
        -v ~/srv/parity:/root \
        ethcore/parity:stable \
        --jsonrpc-interface all \
        --jsonrpc-hosts all

#        --jsonrpc-interface '0.0.0.0'
}
#parity