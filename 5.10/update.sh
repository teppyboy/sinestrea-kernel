#!/usr/bin/env bash

echo "Updating SukiSU patches..."
cd sinestrea/SukiSU_patch
git pull

echo "Updating susfs4ksu patches..."
cd ../susfs4ksu
git pull

echo "Patches updated."
