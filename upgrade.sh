#!/usr/bin/env bash
# Must run as root
hostname
whoami
host=`hostname -s`

# Begin commands for all hosts

apt update

# End commands for all hosts

if [ $host = "scanner" ]; then
  git clone https://github.com/0xd0ug/nmap
  cd nmap
  ./configure
  make
  make install
fi
if [ $host = "target" ]; then
  git clone https://github.com/0xd0ug/nmap
  cd nmap
  ./configure
  make
  make install
  git clone https://github.com/0xd0ug/clayPigeons.git /usr/local/clayPigeons
  chown -R deverso /usr/local/clayPigeons/
fi
if [ $host = "internet" ]; then
  tc qdisc add dev eth1 root netem delay 20ms
  tc qdisc add dev eth2 root netem delay 20ms
fi
