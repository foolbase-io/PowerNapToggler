# Release Assets

## Free Launch Month Build — v1.0.1

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
https://github.com/foolbase-io/PowerNapToggler/releases/tag/v1.0.1
```

Public download URL:

```text
https://github.com/foolbase-io/PowerNapToggler/releases/download/v1.0.1/PowerNap-Toggler-Free-Launch-Month-signed.zip
```

Size:

```text
196 KB
```

SHA-256:

```text
eeffbe65ba925068ea873cd2cbcd7ca735c24c039ee155ed1c06b43505d459b6
```

Apple notarization submission:

```text
50788af1-298b-4f1d-a31c-9584f7f73423
```

Status:

```text
Accepted
```

## Notes

- The signed ZIP is suitable as the v1.0.1 GitHub Releases asset.
- DMG packaging is scripted, but the current sandbox returned a disk-image creation error, so the ZIP fallback is the artifact available from this environment.
- The app is signed with Developer ID Application: Alon Atias (479W234Y67).
- The signed ZIP was accepted by Apple notarization.
- Stapling is skipped by default for this hand-built Swift package bundle; Gatekeeper can verify the notarization online.
