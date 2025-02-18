# Create a persistent directory for Chrome & Chromedriver
mkdir -p /opt/render/chrome
cd /opt/render/chrome

# Install dependencies explicitly
pip install --upgrade pip
pip install -r /opt/render/project/src/requirements.txt

# Download and install Google Chrome
wget -q -O google-chrome-stable "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
dpkg -x google-chrome-stable /opt/render/chrome/
chmod +x /opt/render/chrome/opt/google/chrome/google-chrome

# Verify Chrome installation
/opt/render/chrome/opt/google/chrome/google-chrome --version || echo "Chrome installation failed"

# Install a specific version of Chromedriver for Linux
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

# Ensure the directory persists
echo "Keeping Chrome directory after deployment."
