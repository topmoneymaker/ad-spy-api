# Ensure directory exists
mkdir -p /opt/render/chrome
cd /opt/render/chrome

# Install dependencies explicitly
pip install --upgrade pip
pip install -r /opt/render/project/src/requirements.txt

# Download the latest Chrome binary for Linux (not a .deb file)
wget -q -O chrome-linux.zip "https://dl.google.com/linux/chrome/chrome-linux.zip"

# Extract Chrome
unzip chrome-linux.zip
chmod +x /opt/render/chrome/chrome-linux/chrome

# Verify Chrome installation
/opt/render/chrome/chrome-linux/chrome --version || echo "Chrome installation failed"

# Install Chromedriver
CHROMEDRIVER_VERSION="114.0.5735.90"
wget -q -O chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"

# Ensure Chromedriver is extracted correctly
if [ -s chromedriver.zip ]; then
    unzip chromedriver.zip
    mv chromedriver /opt/render/chrome/chromedriver
    chmod +x /opt/render/chrome/chromedriver
else
    echo "Chromedriver download failed"
fi

# Verify Chromedriver installation
/opt/render/chrome/chromedriver --version || echo "Chromedriver installation failed"
