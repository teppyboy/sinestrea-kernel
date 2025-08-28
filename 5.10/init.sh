#!/usr/bin/env bash

cd sinestrea
echo "Initializing build environment for GKI 5.10 kernel..."
repo init -u https://android.googlesource.com/kernel/manifest -b common-android12-5.10 --depth 1
repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags

echo "Cloning SukiSU patch repository..."
git clone https://github.com/SukiSU-Ultra/SukiSU_patch --depth 1

echo "Cloning SusFS4KSU repository..."
git clone https://github.com/ShirkNeko/susfs4ksu/ --depth 1 -b gki-android12-5.10

echo "Build environment initialized successfully."
