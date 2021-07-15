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

configuration=Release

if [[ -z "${operation}" ]]; then
    bail "Must supply parameter (restore|build|pack)"
elif [[ "${operation}" == "restore" ]] || [[ "${operation}" == "build" ]] || [[ "${operation}" == "pack" ]]; then
    ./eng/common/build.sh --configuration ${configuration} --${operation}
else
    bail "Parameter ${operation} not supported"
fi
