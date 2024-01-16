#!/bin/bash

CASE=$1

ping_test() {
    ip netns exec clab-vlan-client1 ping -c 1 -w 1 $1 > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "+ \e[32mPing to $1 ($2) was successful.\e[0m"
    else
        echo -e "- \e[31mPing to $1 ($2) failed.\e[0m"
    fi
}

if [ "$CASE" == "no-tag" ]; then
    ip netns exec clab-vlan-client1 ping -c 1 10.1.0.2
fi

if [ "$CASE" == "single-tag-10" ]; then
    ip netns exec clab-vlan-client1 ping -c 1 10.1.1.2
fi

if [ "$CASE" == "single-tag-11" ]; then
    ip netns exec clab-vlan-client1 ping -c 1 10.1.2.2
fi

if [ "$CASE" == "double-tag" ]; then
    ip netns exec clab-vlan-client1 ping -c 1 10.1.3.2
fi

if [ "$CASE" == "all" ]; then
    # ping all cases and print the results that pass and not pass
    ping_test 10.1.0.2 "no tag"
    ping_test 10.1.1.2 "single tag VID: 10"
    ping_test 10.1.2.2 "single tag VID: 11"
    ping_test 10.1.3.2 "double tag outer VID: 12, inner VID: 13"
    exit 0
fi

echo "Invalid mode. Please use one of the following modes: no-tag, single-tag-10, single-tag-11, double-tag, all"
exit 1