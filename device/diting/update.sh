#!/usr/bin/env bash

echo "Updating kernel source..."
cd sinestrea/common
git reset --hard
git pull
echo "Kernel source updated."
