#!/bin/bash
set -e

# Create directory for Chrome & Chromedriver
mkdir -p /opt/render/chrome
cd /opt/render/chrome

# Download Google Chrome
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -x google-chrome-stable_current_amd64.deb /opt/render/chrome/

# Set correct Chrome path
export CHROME_PATH="/opt/render/chrome/opt/google/chrome/google-chrome"

# Download Chromedriver
CHROMEDRIVER_VERSION="114.0.5735.90"
wget -q -O chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
unzip -o chromedriver.zip
mv chromedriver /opt/render/chrome/chromedriver
chmod +x /opt/render/chrome/chromedriver

# Set Chromedriver path
export CHROMEDRIVER_PATH="/opt/render/chrome/chromedriver"

# Verify installation
/opt/render/chrome/chromedriver --version || echo "Chromedriver installation failed"
