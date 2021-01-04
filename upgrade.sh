#!/usr/bin/env bash
hostname
whoami
host=`hostname -s`
if [ $host = "scanner" ]; then
  sudo apt update
  sudo apt -y install nmap
fi
if [ $host = "target" ]; then
  cd /users/deverso
  git clone https://github.com/0xd0ug/clayPigeons.git
fi
if [ $host = "internet" ]; then
  sudo tc qdisc add dev eth1 root netem delay 20ms
  sudo tc qdisc add dev eth2 root netem delay 20ms
fi
