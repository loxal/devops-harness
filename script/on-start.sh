#!/usr/bin/env sh

# curl -sf http://me.loxal.net/script/on-start-sky.sh | sh -s -- --yes

#couchbase() {
#    docker rm -f couchbase
#    docker run -d --name couchbase \
#        -p 8091-8094:8091-8094 -p 11210:11210 \
#        -v ~/srv/couchbase:/opt/couchbase/var/lib/couchbase \
#        couchbase:community
#}
#couchbase

#cassandra() {
#    docker rm -f cassandra
#    docker run -it -d --name cassandra \
#        -p 9042:9042 \
#        -v ~/srv/cassandra:/var/lib/cassandra \
#        cassandra:3
#}
#cassandra

#quizzer() {
#    docker rm -f quizzer
#    docker run -d -p 82:8200 -e VAULT_TOKEN=insert_token_here --name quizzer loxal/quizzer:latest
#}
#quizzer

service_kit() {
    docker rm -f service-kit
    docker run -d -p 80:8080 --name service-kit loxal/service-kit:v1
}
service_kit

teamcity_server() {
    docker rm -f teamcity-server
    docker run -d -t --name teamcity-server -v ~/srv/teamcity_server:/data/teamcity_server/datadir -v ~/srv/teamcity_server/logs:/opt/teamcity/logs -p 8111:8111 jetbrains/teamcity-server:2017.1.3

    ~/buildAgent/bin/agent.sh start # run agent on host machine
#    docker exec teamcity-server /opt/teamcity/buildAgent/bin/agent.sh start
}
teamcity_server

#teamcity_agent() {
#    docker rm -f teamcity-agent
#    docker run -d -t -e SERVER_URL="http://ci.loxal.net:8111" \
#        -e AGENT_NAME="rage" \
#        --name teamcity-agent \
#        -v ~/srv/teamcity_agent:/data/teamcity_agent/conf  \
#        jetbrains/teamcity-agent:latest
#
##    docker exec teamcity-agent "apt install openjfx" # resolves build problem w/ JavaFx
#}
#teamcity_agent

vault() {
    cd ~/minion/svc/vault
    docker-compose up -d
    # docker exec -it vault sh
    export VAULT_ADDR=http://localhost:8200

#    vault write secret/quizzer @credentials.json
}
vault

#elasticsearch() {
#        docker rm -f elasticsearch
#        docker run -d --name elasticsearch \
#            -p 9200:9200 \
#            -p 9300:9300 \
#            elasticsearch:alpine
#
##                -e transport.host=0.0.0.0 \
##        -e discovery.zen.minimum_master_nodes=1 \
#}
#elasticsearch # very dangerous when run without password protection

runNxtServer() {
    cd ~/minion/miner/nxt
    nohup ./run.sh &
    echo "runNxtServer started"

# Start forging...
#    curl 'http://localhost:7876/nxt?requestType=startForging' --data 'secretPhrase=my+secret+phrase'
}
runNxtServer

heat_ledger() {
    cd ~/minion/miner/heatledger-*
#    screen -mS heatledger bin/heatledger
    nohup bin/heatledger &
    echo "heat_ledger started"

#     curl 'http://localhost:7733/api/v1/mining/start/secret%20phrase?api_key=PASSWORD'
}
heat_ledger

runNemServer() {
    cd ~/minion/miner/nem-server
    nohup ./nix.runNis.sh &
    echo "runNemServer - nix.runNis.sh started"
#    sleep 15m
    nohup ./nix.runNcc.sh &
    echo "runNemServer - nix.runNcc.sh started"
    # start mining in browser
}
runNemServer

run_misc() {
    nohup ~/minion/miner/mine-zcash-cpu.sh &
    echo "run_misc - mine-zcash-cpu.sh started"
}
run_misc

#parity() {
#    docker rm -f parity
#    docker run -d -t --name parity  \
#        -p 8080:8080 \
#        -p 8180:8180 \
#        -p 8545:8545 \
#        -v ~/srv/parity:/root \
#        ethcore/parity:stable \
#        --jsonrpc-interface all \
#        --jsonrpc-hosts all
#
##        --jsonrpc-interface '0.0.0.0'
#}
#parity