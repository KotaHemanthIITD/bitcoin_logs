#!/usr/bin/env bash
MINER1_PORT="18444"
MINER2_PORT="17444"

MDF_ND1_PORT="8011"
MDF_ND2_PORT="8012"

MINER_DIR="/Users/Chaitra/Documents/bitcoin/miner"
MDF_DIR="/Users/Chaitra/Documents/bitcoin/mdfnd"

GLDFISH_DIR="/Users/Chaitra/Documents/marlin/goldfish.cpp/"

MULTICAST_DIR="/Users/Chaitra/Documents/marlin/multicastsdk.cpp/"

echo "Starting Bitcoin Miner 1..."

#Setting Marlin environment
${GLDFISH_DIR}"build/"goldfish &

#Running Marlin Node 1
${MULTICAST_DIR}"build/"multicastTcpServer "127.0.0.1:9002" "1" &

#Running Marlin Node 2
${MULTICAST_DIR}"build/"multicastTcpServer "127.0.0.1:9002" "2" &

# Running Bitcoin Miner 1
bitcoind

#Running Bitcoin Miner 2
MNR1="${MINER_DIR}1/"
${MNR1}bitcoind -conf=${MNR1}bitcoin.conf -datadir=${MNR1}

# Running Modified Bitcoin Node 1
MDF1="${MDF_DIR}1/"
${MDF1}bitcoind -conf=${MDF1}bitcoin.conf -datadir=${MDF1}

# Running Modified Bitcoind Node 2
MDF2="${MDF_DIR}2/"
${MDF2}bitcoind -conf=${MDF2}bitcoin.conf -datadir=${MDF2}

echo "End of Shell Script"
