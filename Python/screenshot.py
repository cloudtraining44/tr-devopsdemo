from PIL import ImageGrab
import datetime

# Get the current time
timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")

# Capture the screenshot
screenshot = ImageGrab.grab()

# Save the screenshot
file_path = f"./screenshot_{timestamp}.png"
screenshot.save(file_path)

print(f"Screenshot saved as {file_path}")
