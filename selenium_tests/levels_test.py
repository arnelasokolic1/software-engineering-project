from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import time

options = webdriver.ChromeOptions()
service = Service(ChromeDriverManager(driver_version="137.0.7151.104").install())
driver = webdriver.Chrome(service=service, options=options)

# Go to the page and click through the levels
def test_levels():
    try:
        # url
        driver.get("https://software-engineering-project-silk.vercel.app/fill_in_blanks.html")
        time.sleep(2)  

        # List of level names to click
        levels = [
            "Level 1: Easy",
            "Level 2: Medium",
            "Level 3: Hard",
            "Level 4: Very Hard",
            "Level 5: Expert"
        ]

        # Click each level
        for level in levels:
            level_element = driver.find_element(By.XPATH, f"//li[contains(text(), '{level}')]")
            level_element.click()
            print(f"{level} clicked successfully!")  # Success message
            time.sleep(2)  # Wait for the page to respond after each click

    except Exception as e:
        print(f"Test failed: {str(e)}")


test_levels()

driver.quit()
