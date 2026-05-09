#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="${BASH_SOURCE[0]:-${(%):-%x}}"
ROOT_DIR="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd)"
APP_DIR="$ROOT_DIR/dist/PowerNap Toggler.app"
DMG_PATH="$ROOT_DIR/dist/PowerNap-Toggler-Free-Launch-Month.dmg"
ZIP_PATH="$ROOT_DIR/dist/PowerNap-Toggler-Free-Launch-Month.zip"
STAGING_DIR="$ROOT_DIR/.build/dmg-staging"

cd "$ROOT_DIR"
"$ROOT_DIR/Scripts/build_app.sh"

rm -rf "$STAGING_DIR" "$DMG_PATH" "$ZIP_PATH"
mkdir -p "$STAGING_DIR"
cp -R "$APP_DIR" "$STAGING_DIR/"
ln -s /Applications "$STAGING_DIR/Applications"

if hdiutil create \
    -volname "PowerNap Toggler" \
    -srcfolder "$STAGING_DIR" \
    -ov \
    -format UDZO \
    "$DMG_PATH" >/dev/null 2>/dev/null; then
  echo "Packaged: $DMG_PATH"
else
  ditto -c -k --keepParent "$APP_DIR" "$ZIP_PATH"
  echo "DMG packaging was unavailable in this environment."
  echo "Packaged: $ZIP_PATH"
fi
