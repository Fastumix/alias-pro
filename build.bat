@echo off
echo 🚀 Building Alias Pro for production...

REM Build for web
..\flutter\bin\flutter build web --release

echo ✅ Build complete!
echo 📦 Output directory: build/web
echo.
echo To deploy to Netlify:
echo   netlify deploy --prod
