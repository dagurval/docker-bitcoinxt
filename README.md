Bitcoin XT for Docker
===================

Docker image that runs a bitcoinxt node in a container for easy deployment.

Bitcoin XT will connect to the _Bitcoin Cash (BCC)_ network by default. To connect to the _Bitcoin (BTC)_ network, pass command-line parameter `-uahftime=0` using the docker run command.

Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. Vultr, Digital Ocean, KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 200 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Quick Start
-----------

1. Create a `bitcoind-data` volume to persist the bitcoind blockchain data, should exit immediately.  The `bitcoind-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker run --name=bitcoind-data -v /bitcoin busybox chown 1000:1000 /bitcoin

        docker run --volumes-from=bitcoind-data --name=bitcoind-node -d \
          -p 8333:8333 \
          -p 127.0.0.1:8332:8332 \
          bitcoinxt/bitcoinxt

2. Verify that the container is running and bitcoind node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        bitcoinxt/bitcoinxt:latest     "btc_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:8332->8332/tcp, 0.0.0.0:8333->8333/tcp   bitcoind-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f bitcoind-node

4. You can pass any parameters you want to the bitcoinxt process using the docker run command:

  Example to enable stealth mode:

        docker run --volumes-from=bitcoind-data --name=bitcoind-node -d \
          -p 8333:8333 \
          -p 127.0.0.1:8332:8332 \
          bitcoinxt/bitcoinxt \
          -rpcallowip=::/0 -stealth-mode

Credits
-----------

Original creator of docker-bitcoinxt [5an1ty](https://github.com/5an1ty/docker-bitcoinxt)
Original creator of [docker-bitcoind](https://github.com/kylemanna/docker-bitcoind) kylemanna
