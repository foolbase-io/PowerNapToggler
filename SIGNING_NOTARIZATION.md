# Signing and Notarization

PowerNap Toggler is distributed outside the Mac App Store, so the polished launch path is:

1. Sign the app with a **Developer ID Application** certificate.
2. Zip the signed app.
3. Submit the ZIP to Apple notarization with `notarytool`.
4. Staple the notarization ticket to the app.
5. Zip the stapled app for release.

Apple's notarization service is not App Review. It scans Developer ID-signed macOS software for malicious content and common signing issues, then returns a ticket that Gatekeeper can use when users launch the app.

## What You Need

- Active Apple Developer Program membership.
- A **Developer ID Application** certificate installed in Keychain Access.
- Notary credentials stored with `xcrun notarytool`.

Check whether this Mac has a signing identity:

```bash
security find-identity -v -p codesigning
```

Current status from this environment:

```text
0 valid identities found
```

That means signing cannot be completed here until a Developer ID certificate is installed.

## Create or Install the Developer ID Certificate

Use Xcode or the Apple Developer portal to create/download a **Developer ID Application** certificate.

After installing it, `security find-identity -v -p codesigning` should show something like:

```text
Developer ID Application: Your Name (TEAMID)
```

## Store Notary Credentials

Recommended profile name:

```text
powernap-toggler-notary
```

Option A: Apple ID and app-specific password:

```bash
xcrun notarytool store-credentials powernap-toggler-notary \
  --apple-id "YOUR_APPLE_ID_EMAIL" \
  --team-id "YOUR_TEAM_ID"
```

The tool will securely prompt for the app-specific password if you omit `--password`.

Option B: App Store Connect API key:

```bash
xcrun notarytool store-credentials powernap-toggler-notary \
  --key "/path/to/AuthKey_KEYID.p8" \
  --key-id "KEYID" \
  --issuer "ISSUER-UUID"
```

## Sign and Notarize

After the certificate and credentials exist:

```bash
export DEVELOPER_ID_APPLICATION="Developer ID Application: Your Name (TEAMID)"
export NOTARY_PROFILE="powernap-toggler-notary"
bash Scripts/sign_and_notarize.sh
```

The signed/notarized ZIP will be created at:

```text
dist/PowerNap-Toggler-Free-Launch-Month-signed.zip
```

By default, the script skips stapling because this hand-built Swift package app bundle can fail signature verification after `stapler` adds a ticket file. The ZIP is still submitted to and accepted by Apple notarization. To force stapling anyway:

```bash
export STAPLE_APP=1
bash Scripts/sign_and_notarize.sh
```

## Expected Gatekeeper Result

After notarization and stapling, users should see a more trusted macOS launch dialog instead of an unidentified-developer warning.

## Troubleshooting

- If notarization fails, run:

```bash
xcrun notarytool log SUBMISSION_ID --keychain-profile powernap-toggler-notary
```

- If signing fails, verify the certificate exists:

```bash
security find-identity -v -p codesigning
```

- If Gatekeeper assessment fails, inspect:

```bash
spctl --assess --type execute --verbose=4 "dist/PowerNap Toggler.app"
codesign --verify --deep --strict --verbose=2 "dist/PowerNap Toggler.app"
```
