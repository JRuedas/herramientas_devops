#!/bin/sh
set -e

# Disable apache2 service
sudo apachectl stop
sudo systemctl disable apache2
sudo systemctl stop apache2

# Nginx config
sudo apt-get install -y nginx
sudo cp /tmp/nginx-conf /etc/nginx/sites-available/default
sudo nginx -t
sudo systemctl restart nginx