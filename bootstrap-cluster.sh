#!/bin/bash
# This small script installs k3s in my homelab
# K3s is Lightweight Kubernetes. Easy to install, half the memory, all in a binary of less than 100 MB.
curl -sfL https://get.k3s.io | sh - 

# This part install k9s, which is a terminal UI to interact with Kubernetes clusters written in Go.
wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb && sudo apt install ./k9s_linux_amd64.deb && sudo rm k9s_linux_amd64.deb

# Copy k3s kubeconfig to default path
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

# Alias k9s to automatically open with k3s kubeconfig
echo "alias k9s='k9s --kubeconfig ~/.kube/config'" >> ~/.config/fish/config.fish
