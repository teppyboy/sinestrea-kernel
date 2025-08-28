#!/usr/bin/env bash

mkdir -p sinestrea
cd sinestrea
echo "Cloning mkbootimg repository..."
git clone https://android.googlesource.com/platform/system/tools/mkbootimg/ --depth 1
echo "mkbootimg repository cloned successfully."
