#!/usr/bin/env bash

mkdir -p dist/raviole/mainline/
mkdir -p tmp
# Check if tmp/lineage_diting_base_boot.img exists
if [ ! -f tmp/raviole_mainline_base_boot.img ]; then
    echo "Downloading base boot image..."
    wget -q https://dl.google.com/android/gki/gki-certified-boot-android14-6.1-2025-08_r1.zip -O tmp/raviole_mainline_base_boot.zip
    unzip -d tmp tmp/raviole_mainline_base_boot.zip
    mv tmp/boot-6.1.img tmp/raviole_mainline_base_boot.img
else
    echo "Base boot image already exists."
fi
rm -rf dist/raviole/mainline/boot.img
python3 ./scripts/create_bootimg.py tmp/raviole_mainline_base_boot.img dist/raviole/mainline/Image dist/raviole/mainline/boot.img
