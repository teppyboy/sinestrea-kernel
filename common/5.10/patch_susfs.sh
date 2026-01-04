#!/usr/bin/env bash

bash ./common/patch_susfs.sh
cd sinestrea/common
echo "Patching kernel with susfs..."
patch -p1 --fuzz=3 < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android12-5.10.patch
if [ -d "./KernelSU" ]; then
    cd KernelSU
    repo_url=$(git config --get remote.origin.url)
    if [[ $repo_url == *"tiann/KernelSU"* ]]; then
        echo "Applying patch for regular KernelSU..."
        patch -p1 --fuzz=3 < ../../susfs4ksu/kernel_patches/KernelSU/10_enable_susfs_for_ksu.patch
    fi
fi
echo "Patching complete."
