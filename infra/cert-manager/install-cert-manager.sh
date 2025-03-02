#!/bin/bash

set -e  # Stop script execution on error

log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") [INFO] $1"
}

error_exit() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") [ERROR] $1"
    exit 1
}

output=$(kubectl apply -f install.yaml 2>&1)


if [ $? -ne 0 ]; then
  error_exit "$output"
fi

log "Cert-manager was installed successfully!"

