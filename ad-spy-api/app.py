from flask import Flask, request, jsonify
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
import os
import time

app = Flask(__name__)

# Define paths
CHROME_PATH = "/usr/bin/google-chrome"
CHROMEDRIVER_PATH = "/usr/bin/chromedriver"

# Ensure Chromedriver exists before running
if not os.path.exists(CHROMEDRIVER_PATH):
    raise FileNotFoundError(f"Chromedriver not found at path: {CHROMEDRIVER_PATH}")

def scrape_facebook_ads(keyword):
    """Scrapes Facebook Ad Library for ads based on the given keyword."""

    options = webdriver.ChromeOptions()
    options.binary_location = CHROME_PATH
    options.add_argument("--headless")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")

    driver = webdriver.Chrome(service=Service(CHROMEDRIVER_PATH), options=options)

    url = f"https://www.facebook.com/ads/library/?active_status=all&ad_type=all&country=US&q={keyword}"
    driver.get(url)
    time.sleep(5)

    ads_data = []
    try:
        ads = driver.find_elements(By.CLASS_NAME, "x1rg5ohu")
        for ad in ads[:10]:
            try:
                ad_text = ad.text
                ads_data.append({"ad_text": ad_text})
            except:
                continue
    except Exception as e:
        print("Error finding ads:", str(e))

    driver.quit()
    return ads_data  # ✅ Always returns a list

@app.route('/get_ads', methods=['GET'])
def get_ads():
    keyword = request.args.get("keyword")
    if keyword:
        ads = scrape_facebook_ads(keyword)
        return jsonify(ads)
    return jsonify({"error": "No keyword provided"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)
