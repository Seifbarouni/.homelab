#!/bin/bash

set -e  # Stop script execution on error

log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") [INFO] $1"
}

error_exit() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") [ERROR] $1"
    exit 1
}

log "Creating ArgoCD namespace..."
kubectl create namespace argocd

log "Deploying ArgoCD..."
kubectl apply -n argocd -f install.yml || error_exit "Failed to deploy ArgoCD"

log "Applying certificates..."
kubectl apply -n argocd -f cert.yml || error_exit "Failed to apply certificates"

log "Configuring Ingress..."
kubectl apply -n argocd -f ingress.yml || error_exit "Failed to configure Ingress"

log "Waiting for argocd-server deployment to be available..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd || error_exit "ArgoCD server did not become available within 300 seconds"

log "ArgoCD server is running, waiting for internal components to initialize..."
sleep 10

log "Retrieving and decoding the admin password..."
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode) || error_exit "Failed to retrieve admin password"

log "ArgoCD is ready!"
log "Admin username: admin"
log "Admin password: $ARGOCD_PASSWORD"

