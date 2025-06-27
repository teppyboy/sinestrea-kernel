#!/usr/bin/env bash

cd sinestrea
cp common/out/arch/arm64/boot/Image .
chmod +x ./SukiSU_patch/kpm/patch_linux
./SukiSU_patch/kpm/patch_linux
rm Image
mv oImage Image