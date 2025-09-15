#!/bin/bash
set -e

echo "🚀 Updating system..."
sudo apt update -y

echo "📥 Installing prerequisites..."
sudo apt install -y wget curl gnupg apt-transport-https software-properties-common

echo "☕ Installing Temurin JDK 17..."
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print $2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
sudo apt update -y
sudo apt install -y temurin-17-jdk
java -version

echo "🔑 Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "📦 Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "📥 Installing Jenkins..."
sudo apt-get update -y
sudo apt-get install -y jenkins

echo "▶️ Starting Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

echo "✅ Jenkins installation completed!"
echo "🌍 Access Jenkins at: http://<your-server-ip>:8080"

