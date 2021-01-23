#!/usr/bin/env bash
hostname
whoami
sudo whoami
host=`hostname -s`
if [ $host = "scanner" ]; then
  sudo apt update
  sudo apt -y install nmap
fi
if [ $host = "target" ]; then
  sudo git clone https://github.com/0xd0ug/clayPigeons.git /users/deverso/clayPigeons
  sudo chown -R deverso /users/deverso/clayPigeons/
fi
if [ $host = "internet" ]; then
  sudo tc qdisc add dev eth1 root netem delay 20ms
  sudo tc qdisc add dev eth2 root netem delay 20ms
fi
