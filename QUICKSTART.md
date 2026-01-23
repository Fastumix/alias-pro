# Quick Start Guide

## 📋 Prerequisites

Before you start, make sure you have:

1. **Flutter SDK** (3.2.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Add Flutter to your PATH

2. **IDE** (choose one):
   - VS Code + Flutter extension (recommended)
   - Android Studio + Flutter plugin
   - IntelliJ IDEA + Flutter plugin

3. **Development Tools**:
   - Git
   - Xcode (for iOS development on macOS)
   - Android Studio (for Android development)

4. **Firebase Account**
   - Create account at: https://firebase.google.com/

## 🚀 Installation Steps

### 1. Clone and Setup

```bash
# Clone repository
git clone <your-repo-url>
cd alias-pro

# Install dependencies
flutter pub get
```

### 2. Configure Firebase

#### Option A: Using FlutterFire CLI (Recommended)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Configure Firebase for your project
flutterfire configure
```

#### Option B: Manual Configuration

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed instructions.

**Quick steps:**
1. Create Firebase project
2. Enable Anonymous Authentication
3. Create Firestore database
4. Download config files:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

### 3. Run the App

```bash
# Check connected devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Or just run (will ask to select device)
flutter run
```

## 🎮 First Launch

1. App opens to **Home Screen**
2. Click "Грати" (Play)
3. Select a category
4. Play the game!
5. View results and statistics in Profile

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/game_entity_test.dart
```

## 📱 Platform-Specific Setup

### iOS

```bash
cd ios
pod install
cd ..
flutter run -d ios
```

### Android

```bash
flutter run -d android
```

### Web

```bash
flutter run -d chrome
```

## 🔧 Common Issues

### Issue: "Flutter not found"
**Solution**: Add Flutter to your PATH
```bash
export PATH="$PATH:`pwd`/flutter/bin"  # Linux/Mac
# or add to system PATH on Windows
```

### Issue: "Firebase not configured"
**Solution**: Follow [FIREBASE_SETUP.md](FIREBASE_SETUP.md)

### Issue: "Gradle build failed" (Android)
**Solution**: 
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: "Pod install failed" (iOS)
**Solution**:
```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
flutter run
```

## 📚 Next Steps

1. **Explore the code**
   - Start with `lib/main.dart`
   - Check `lib/config/routes.dart` for navigation
   - Review feature structure in `lib/features/`

2. **Read documentation**
   - [README.md](README.md) - Project overview
   - [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture details
   - [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines

3. **Customize**
   - Change app theme in `lib/shared/theme/app_theme.dart`
   - Add more words in `assets/data/categories.json`
   - Modify game settings in `lib/config/constants.dart`

## 🎯 Development Workflow

```bash
# 1. Create feature branch
git checkout -b feature/my-feature

# 2. Make changes
# ... edit files ...

# 3. Run tests
flutter test

# 4. Check for issues
flutter analyze

# 5. Format code
flutter format .

# 6. Commit
git add .
git commit -m "feat: add my feature"

# 7. Push
git push origin feature/my-feature
```

## 📞 Support

- **Documentation**: See `docs/` folder
- **Issues**: Open issue on GitHub
- **Questions**: Check CONTRIBUTING.md

## 🎉 You're Ready!

Your Alias Pro development environment is set up. Happy coding! 🚀
