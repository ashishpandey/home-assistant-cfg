#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJ_DIR=$(dirname $SCRIPT_DIR)
CONF_DIR=${PROJ_DIR}/config

if [ ! -d $CONF_DIR ]; then
    echo "ERROR: config dir not found. quitting"
    exit 1
fi

echo "syncing config ..."

# a -> mirror (archive)
# i -> itemize
# z -> compression
# P -> partial + progress
rsync --rsync-path 'sudo -u nobody rsync' -aizP ${CONF_DIR}/ root@godaam.local:/mnt/cache/appdata/homeassistant

echo "Done copying files"
