## Firebase Configuration Instructions

### Prerequisites

1. Create a Firebase project at https://console.firebase.google.com/
2. Enable Firebase Authentication (Anonymous sign-in)
3. Create a Firestore database

### iOS Configuration

1. In Firebase Console, add an iOS app to your project
2. Register with Bundle ID: `com.alias.pro` (or your custom bundle ID)
3. Download `GoogleService-Info.plist`
4. Place the file in `ios/Runner/` directory
5. Open `ios/Runner.xcworkspace` in Xcode
6. Add `GoogleService-Info.plist` to the project (drag and drop)

### Android Configuration

1. In Firebase Console, add an Android app to your project
2. Register with package name: `com.alias.pro` (or your custom package)
3. Download `google-services.json`
4. Place the file in `android/app/` directory

### Firestore Security Rules

Add these rules in Firebase Console → Firestore Database → Rules:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Firebase Authentication

Enable Anonymous sign-in:

1. Go to Firebase Console → Authentication
2. Click "Sign-in method" tab
3. Enable "Anonymous" provider
4. Click "Save"

### Optional: firebase_options.dart (FlutterFire CLI)

For automatic configuration, use FlutterFire CLI:

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

This will generate `lib/firebase_options.dart` automatically.

### Verify Setup

Run the app and check console logs for successful Firebase initialization:

- `[FIREBASE] Initialized successfully`
- No authentication errors
- Firestore connection established
