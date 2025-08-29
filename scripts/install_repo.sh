#!/usr/bin/env bash

echo "Installing repo tool..."
mkdir -p ~/.bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo
echo "Repo tool installed successfully."
