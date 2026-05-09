#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH="${BASH_SOURCE[0]:-${(%):-%x}}"
ROOT_DIR="$(cd "$(dirname "$SCRIPT_PATH")/.." && pwd)"
APP_DIR="$ROOT_DIR/dist/PowerNap Toggler.app"
SIGNED_ZIP="$ROOT_DIR/dist/PowerNap-Toggler-Free-Launch-Month-signed.zip"
VERIFY_DIR="$ROOT_DIR/.build/notary-verify"
NOTARY_PROFILE="${NOTARY_PROFILE:-powernap-toggler-notary}"
NOTARY_TEAM_ID="${NOTARY_TEAM_ID:-479W234Y67}"
STAPLE_APP="${STAPLE_APP:-0}"

if [[ -z "${DEVELOPER_DIR:-}" && -d "/Applications/Xcode.app/Contents/Developer" ]]; then
  export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
fi

if [[ -z "${DEVELOPER_ID_APPLICATION:-}" ]]; then
  echo "Set DEVELOPER_ID_APPLICATION to your Developer ID Application signing identity."
  echo "Example: export DEVELOPER_ID_APPLICATION='Developer ID Application: Your Name (TEAMID)'"
  exit 1
fi

if ! security find-identity -v -p codesigning | grep -F "$DEVELOPER_ID_APPLICATION" >/dev/null; then
  echo "Could not find signing identity:"
  echo "  $DEVELOPER_ID_APPLICATION"
  echo
  echo "Available code signing identities:"
  security find-identity -v -p codesigning || true
  exit 1
fi

if ! xcrun notarytool history \
    --keychain-profile "$NOTARY_PROFILE" \
    --team-id "$NOTARY_TEAM_ID" \
    --output-format json >/dev/null 2>&1; then
  echo "Could not access notary profile:"
  echo "  $NOTARY_PROFILE"
  echo
  echo "Create it with:"
  echo "  xcrun notarytool store-credentials $NOTARY_PROFILE --apple-id \"alonxattias@gmail.com\" --team-id \"$NOTARY_TEAM_ID\""
  exit 1
fi

cd "$ROOT_DIR"
if [[ "${SKIP_BUILD:-0}" == "1" ]]; then
  if [[ ! -d "$APP_DIR" ]]; then
    echo "SKIP_BUILD=1 was set, but the app bundle does not exist:"
    echo "  $APP_DIR"
    exit 1
  fi
  echo "Skipping build and signing existing app bundle:"
  echo "  $APP_DIR"
else
  "$ROOT_DIR/Scripts/build_app.sh"
fi

unlink "$APP_DIR/Contents/CodeResources" 2>/dev/null || true
find "$APP_DIR" -name ".DS_Store" -type f -delete 2>/dev/null || true
xattr -cr "$APP_DIR" 2>/dev/null || true

codesign \
  --force \
  --options runtime \
  --timestamp \
  --sign "$DEVELOPER_ID_APPLICATION" \
  "$APP_DIR"

codesign --verify --deep --strict --verbose=2 "$APP_DIR"
codesign -dv --verbose=4 "$APP_DIR"

rm -f "$SIGNED_ZIP"
ditto -c -k --keepParent "$APP_DIR" "$SIGNED_ZIP"

rm -rf "$VERIFY_DIR"
mkdir -p "$VERIFY_DIR"
ditto -x -k "$SIGNED_ZIP" "$VERIFY_DIR"
codesign --verify --deep --strict --verbose=2 "$VERIFY_DIR/PowerNap Toggler.app"

xcrun notarytool submit "$SIGNED_ZIP" \
  --keychain-profile "$NOTARY_PROFILE" \
  --team-id "$NOTARY_TEAM_ID" \
  --wait

if [[ "$STAPLE_APP" == "1" ]]; then
  xcrun stapler staple "$APP_DIR"
  xcrun stapler validate "$APP_DIR"
  codesign --verify --deep --strict --verbose=2 "$APP_DIR"
  rm -f "$SIGNED_ZIP"
  ditto -c -k --keepParent "$APP_DIR" "$SIGNED_ZIP"
else
  echo "Skipping stapling. The ZIP was accepted by Apple notarization."
  echo "Gatekeeper can verify notarization online for this signed ZIP."
fi

echo "Signed and notarized: $SIGNED_ZIP"
