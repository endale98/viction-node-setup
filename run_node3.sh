#!/bin/bash

# Set variables
TOMO_BINARY="./victionchain/build/bin/tomo"
DATA_DIR="nodes/runners/3"
KEYSTORE_DIR="nodes/keystore/3"
PASSWORD_FILE="password.txt"
NODE_IDENTITY="NODE3"
UNLOCK_ADDRESS="16651ca2bd7f4ab7f44564f3fa667ea671947168"
BOOTNODE_URL="self=enode://867ee7378856408df430b93b67ff3c231b0e9cdebdfe61395c3cb386bb0b4b17877d4887eebe9c053e34e2525daf2d2bea062545dcaf1ed1a8545a5029cc6fe6@[::]:30301"

# Ensure the data and keystore directories exist
mkdir -p "$DATA_DIR"
mkdir -p "$KEYSTORE_DIR"

# Run the node
$TOMO_BINARY --syncmode "full" \
  --datadir "$DATA_DIR" \
  --networkid 16774 \
  --port 30303 \
  --keystore "$KEYSTORE_DIR" \
  --password "$PASSWORD_FILE" \
  --rpc \
  --rpccorsdomain "*" \
  --rpcaddr "0.0.0.0" \
  --rpcport 3545 \
  --rpcvhosts "*" \
  --rpcapi "admin,db,eth,net,web3,personal,debug" \
  --gcmode "archive" \
  --ws \
  --wsaddr "0.0.0.0" \
  --wsport 3546 \
  --wsorigins "*" \
  --unlock "$UNLOCK_ADDRESS" \
  --identity "$NODE_IDENTITY" \
  --mine \
  --gasprice 2500 \
  --bootnodesv5 "$BOOTNODE_URL" \
  console