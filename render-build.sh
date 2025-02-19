# Ensure APT is available
apt-get update -y

# Install Google Chrome
apt-get install -y google-chrome-stable

# Install Chromedriver (automatically picks the correct version)
apt-get install -y chromium-chromedriver

# Verify Installation
which chromedriver
which google-chrome
