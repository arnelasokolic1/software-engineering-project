from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import time

# Driver
driver = webdriver.Chrome()

# Link of the page 
driver.get("https://software-engineering-project-silk.vercel.app/index.html")  

# Now the page is loading
time.sleep(3)

# we check if the text is correct on the page 
try:
    
    element = WebDriverWait(driver, 10).until(
        EC.visibility_of_element_located((By.ID, "welcomeText")) 
    )
    
    # if it is correct 
    assert "Hello! Welcome to Blockchain Quiz" in element.text
    print("Test passed: The correct text is displayed on the page!")
except Exception as e:
    print(f"Test failed: The text was not found or did not match. Error: {e}") # if it is not correct 

# closing browser 
driver.quit()
