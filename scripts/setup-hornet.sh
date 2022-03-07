#! /usr/bin/env bash

mkdir -p /server/hornet

wget ${iota_hornet_version} -o /tmp/hornet.tar.gz
tar -xvf /tmp/hornet.tar.gz -C /server/hornet/
chmod +x /server/hornet/hornet
