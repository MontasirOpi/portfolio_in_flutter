# Adding Your Profile Image

To add your profile image to the portfolio website, follow these steps:

1. **Place Your Image File**:
   - Take your "opi.jpg" file
   - Place it in the `assets/images/` directory of your Flutter project
   - Make sure the file is named exactly "opi.jpg"

2. **Image Requirements**:
   - The image should preferably be square (1:1 aspect ratio)
   - Resolution of at least 300x300 pixels is recommended
   - JPG format as specified by the filename

3. **Verify The File Path**:
   The full path should be:
   ```
   portfolio/assets/images/opi.jpg
   ```

4. **After Adding The Image**:
   - Run `flutter pub get` to update assets
   - Restart the app to see your profile image in the About section

If your image doesn't appear, check that:
- The name is exactly "opi.jpg" (case-sensitive)
- The image file is properly placed in the assets/images directory
- The pubspec.yaml file includes the assets section correctly 