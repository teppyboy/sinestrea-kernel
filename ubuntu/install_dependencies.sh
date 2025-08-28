#!/usr/bin/env bash

echo "Installing system dependencies..."
sudo apt update -y
sudo apt install -y ccache device-tree-compiler lz4 xz-utils zlib1g-dev openjdk-17-jdk gcc g++ python3 python-is-python3 p7zip-full android-sdk-libsparse-utils erofs-utils default-jdk git gnupg flex bison gperf build-essential zip curl libc6-dev libncurses-dev libx11-dev libreadline-dev libgl1 libgl1-mesa-dev python3 make sudo gcc g++ bc grep tofrodos python3-markdown libxml2-utils xsltproc zlib1g-dev python-is-python3 libc6-dev libtinfo6 make cpio kmod openssl libelf-dev libssl-dev libarchive-tools zstd --fix-missing
bash ./scripts/install_repo.sh
echo "Configuring ccache..."
ccache -M 50G
ccache -o compression=true
echo "Environment setup complete."
