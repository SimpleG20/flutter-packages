#!/bin/bash

# Script to automate tagging for a specific package in the monorepo

set -e

PACKAGE_NAME=$1

if [ -z "$PACKAGE_NAME" ]; then
  echo "Error: Package name argument is required."
  echo "Usage: ./scripts/create_tag.sh <package_name>"
  exit 1
fi

if [ ! -d "$PACKAGE_NAME" ]; then
  echo "Error: Directory '$PACKAGE_NAME' does not exist."
  exit 1
fi

PUBSPEC="$PACKAGE_NAME/pubspec.yaml"

if [ ! -f "$PUBSPEC" ]; then
  echo "Error: pubspec.yaml not found in '$PACKAGE_NAME'."
  exit 1
fi

# Extract version from pubspec.yaml
VERSION=$(grep '^version:' "$PUBSPEC" | sed 's/version: //' | tr -d '\r')

if [ -z "$VERSION" ]; then
  echo "Error: Could not extract version from $PUBSPEC."
  exit 1
fi

TAG_NAME="${PACKAGE_NAME}-v${VERSION}"

echo "Package: $PACKAGE_NAME"
echo "Version: $VERSION"
echo "Tag:     $TAG_NAME"

# Check if tag already exists
if git rev-parse "$TAG_NAME" >/dev/null 2>&1; then
  echo "Warning: Tag '$TAG_NAME' already exists."
  read -p "Do you want to delete and recreate it? (y/N) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    git tag -d "$TAG_NAME"
    git push origin :refs/tags/"$TAG_NAME" || true # Try to delete remote tag
  else
    echo "Aborted."
    exit 0
  fi
fi

# Create tag
git tag "$TAG_NAME"
echo "Tag '$TAG_NAME' created locally."

# Ask to push
read -p "Do you want to push the tag to origin? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git push origin "$TAG_NAME"
  echo "Tag pushed to origin."
else
  echo "Tag NOT pushed. Run 'git push origin $TAG_NAME' manually."
fi
