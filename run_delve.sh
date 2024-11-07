#!/bin/bash

# Set variables
TOMO_BINARY="victionchain/build/bin/tomo"
DATA_DIR="delves/runners/2"
KEYSTORE_DIR="delves/keystores/2"
PASSWORD_FILE="password.txt"
NODE_IDENTITY="NODE_DELVE"
UNLOCK_ADDRESS="6e2646d127851bdfc5b29084795131e7c4a4a91c"
NETWORK="16774"
PORT="50303"
RPCPORT="5545"
DELVE_PORT="1345"
WSPORT="5546"
BOOTNODE_URL="enode://067e2fe604d77f21b62604560cc3a61372a50e92fddf37bb5f7037b964ada38104b4c64dfbd8948876a2ff3b60bc25b8bc14ed7dec1bc19d27a441f3c3de4a90@[::]:10303"

# Build binary with flag
cd ./victionchain
go build -o ./build/bin/tomo --gcflags "all=-N -l" ./cmd/tomo
cd ..

# Function to handle termination and kill Delve process
cleanup() {
    echo "Terminating Delve process..."
    pkill -f "dlv --headless --listen=:$DELVE_PORT"
    exit
}

# Set trap for Ctrl + C
trap cleanup SIGINT

# Run the node with Delve
dlv --headless --listen=:$DELVE_PORT --api-version=2 --accept-multiclient exec $TOMO_BINARY -- \
    --syncmode "full" \
    --datadir $DATA_DIR \
    --networkid $NETWORK \
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
    --unlock "0x$UNLOCK_ADDRESS" \
    --identity "$NODE_IDENTITY" \
    --mine \
    --gasprice 2500 \
    --bootnodesv5 "$BOOTNODE_URL" \
    --verbosity 4