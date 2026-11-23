#!/bin/bash
set -euxo pipefail
# The bastion uses the Amazon Linux SSH service; no application services are installed.
systemctl enable --now sshd
