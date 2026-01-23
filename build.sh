#!/bin/bash

echo "🚀 Building Alias Pro for production..."

# Build for web
flutter build web --release --web-renderer canvaskit

echo "✅ Build complete!"
echo "📦 Output directory: build/web"
echo ""
echo "To deploy to Netlify:"
echo "  netlify deploy --prod"
