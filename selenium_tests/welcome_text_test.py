from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import time

# Drajver
driver = webdriver.Chrome()

# Link stranice
driver.get("https://software-engineering-project-silk.vercel.app/index.html")  

# Stranica se učitava
time.sleep(3)

# provjeravamo da li je tačan text na stranici
try:
    
    element = WebDriverWait(driver, 10).until(
        EC.visibility_of_element_located((By.ID, "welcomeText")) 
    )
    
    # ako je tačno 
    assert "Hello! Welcome to Blockchain Quiz" in element.text
    print("Test passed: The correct text is displayed on the page!")
except Exception as e:
    print(f"Test failed: The text was not found or did not match. Error: {e}") # ako nije tačno

# zatvaramo browser
driver.quit()
