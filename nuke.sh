#!/bin/bash

set -e

existing_id=$(docker ps -a | grep dockerlocals3_data_1 | awk '{print $1}')
if [ "$existing_id" != "" ]
then
    echo "removing $existing_id..."
    docker rm $existing_id > /dev/null
fi

existing_id=$(docker ps -a | grep dockerlocals3_swift3_1 | awk '{print $1}')
if [ "$existing_id" != "" ]
then
    echo "removing $existing_id..."
    docker rm $existing_id > /dev/null
fi
