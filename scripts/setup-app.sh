#!/bin/bash
set -ex -o pipefail

# Install packages
sudo apt-get update
sudo apt-get install ca-certificates curl nginx -y
sudo ufw allow 'Nginx HTTP'
sudo echo "hello world" > '/usr/share/nginx/html/index.html'