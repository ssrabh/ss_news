#!/bin/bash
set -e  # Exit if any command fails

# 1. Download and extract Flutter SDK
echo "📦 Downloading Flutter SDK..."
curl -L 'https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz' | tar xJ

# 2. Add Flutter to the PATH
export PATH="$PATH:$PWD/flutter/bin"

# 3. Verify installation (optional)
echo "🩺 Checking Flutter setup..."
flutter doctor

# 4. Get dependencies
echo "📦 Running flutter pub get..."
flutter pub get

# 5. Build the Flutter web app
echo "🚀 Building Flutter web release..."
flutter build web --release

# 6. Confirm success
echo "✅ Flutter web build complete!"