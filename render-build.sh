# Ensure directory exists
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

# Ensure the directory exists
mkdir -p /opt/render/chrome
cd /opt/render/chrome

# Install a specific version of Chromedriver
CHROMEDRIVER_VERSION="114.0.5735.90"
wget -q -O chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"

# Extract and move Chromedriver
if [ -s chromedriver.zip ]; then
    unzip -o chromedriver.zip
    mv chromedriver /opt/render/chrome/chromedriver
    chmod +x /opt/render/chrome/chromedriver
else
    echo "Chromedriver download failed"
fi

# Verify Chromedriver installation
/opt/render/chrome/chromedriver --version || echo "Chromedriver installation failed"
