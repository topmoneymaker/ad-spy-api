# Ensure directory exists
mkdir -p /opt/render/chrome

# Download Portable Google Chrome
wget -q -O /opt/render/chrome/google-chrome-stable "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64"
chmod +x /opt/render/chrome/google-chrome-stable

# Install Chromedriver
CHROMEDRIVER_VERSION="114.0.5735.90"
wget -q -O /opt/render/chrome/chromedriver "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"

# Extract and set permissions
if [ -s /opt/render/chrome/chromedriver ]; then
    unzip /opt/render/chrome/chromedriver -d /opt/render/chrome/
    chmod +x /opt/render/chrome/chromedriver
else
    echo "Chromedriver download failed"
fi

# Verify installations
/opt/render/chrome/google-chrome-stable --version || echo "Chrome installation failed"
/opt/render/chrome/chromedriver --version || echo "Chromedriver installation failed"
