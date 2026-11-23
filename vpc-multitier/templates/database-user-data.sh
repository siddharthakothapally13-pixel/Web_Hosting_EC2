#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y mariadb105-server
systemctl enable --now mariadb

cat >/etc/my.cnf.d/99-unlox-remote.cnf <<'EOF'
[mysqld]
bind-address=0.0.0.0
EOF

systemctl restart mariadb
