#!/bin/sh
set -e

cd ~

# Node, NPM installation
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install -y nodejs build-essential

# PM2 installation
sudo npm install pm2@latest -g

# App configuration
mkdir ~/app
cd ~/app
mv /tmp/hello-jruedas-node.js hello-jruedas-node.js

# PM2 configuration
pm2 kill
pm2 startup systemd | grep "sudo" | sh
sudo systemctl start pm2-ubuntu
pm2 start hello-jruedas-node.js
pm2 save