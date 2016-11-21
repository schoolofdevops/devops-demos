#!/bin/bash
apt update
apt-get -y install python-pip
PKG_OK=$(pip show='${Status}\n' docker|grep "Docker-compose is already installed")
echo Checking for docker-engine: $PKG_OK
if [ "" == "$PKG_OK" ]; then
  echo "No Docker-compose found. Setting up."
  wget -qO- https://get.docker.com/ | sh
  sudo usermod -aG docker $(whoami)
  pip install docker-compose
fi
apt install git
cd /home/ubuntu
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk
sysctl -w vm.max_map_count=262144
docker-compose up -d
