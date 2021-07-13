#!/bin/bash -e
operation="${1}"

function bail() {
    if [[ $# -eq 0 ]]; then
        echo "${0}: Script called 'bail' without passing a message" 1>&2
    else
        echo "${0}: $@" 1>&2
    fi
    exit 1
}
if [[ -z "${operation}" ]]; then
    bail "Must supply parameter (restore|build)"
elif [[ "${operation}" == "restore" ]]; then
    ./eng/common/build.sh --restore
elif [[ "${operation}" == "build" ]]; then
    ./eng/common/build.sh --build
elif [[ "${operation}" == "pack" ]]; then
    ./eng/common/build.sh --pack
else
    bail "Parameter ${operation} not supported"
fi
