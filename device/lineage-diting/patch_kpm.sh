#!/usr/bin/env bash

echo "Patching kernel..."
cd sinestrea
cp ../dist/lineage-diting/Image .
chmod +x ./SukiSU_patch/kpm/patch_linux
./SukiSU_patch/kpm/patch_linux
rm Image
mv oImage Image
rm ../dist/lineage-diting/Image
mv Image ../dist/lineage-diting/Image
echo "Kernel patched successfully."