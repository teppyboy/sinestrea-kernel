#!/usr/bin/env bash

mkdir -p dist/lineage-diting
mkdir -p tmp
# Check if tmp/lineage_diting_base_boot.img exists
if [ ! -f tmp/lineage_diting_base_boot.img ]; then
    echo "Downloading base boot image..."
    wget -q https://mirrorbits.lineageos.org/full/diting/20250827/boot.img -O tmp/lineage_diting_base_boot.img
else
    echo "Base boot image already exists."
fi
rm -rf dist/lineage-diting/boot.img
python3 ./scripts/create_bootimg.py tmp/lineage_diting_base_boot.img ./dist/lineage-diting/Image dist/lineage-diting/boot.img
