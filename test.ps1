Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSDefaultParameterValues["*:ErrorAction"] = "Stop"

Function startTorContainer() {
    docker build --tag loxal/tor . -f container/tor.dockerfile
    docker rm -f tor
    docker run --rm -p 9030:9030 -p 9001:9001 --name tor loxal/tor
}
