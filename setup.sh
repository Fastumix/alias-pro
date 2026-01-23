#!/bin/bash

echo "🚀 Starting Alias Pro Flutter project setup..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null
then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "✅ Flutter found"

# Get Flutter dependencies
echo "📦 Installing dependencies..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Failed to get dependencies"
    exit 1
fi

echo "✅ Dependencies installed"

# Check for Firebase configuration files
if [ ! -f "android/app/google-services.json" ]; then
    echo "⚠️  Warning: android/app/google-services.json not found"
    echo "   Please add your Firebase configuration file"
    echo "   See FIREBASE_SETUP.md for instructions"
fi

if [ ! -f "ios/Runner/GoogleService-Info.plist" ]; then
    echo "⚠️  Warning: ios/Runner/GoogleService-Info.plist not found"
    echo "   Please add your Firebase configuration file"
    echo "   See FIREBASE_SETUP.md for instructions"
fi

# Run code generation if needed
echo "🔨 Running code generation..."
# flutter pub run build_runner build --delete-conflicting-outputs

# Run tests
echo "🧪 Running tests..."
flutter test

if [ $? -ne 0 ]; then
    echo "⚠️  Some tests failed"
else
    echo "✅ All tests passed"
fi

# Check for issues
echo "🔍 Analyzing code..."
flutter analyze

if [ $? -ne 0 ]; then
    echo "⚠️  Found some issues in code analysis"
else
    echo "✅ No issues found"
fi

echo ""
echo "✨ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Configure Firebase (see FIREBASE_SETUP.md)"
echo "2. Run 'flutter run' to start the app"
echo ""
echo "📱 Supported platforms:"
echo "   - iOS: flutter run -d ios"
echo "   - Android: flutter run -d android"
echo "   - Web: flutter run -d chrome"
