#!/bin/bash
declare -a srl_nodes=("clab-vlan-srl1" "clab-vlan-srl1")

# Save the current working directory in a variable
pwd=$(pwd)

# Save the command in a variable
gnmic="docker run --network clab --rm -t -v ${pwd}/configs:/configs ghcr.io/openconfig/gnmic:0.34.3 -u admin -p NokiaSrl1! -e json_ietf --skip-verify -a"

MODE=$1

# if mode == "singele-tag"

if [ "$MODE" == "single-tag" ]; then
    REPLACE_FILE=configs/single-tag-10.yml
fi

if [ "$MODE" == "single-range-tag" ]; then
    REPLACE_FILE=configs/single-range-tag-10-15.yml
fi

if [ "$MODE" == "untagged" ]; then
    REPLACE_FILE=configs/untagged.yml
fi

for srl in "${srl_nodes[@]}"; do
    $gnmic ${srl} set --replace-path /interface[name=ethernet-1/1] --replace-file ${REPLACE_FILE}
done