from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

driver = webdriver.Chrome()

try:
    driver.get("https://software-engineering-project-silk.vercel.app/home_page.html")
    time.sleep(2)

    fill_in_blanks_link = WebDriverWait(driver, 10).until(
        EC.element_to_be_clickable((By.LINK_TEXT, "Fill In The Blanks"))
    )
    fill_in_blanks_link.click()
    print("✅ Navigated to Fill In The Blanks page successfully.")
    time.sleep(2)

    # Clicking on the mascot image
    mascot = WebDriverWait(driver, 10).until(
        EC.element_to_be_clickable((By.ID, "mascot"))
    )
    mascot.click()
    print("✅ Mascot clicked (first time).")

    # Waiting 10 seconds
    time.sleep(10)

    # Clicking on the mascot again
    mascot.click()
    print("✅ Mascot clicked (second time).")


    time.sleep(3)

except Exception as e:
    print(f"❌ Test failed: {e}")

finally:
    driver.quit()
