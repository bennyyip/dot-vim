#!/bin/bash

# updater for Windows

set -e

if tasklist | grep -q -i vim.exe; then
  echo "Please exit vim first."
  exit
fi

REPO="vim/vim-win32-installer"
DOWNLOAD_DIR=$(mktemp -d)
trap "rm -rf $DOWNLOAD_DIR" EXIT  # Clean up on exit

echo "Fetching latest release information for $REPO..."

# Get the first .exe download URL
EXE_URL=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | \
    jq -r '.assets[] | select(.name | endswith("x64.exe")) | .browser_download_url' | head -1)

if [ -z "$EXE_URL" ]; then
    echo "Error: Could not find .exe file in latest release"
    exit 1
fi

EXE_FILENAME=$(basename "$EXE_URL")

echo "Found: $EXE_FILENAME"
echo "Downloading to: $DOWNLOAD_DIR/"

echo $EXE_URL

curl -L -o "$DOWNLOAD_DIR/$EXE_FILENAME" "$EXE_URL"

echo "✓ Download complete: $DOWNLOAD_DIR/$EXE_FILENAME"

gsudo.exe "${DOWNLOAD_DIR}/${EXE_FILENAME}" /S
