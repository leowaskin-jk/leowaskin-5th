
import os
from PIL import Image
import numpy as np

images_dir = "./images"
award_images = [f for f in os.listdir(images_dir) if f.startswith("award_img")]

print(f"Checking {len(award_images)} images...")

for img_file in award_images:
    path = os.path.join(images_dir, img_file)
    try:
        img = Image.open(path)
        img_arr = np.array(img)
        
        # Check top rows
        height, width, _ = img_arr.shape
        black_strip_height = 0
        
        # Check first 50 rows
        for i in range(50):
            row = img_arr[i, :, :]
            # Check if row is mostly black (allow some noise, mean pixel value < 10)
            if np.mean(row) < 20: 
                black_strip_height += 1
            else:
                break
        
        print(f"{img_file}: Black strip height = {black_strip_height}px")
        
    except Exception as e:
        print(f"Error processing {img_file}: {e}")
