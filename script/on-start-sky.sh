#!/usr/bin/env sh

# curl -sf http://me.loxal.net/script/on-start-sky.sh | sh -s -- --yes

run_misc() {
    ~/mine/mine-zcash-cpu.sh
    ~/mine/mine-zcash-gpu-cuda.sh
}

run_misc

couchbase() {
    docker rm -f couchbase
    docker run -d --name couchbase \
        -p 8091-8094:8091-8094 -p 11210:11210 \
        -v ~/srv/couchbase:/opt/couchbase/var/lib/couchbase/data \
        couchbase:community
}

couchbase

cassandra() {
    docker rm -f cassandra
    docker run -it -d --name cassandra \
        -p 9042:9042 \
        cassandra:3
}

cassandra

quizzer() {
    docker rm -f quizzer
    docker run -d -p 82:8200 --name quizzer loxal/quizzer:v1
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

teamcity_agent

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

parity