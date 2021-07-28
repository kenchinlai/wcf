#!/bin/bash -e

function bail() {
    if [[ $# -eq 0 ]]; then
        echo "${0}: Script called 'bail' without passing a message" 1>&2
    else
        echo "${0}: $@" 1>&2
    fi
    exit 1
}

if [ -z "$1" ]; then
    bail "Must supply path to install"
else
  # Specify an alternate folder to install without sudo
  dest=$1
  sudo="sudo"
  owner=$USER
  release="artifacts/packages/Release/Shipping/"
fi

if [ ! -d $dest ]; then
    echo "INFO: $dest does not exist. Creating..."
    $sudo install -d -o $owner -g $owner -m 755 $dest
fi

echo "INFO: Installing dotnet/wcf packages to $dest"

for package in $release/*.nupkg; do
    $sudo install -o $owner -g $owner -m 644 "$package" $dest
done
