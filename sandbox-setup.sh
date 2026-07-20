#!/bin/sh
# Sandbox prerequisites: Docker, git, minikube, kubectl, Helm.
# Keep this script — rerun it on a fresh VM to build another sandbox anytime.

# --- Docker & git ---
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io git
sudo usermod -aG docker ${USER}

# --- minikube ---
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# --- kubectl ---
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# --- Helm ---
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# --- Fix Docker client/daemon API mismatch so docker build works ---
grep -q 'DOCKER_API_VERSION' ~/.bashrc || echo 'export DOCKER_API_VERSION=1.44' >> ~/.bashrc

echo ""
echo "✅ Prerequisites installed. Open a new shell (or run: source ~/.bashrc) then start minikube."
