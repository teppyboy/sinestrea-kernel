#!/usr/bin/env bash

mkdir -p dist/lineage_diting
mkdir -p tmp
# Check if tmp/lineage_diting_base_boot.img exists
if [ ! -f tmp/lineage_diting_base_boot.img ]; then
    echo "Downloading base boot image..."
    wget -q https://mirrorbits.lineageos.org/full/diting/20250625/boot.img -O tmp/lineage_diting_base_boot.img
else
    echo "Base boot image already exists."
fi
./create_bootimg.py tmp/lineage_diting_base_boot.img ./sinestrea/Image dist/lineage_diting/boot.img
rm ./sinestrea/Image
