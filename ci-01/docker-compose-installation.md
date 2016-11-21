#!/bin/bash
wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker $(whoami)
apt-get -y install python-pip
pip install docker-compose
