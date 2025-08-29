#!/usr/bin/env bash

bash ./common/patch_susfs.sh
echo "Patching kernel with susfs..."
patch -p1 --fuzz=3 < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android12-5.10.patch
echo "Patching complete."
