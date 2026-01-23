#!/bin/bash

set -e

echo "🚀 Installing Flutter..."

# Download and install Flutter
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Check Flutter
flutter --version

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Enable web
echo "🌐 Enabling web..."
flutter config --enable-web

# Build web
echo "🔨 Building web..."
flutter build web --release --web-renderer canvaskit

echo "✅ Build complete!"
