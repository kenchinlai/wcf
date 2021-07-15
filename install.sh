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
  sudo=""
  owner=$USER
fi

if [ ! -d $dest ]; then
    echo "INFO: $dest does not exist. Creating..."
    $sudo install -d -o $owner -g $owner -m 755 $dest
fi

echo "INFO: Installing dotnet/wcf packages to $dest"

version="4.9.0-dev.21365.1"
packages="System.Private.ServiceModel System.ServiceModel.Duplex System.ServiceModel.Federation System.ServiceModel.Http System.ServiceModel.NetTcp System.ServiceModel.Primitives System.ServiceModel.Security"
 
prefixes="System.ServiceModel.Http System.ServiceModel.Duplex System.ServiceModel.NetTcp System.ServiceModel.Primitives System.ServiceModel.Security System.Private.ServiceModel"
for package in $packages; do
    $sudo install -o $owner -g $owner -m 644 "artifacts/packages/Release/Shipping/$package.$version.nupkg" $dest
done
