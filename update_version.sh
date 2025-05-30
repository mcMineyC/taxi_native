#!/bin/bash

# Script to extract version from constants.dart and update pubspec.yaml

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define file paths
CONSTANTS_FILE="$SCRIPT_DIR/lib/helpers/constants.dart"
PUBSPEC_FILE="$SCRIPT_DIR/pubspec.yaml"
BUILD_GRADLE_FILE="$SCRIPT_DIR/android/app/build.gradle"

# Check if files exist
if [[ ! -f "$CONSTANTS_FILE" ]]; then
    echo "Error: constants.dart not found at $CONSTANTS_FILE"
    exit 1
fi

if [[ ! -f "$PUBSPEC_FILE" ]]; then
    echo "Error: pubspec.yaml not found at $PUBSPEC_FILE"
    exit 1
fi

if [[ ! -f "$BUILD_GRADLE_FILE" ]]; then
    echo "Warning: build.gradle not found at $BUILD_GRADLE_FILE"
    echo "Android version will not be updated"
    UPDATE_ANDROID=false
else
    UPDATE_ANDROID=true
fi

# Extract version from constants.dart
# Look for: String kVersionString = "x.x.x";
VERSION=$(grep -o 'kVersionString = "[^"]*"' "$CONSTANTS_FILE" | sed 's/kVersionString = "\(.*\)"/\1/')

if [[ -z "$VERSION" ]]; then
    echo "Error: Could not extract version from $CONSTANTS_FILE"
    echo "Looking for pattern: String kVersionString = \"x.x.x\";"
    exit 1
fi

echo "Extracted version: $VERSION"

# Get current version from pubspec.yaml
CURRENT_VERSION=$(grep '^version:' "$PUBSPEC_FILE" | sed 's/version: *//')

echo "Current pubspec.yaml version: $CURRENT_VERSION"

# Update pubspec.yaml with the new version
sed -i "s/^version:.*/version: $VERSION/" "$PUBSPEC_FILE"

if [[ $? -eq 0 ]]; then
    echo "✓ Successfully updated pubspec.yaml version from $CURRENT_VERSION to $VERSION"
else
    echo "✗ Failed to update pubspec.yaml"
    exit 1
fi

# Update Android build.gradle if it exists
if [[ "$UPDATE_ANDROID" == true ]]; then
    echo ""
    echo "Updating Android version information..."
    
    # Calculate versionCode from version string (e.g., 4.1.7 -> 40107)
    IFS='.' read -ra VERSION_PARTS <<< "$VERSION"
    MAJOR=${VERSION_PARTS[0]:-1}
    MINOR=${VERSION_PARTS[1]:-0}
    PATCH=${VERSION_PARTS[2]:-0}
    VERSION_CODE=$((MAJOR * 10000 + MINOR * 100 + PATCH))
    
    echo "Calculated Android versionCode: $VERSION_CODE"
    echo "Android versionName will be: $VERSION"
    echo ""
    echo "Note: Your build.gradle is already configured to read versions from pubspec.yaml"
    echo "✓ Android version will be automatically updated on next build"
fi