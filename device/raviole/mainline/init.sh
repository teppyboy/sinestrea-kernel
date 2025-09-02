#!/usr/bin/env bash

cd sinestrea
echo "Initializing build environment for raviole mainline kernel..."
repo init -u https://android.googlesource.com/kernel/manifest -b gs-android-gs-raviole-mainline --depth 1
repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags

# KernelSU only supports up to 6.6 only

# echo "Cloning SukiSU patch repository..."
# git clone https://github.com/SukiSU-Ultra/SukiSU_patch --depth 1

# SuSFS4KSU only supports up to 6.1 only

# echo "Cloning SusFS4KSU repository..."
# git clone https://github.com/ShirkNeko/susfs4ksu/ --depth 1 -b gki-android12-5.10

echo "Build environment initialized successfully."
