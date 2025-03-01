#!/bin/bash

#set -e  # Stop script execution on error

log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") [INFO] $1"
}

error_exit() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") [ERROR] $1"
    exit 1
}

output=$(kubectl create ns traefik-v2 2>&1)

if [ $? -ne 0 ]; then
  log "$output"
fi

# Install in the namespace "traefik-v2"
output=$(helm install --namespace=traefik-v2 --values=values.yml traefik traefik/traefik 2>&1)


if [ $? -ne 0 ]; then
  error_exit "$output"
fi

log "Traefik was installed successfully!"
