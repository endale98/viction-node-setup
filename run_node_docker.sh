#!/bin/bash

# Set variables
DATA_DIR="$(pwd)/nodes/1"
KEYSTORE_DIR="$(pwd)/keystore/1"
PASSWORD_FILE="$(pwd)/pw.json"
NODE_IDENTITY="NODE1"
UNLOCK_ADDRESS="0x79d3620f9379d043eaea262f1cac689fc906d5a1"
BOOTNODE_URL="enode://d2bb804ef44d29fa98a422d2cebaded916641f6fc78cb8f5bb666748ac7c22cc8019b7f4ce19aac76b89d9943686d1cebd34fe2230063fa1ffdb82ce5b939bb5@[::]:30301"

# Create data and keystore directories if they don't exist
mkdir -p "$DATA_DIR"
mkdir -p "$KEYSTORE_DIR"

# Run the Docker container
docker run -d \
  --name viction-node \
  -p 10303:10303 \
  -p 1545:1545 \
  -p 1546:1546 \
  -v "$DATA_DIR":/viction/data \
  -v "$KEYSTORE_DIR":/viction/keystore \
  -v "$PASSWORD_FILE":/viction/password.txt \
  viction-node \
  --syncmode "full" \
  --datadir /viction/data \
  --networkid 3172 \
  --port 10303 \
  --keystore /viction/keystore \
  --password /viction/password.txt \
  --rpc \
  --rpccorsdomain "*" \
  --rpcaddr "0.0.0.0" \
  --rpcport 1545 \
  --rpcvhosts "*" \
  --rpcapi "admin,db,eth,net,web3,personal,debug" \
  --gcmode "archive" \
  --ws \
  --wsaddr "0.0.0.0" \
  --wsport 1546 \
  --wsorigins "*" \
  --unlock "$UNLOCK_ADDRESS" \
  --identity "$NODE_IDENTITY" \
  --mine \
  --gasprice 2500 \
  --bootnodesv5 "$BOOTNODE_URL" \
  console