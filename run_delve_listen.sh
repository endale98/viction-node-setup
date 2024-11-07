#!/bin/bash

# Check if 'dlv' command is available
if ! command -v dlv &> /dev/null
then
    echo "install delve first"
    exit 1
fi

# Set variables
TOMO_BINARY="victionchain/build/bin/tomo"
DATA_DIR="delves/runners/1"
KEYSTORE_DIR="delves/keystores/1"
PASSWORD_FILE="password.txt"
NODE_IDENTITY="NODE_DELVE"
UNLOCK_ADDRESS="0xdb095dbbfe6366f24666f95afa42807a11202277"
NETWORK="16774"
PORT="40303"
RPCPORT="4545"
DELVE_PORT="2345"
WSPORT="4546"
BOOTNODE_URL="enode://067e2fe604d77f21b62604560cc3a61372a50e92fddf37bb5f7037b964ada38104b4c64dfbd8948876a2ff3b60bc25b8bc14ed7dec1bc19d27a441f3c3de4a90@[::]:10303"

# Run the node
$TOMO_BINARY --syncmode "full" \
    --datadir $DATA_DIR    \
    --networkid $NETWORK  \
    --port $PORT \
    --keystore $KEYSTORE_DIR \
    --password $PASSWORD_FILE \
    --rpcport $RPCPORT \
    --rpcaddr "0.0.0.0" \
    --rpc --rpccorsdomain "*" \
    --rpcapi "admin,db,eth,net,web3,personal,debug" \
    --gcmode "archive" \
    --ws \
    --wsaddr "0.0.0.0" \
    --wsport $WSPORT \
    --wsorigins "*" \
    --unlock "$UNLOCK_ADDRESS" \
    --identity "$NODE_IDENTITY" \
    --mine \
    --gasprice 2500 \
    --bootnodesv5 "$BOOTNODE_URL" \
    --verbosity 4 &
NODE_PID=$!

# echo PID
echo "Node started with PID: $NODE_PID"

sleep 10

if ps -p $NODE_PID > /dev/null
then
   echo "Node is running, attaching Delve..."
   # Use Delve to attach to the node process
   dlv --headless --listen=:$DELVE_PORT --api-version=2 --accept-multiclient attach $NODE_PID
else
   echo "Node is not running. Exiting."
   exit 1
fi