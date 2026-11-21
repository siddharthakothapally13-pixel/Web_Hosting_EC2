#!/bin/bash
# Run on Amazon Linux 2023 after connecting through SSH.
set -euo pipefail
sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl enable --now nginx
sudo install -d -m 755 /usr/share/nginx/html
echo "Nginx installation completed. Upload the project website files next."
sudo systemctl status nginx --no-pager
