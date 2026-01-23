@echo off
echo 🚀 Starting Alias Pro Flutter project setup...

REM Check if Flutter is installed
where flutter >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Flutter is not installed. Please install Flutter first.
    exit /b 1
)

echo ✅ Flutter found

REM Get Flutter dependencies
echo 📦 Installing dependencies...
call flutter pub get

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to get dependencies
    exit /b 1
)

echo ✅ Dependencies installed

REM Check for Firebase configuration files
if not exist "android\app\google-services.json" (
    echo ⚠️  Warning: android\app\google-services.json not found
    echo    Please add your Firebase configuration file
    echo    See FIREBASE_SETUP.md for instructions
)

if not exist "ios\Runner\GoogleService-Info.plist" (
    echo ⚠️  Warning: ios\Runner\GoogleService-Info.plist not found
    echo    Please add your Firebase configuration file
    echo    See FIREBASE_SETUP.md for instructions
)

REM Run tests
echo 🧪 Running tests...
call flutter test

if %ERRORLEVEL% NEQ 0 (
    echo ⚠️  Some tests failed
) else (
    echo ✅ All tests passed
)

REM Check for issues
echo 🔍 Analyzing code...
call flutter analyze

if %ERRORLEVEL% NEQ 0 (
    echo ⚠️  Found some issues in code analysis
) else (
    echo ✅ No issues found
)

echo.
echo ✨ Setup complete!
echo.
echo 📝 Next steps:
echo 1. Configure Firebase (see FIREBASE_SETUP.md)
echo 2. Run 'flutter run' to start the app
echo.
echo 📱 Supported platforms:
echo    - iOS: flutter run -d ios
echo    - Android: flutter run -d android
echo    - Web: flutter run -d chrome

pause
