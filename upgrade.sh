#!/usr/bin/env bash
# Must run as root
hostname
whoami
host=`hostname -s`

# Begin commands for all hosts

apt update

# End commands for all hosts

if [ $host = "scanner" ]; then
  # Install zgrab
  apt -y install golang
  export GOPATH=/usr/local/go
  cd /usr/local
  go get github.com/zmap/zgrab2
  cd go/src/github.com/zmap/zgrab2/
  go get ./...
  go build
  make
  install -pDm755 zgrab2 /usr/local/bin/zgrab2
  chown -R deverso /usr/local/go
  
  # Install zmap
  apt -y install zmap
  
  # Install nmap
  git clone https://github.com/0xd0ug/nmap /usr/local/nmap
  cd /usr/local/nmap
  ./configure
  make
  make install
  chown -R deverso /usr/local/nmap
  
  # Install masscan
  git clone https://github.com/robertdavidgraham/masscan /usr/local/masscan
  cd /usr/local/masscan
  make
  install -pDm755 bin/masscan /usr/local/bin/masscan # Make install on Cloudlab installs to wrong directory
  chown -R deverso /usr/local/masscan
fi

if [ $host = "target" ]; then
  git clone https://github.com/0xd0ug/nmap
  cd nmap
  ./configure
  make
  make install
  git clone https://github.com/0xd0ug/clayPigeons.git /usr/local/clayPigeons
  chown -R deverso /usr/local/clayPigeons
fi
if [ $host = "internet" ]; then
  tc qdisc add dev eth1 root netem delay 20ms
  tc qdisc add dev eth2 root netem delay 20ms
fi

# Begin commands for all hosts

updatedb

# End commands for all hosts
