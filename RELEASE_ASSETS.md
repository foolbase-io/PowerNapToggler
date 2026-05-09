# Release Assets

## Free Launch Month Build

Unsigned fallback artifact:

```text
dist/PowerNap-Toggler-Free-Launch-Month.zip
```

Signed and notarized release artifact:

```text
dist/PowerNap-Toggler-Free-Launch-Month-signed.zip
```

GitHub release:

```text
https://github.com/foolbase-io/PowerNapToggler/releases/tag/v1.0.0
```

Public download URL:

```text
https://github.com/foolbase-io/PowerNapToggler/releases/download/v1.0.0/PowerNap-Toggler-Free-Launch-Month-signed.zip
```

Size:

```text
184 KB
```

SHA-256:

```text
0f2e886f1530e629bc9d914e124f41c089ef48b29def662846c7fe9d4c013f57
```

Apple notarization submission:

```text
538a9f26-76ac-4066-a803-ebb093f711e1
```

Status:

```text
Accepted
```

## Notes

- The signed ZIP is suitable as the first GitHub Releases asset.
- DMG packaging is scripted, but the current sandbox returned a disk-image creation error, so the ZIP fallback is the artifact available from this environment.
- The app is signed with Developer ID Application: Alon Atias (479W234Y67).
- The signed ZIP was accepted by Apple notarization.
- Stapling is skipped by default for this hand-built Swift package bundle; Gatekeeper can verify the notarization online.
