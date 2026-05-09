#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="${BASH_SOURCE[0]:-${(%):-%x}}"
ROOT_DIR="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd)"
BUILD_DIR="$ROOT_DIR/.build/release"
APP_DIR="$ROOT_DIR/dist/PowerNap Toggler.app"
CONTENTS_DIR="$APP_DIR/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"
CACHE_DIR="$ROOT_DIR/.build/cache"
MODULE_CACHE_DIR="$ROOT_DIR/.build/clang-module-cache"
ASSET_INFO="$ROOT_DIR/.build/asset-info.plist"

if [[ -z "${DEVELOPER_DIR:-}" && -d "/Applications/Xcode.app/Contents/Developer" ]]; then
  export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
fi
SWIFT_BIN="$(xcrun --find swift)"
ACTOOL_BIN="$(xcrun --find actool)"

cd "$ROOT_DIR"
mkdir -p "$CACHE_DIR" "$MODULE_CACHE_DIR"
CLANG_MODULE_CACHE_PATH="$MODULE_CACHE_DIR" "$SWIFT_BIN" build -c release --disable-sandbox --cache-path "$CACHE_DIR" --manifest-cache local

rm -rf "$APP_DIR"
mkdir -p "$MACOS_DIR" "$RESOURCES_DIR"
cp "$BUILD_DIR/PowerNapToggler" "$MACOS_DIR/PowerNapToggler"
cp "$ROOT_DIR/Resources/Info.plist" "$CONTENTS_DIR/Info.plist"
"$ACTOOL_BIN" \
  --compile "$RESOURCES_DIR" \
  --platform macosx \
  --minimum-deployment-target 14.0 \
  --app-icon AppIcon \
  --output-partial-info-plist "$ASSET_INFO" \
  "$ROOT_DIR/Assets.xcassets" >/dev/null 2>/dev/null

echo "Built: $APP_DIR"
