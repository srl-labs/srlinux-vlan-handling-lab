#!/bin/bash

# client id
ID=$1

###### eth1 ######
# no tagging
ip addr add 10.1.0.${ID}/30 dev eth1
ip link set dev eth1 address aa:c1:ab:00:00:0${ID}

# single tag VID 10
ip link add name eth1.10 link eth1 type vlan id 10
ip addr add 10.1.1.${ID}/30 dev eth1.10
ip link set dev eth1.10 address aa:c1:ab:00:01:0${ID}
ip link set dev eth1.10 up

# single tag VID 11
ip link add name eth1.11 link eth1 type vlan id 11
ip addr add 10.1.2.${ID}/30 dev eth1.11
ip link set dev eth1.11 address aa:c1:ab:00:02:0${ID}
ip link set dev eth1.11 up

# qinq outer tag 13, inner tag 12
ip link add name eth1.12 link eth1 type vlan proto 802.1ad id 12 # inner tag
ip link add name eth1.12.13 link eth1.12 type vlan proto 802.1q id 13 # outer tag
ip addr add 10.1.3.${ID}/30 dev eth1.12.13
ip link set dev eth1.12 address aa:c1:ab:03:00:0${ID}
ip link set dev eth1.12 up
ip link set dev eth1.12.13 address aa:c1:ab:03:03:0${ID}
ip link set dev eth1.12.13 up

# null tag
ip link add name eth1.0 link eth1 type vlan id 0
ip addr add 10.1.4.${ID}/30 dev eth1.0
ip link set dev eth1.0 address aa:c1:ab:00:04:0${ID}
ip link set dev eth1.0 up
