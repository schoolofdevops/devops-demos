#!/bin/bash
apt install git
cd /home/ubuntu
git clone https://github.com/deviantony/docker-elk.git
cd docker-elk
sysctl -w vm.max_map_count=262144
docker-compose up -d
