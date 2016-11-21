#!/bin/bash
apt update
apt install git
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker $(whoami)
apt-get -y install python-pip
pip install docker-compose
cd /home/ubuntu
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk
sysctl -w vm.max_map_count=262144
docker-compose up -d
