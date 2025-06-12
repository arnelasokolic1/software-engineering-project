from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time

options = webdriver.ChromeOptions()
service = Service(ChromeDriverManager(driver_version="137.0.7151.104").install())
driver = webdriver.Chrome(service=service, options=options)

def test_show_statistics_button():
    try:

        driver.get("https://software-engineering-project-silk.vercel.app/fill_in_blanks.html")
        time.sleep(2)  

        statistics_button = driver.find_element(By.CLASS_NAME, "btn-finish")
        statistics_button.click()  # Click the "Show Statistics" button
        print("✅ 'Show Statistics' button clicked successfully!")

        time.sleep(2)

    except Exception as e:
        print(f"❌ Test failed: {str(e)}")

test_show_statistics_button()

driver.quit()
