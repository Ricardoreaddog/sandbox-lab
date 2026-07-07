#!/bin/sh
# Installs minikube, kubectl, skaffold & Helm. Keep this script for future sandboxes.
sudo rm -f /etc/apt/sources.list.d/*focal*.list
sudo apt update
# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
sudo install skaffold /usr/local/bin/
# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
