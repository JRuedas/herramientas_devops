#!/bin/sh
set -e

# Node, NPM and PM2 install.
sudo apt-get update -y
sudo apt-get install -y nodejs npm build-essential
sudo npm install pm2@latest -g

# App configuration
mkdir ~/app
mv /tmp/hello-jruedas-node.js ~/app/hello-jruedas-node.js
cd ~/app
pm2 start hello-jruedas-node.js
pm2 kill
pm2 startup systemd
#sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant   ------
sudo systemctl start pm2-vagrant
pm2 save

# Nginx config
sudo vim /etc/nginx/sites-available/hello-jruedas.com
sudo apt-get install -y nginx
sudo rm /etc/nginx/sites-enabled/default
# Upload hello-nginx-conf to /etc/nginx/sites-available/hello
sudo ln -s /etc/nginx/sites-available/hello /etc/nginx/sites-enabled/hello