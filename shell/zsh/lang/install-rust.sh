#!/usr/bin/env bash
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf -y | sh
rustup update
MDBOOK_VERSION=$(curl 'https://api.github.com/repos/rust-lang/mdbook/releases/latest' | jq -r '.tag_name')
cargo install --version ${MDBOOK_VERSION} mdbook


# url="https://github.com/rust-lang/mdbook/releases/download/${tag}/mdbook-${tag}-x86_64-unknown-linux-gnu.tar.gz"
# url="https://github.com/rust-lang/mdbook/releases/download/${tag}/mdbook-${tag}-aarch64-apple-darwin.tar.gz"
# curl  -sSL $url | tar -xz --directory=$HOME/.local/bin

