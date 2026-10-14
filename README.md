# Sanjana Penchala — Student E-Portfolio (Flutter)

A dark, animated Flutter portfolio for UID Lab. Includes a login screen, five dashboard sections, education, skills, projects, NSS and hackathon activities, and an animated swipeable certificate gallery.

## Run in your existing Flutter setup

1. Extract this folder.
2. Open the extracted `sanjana_portfolio` folder in VS Code.
3. Open Terminal in that folder and run:

   ```powershell
   flutter pub get
   flutter run -d chrome
   ```

   If `flutter` is not recognized, use the full path from your setup:

   ```powershell
   & "C:\Users\pench\uid\flutter\bin\flutter.bat" pub get
   & "C:\Users\pench\uid\flutter\bin\flutter.bat" run -d chrome
   ```

4. On the login screen, enter any non-empty email and password. This is a UI demo, not a real authentication system.

## Personalize before submitting

- The circular `SP` avatar is a placeholder because no profile photograph was included. To use your photo, copy it to `assets/profile.jpg`, add `- assets/profile.jpg` under `flutter/assets` in `pubspec.yaml`, then replace the `CircleAvatar` with an `Image.asset('assets/profile.jpg', fit: BoxFit.cover)` inside a clipped circle.
- Verify contact links and details, and add any additional certificates to `assets/certificates/`.
- The certificate gallery animates between certificate images using a swipeable `PageView`. If your lecturer specifically requires an actual video file, add a video asset and a Flutter video player package; this version demonstrates certificate animation without external packages.

## Included assets

- CodeChef OOP through Java certificate
- CodeChef Data Structures certificate
- LeetCode 100 Days 2026 badge image

All portfolio text is in `lib/main.dart` and can be edited directly.
