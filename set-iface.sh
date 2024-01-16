#!/bin/bash
declare -a srl_nodes=("clab-vlan-srl1" "clab-vlan-srl1")

# Save the current working directory in a variable
pwd=$(pwd)

# Save the command in a variable
gnmic="docker run --network clab --rm -t -v ${pwd}/configs:/configs ghcr.io/openconfig/gnmic:0.34.3 --config /configs/nodes.yml"

MODE=$1

if [ "$MODE" == "default" ]; then
    REPLACE_FILE=configs/default.yml
fi

if [ "$MODE" == "single-tag" ]; then
    REPLACE_FILE=configs/single-tag-10.yml
fi

if [ "$MODE" == "single-tag-range" ]; then
    REPLACE_FILE=configs/single-tag-range-10-15.yml
fi

if [ "$MODE" == "untagged" ]; then
    REPLACE_FILE=configs/untagged.yml
fi

if [ -z "$REPLACE_FILE" ]; then
    echo "Invalid mode. Please use one of the following modes: default, single-tag, single-tag-range, untagged"
    exit 1
fi

$gnmic ${srl} set --replace-path /interface[name=ethernet-1/1] --replace-file ${REPLACE_FILE}
