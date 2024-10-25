#!/bin/bash

# Navigate to the victionchain directory and build the tomo binary
cd victionchain || exit
go mod tidy -e
make all

# Return to the parent directory
cd ..

# Set variables
TOMO_BINARY="./victionchain/build/bin/tomo"
GENESIS_FILE="./supachain.json"

# Ensure the data and keystore directories exist
rm -rf ./nodes/runners/1/tomo
rm -rf ./nodes/runners/2/tomo
rm -rf ./nodes/runners/3/tomo

# Run the node
$TOMO_BINARY --datadir nodes/runners/1 init $GENESIS_FILE
$TOMO_BINARY --datadir nodes/runners/2 init $GENESIS_FILE
$TOMO_BINARY --datadir nodes/runners/3 init $GENESIS_FILE


