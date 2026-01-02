#!/usr/bin/env bash

cd sinestrea
echo "Updating build environment for GKI 5.10 kernel..."
# Remove "common" because the user may have replaced it with their custom kernel.
rm -rf common
repo sync -c -j$(nproc --all) --no-clone-bundle --no-tags

echo "Updating SukiSU patch repository..."
# git clone https://github.com/SukiSU-Ultra/SukiSU_patch --depth 1
cd SukiSU_patch
git reset --hard
git pull
cd ..

echo "Updating SusFS4KSU repository..."
# git clone https://github.com/ShirkNeko/susfs4ksu/ --depth 1 -b gki-android12-5.10
cd susfs4ksu
git reset --hard
git pull
cd ..

echo "Build environment updated successfully."
