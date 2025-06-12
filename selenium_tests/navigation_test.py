from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time


driver = webdriver.Chrome()

base_url = "https://software-engineering-project-silk.vercel.app/"

# Opening home page
driver.get(base_url + "home_page.html")
time.sleep(2)  

# Defining the navigation links and expected URLs
nav_links = [
    {"locator": (By.LINK_TEXT, "Home"), "expected_url": base_url + "home_page.html"},
    {"locator": (By.LINK_TEXT, "About the Quiz"), "expected_url": base_url + "about.html"},
    {"locator": (By.LINK_TEXT, "Contact Us"), "expected_url": base_url + "contact.html"},
    {"locator": (By.LINK_TEXT, "Fill In The Blanks"), "expected_url": base_url + "fill_in_blanks.html"},
    {"locator": (By.LINK_TEXT, "Learn with Us"), "expected_url": base_url + "learn_with_us.html"},
]

# Testing each navigation link
for link in nav_links:
    try:
        # Waiting until the navigation link is clickable and then clicking on it
        nav_element = WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable(link["locator"])
        )
        nav_element.click()

        # Waiting for the page to load by checking the URL
        WebDriverWait(driver, 10).until(
            EC.url_to_be(link["expected_url"])
        )

        # Verify current URL
        current_url = driver.current_url
        if current_url == link["expected_url"]:
            print(f"✅ Test passed: Navigation to {link['expected_url']} works correctly.")
        else:
            print(f"❌ Test failed: Expected {link['expected_url']}, but got {current_url}")

        # Return to home before testing another link
        driver.get(base_url + "home_page.html")
        time.sleep(2)

    except Exception as e:
        print(f"❌ Test failed for link {link['locator'][1]}: {e}")

# Closing the browser
driver.quit()
