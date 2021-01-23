#!/usr/bin/env bash
# Must run as root
hostname
whoami
host=`hostname -s`

# Begin commands for all hosts

apt update

# End commands for all hosts

if [ $host = "scanner" ]; then
  apt -y install nmap
fi
if [ $host = "target" ]; then
  apt -y install pip3
  pip3 install exrex
  git clone https://github.com/0xd0ug/clayPigeons.git /users/deverso/clayPigeons
  chown -R deverso /users/deverso/clayPigeons/
fi
if [ $host = "internet" ]; then
  tc qdisc add dev eth1 root netem delay 20ms
  tc qdisc add dev eth2 root netem delay 20ms
fi
