# 1. Install dependencies
sudo apt-get install wget apt-transport-https gnupg -y

# 2. Download and add Trivy GPG key
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | \
  gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null

# 3. Add Trivy repository
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | \
  sudo tee /etc/apt/sources.list.d/trivy.list

# 4. Update package index
sudo apt-get update

# 5. Install Trivy
sudo apt-get install trivy -y

