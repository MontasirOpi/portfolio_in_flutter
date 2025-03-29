# How to Add Your Profile Image to the Portfolio

Since your profile image can't be directly saved through this interface, follow these steps to add it manually:

## Option 1: Update the Image URL in code (Easiest)

1. Open the file `lib/screens/home_screen.dart`
2. Find the `_buildProfileImage()` method
3. Replace the URL in the `Image.network` widget with a URL to your hosted image
   ```dart
   child: Image.network(
     'YOUR_IMAGE_URL_HERE', // Replace this with a URL to your image
     fit: BoxFit.cover,
     // ... rest of the code
   ),
   ```

## Option 2: Add the image to assets (More reliable but requires more steps)

1. Create an `images` folder inside the `assets` folder if it doesn't exist already
2. Copy your profile image to this folder and name it `profile.jpg`
3. Make sure the `pubspec.yaml` file has the assets section:
   ```yaml
   assets:
     - assets/images/
   ```
4. Update the `_buildProfileImage()` method in `lib/screens/home_screen.dart` to use the asset:
   ```dart
   child: Image.asset(
     'assets/images/profile.jpg',
     fit: BoxFit.cover,
     // ... rest of the code
   ),
   ```
5. Run `flutter pub get` to update the assets
6. Rebuild the app

## Image Requirements

- Preferably a square image (1:1 aspect ratio)
- Minimum resolution of 300x300 pixels for good quality
- JPG or PNG format recommended 