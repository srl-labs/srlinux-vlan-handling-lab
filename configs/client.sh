#!/bin/bash

# client id
ID=$1

ip addr add 10.1.0.${ID}/30 dev eth1