#!/bin/bash
# install packets
sudo apt update && sudo apt upgrade
sudo apt install make curl tar wget clang pkg-config libssl-dev jq build-essential -y

# install rust and cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# press 1

source ~/.cargo/env 

# building

rm -rf penumbra
git clone https://github.com/penumbra-zone/penumbra
cd penumbra
#git fetch
git checkout 005-mneme
cargo build --release --bin pcli

cargo run --quiet --release --bin pcli wallet generate

# Make sure to run commands from /penumbra dir!
cd $HOME/penumbra

# learn help 
cargo run --quiet --release --bin pcli help


# check wallet list
cargo run --quiet --release --bin pcli addr list

# enable logs
export RUST_LOG=info

# sync
cargo run --quiet --release --bin pcli sync

cargo run --quiet --release --bin pcli balance
