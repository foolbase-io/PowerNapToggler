# PowerNap Toggler

PowerNap Toggler is a lightweight macOS menu bar utility for switching your Mac between Normal Mode and Battery Saver.

- **Normal Mode** keeps Power Nap and TCP keepalive enabled.
- **Battery Saver** disables both settings to reduce background activity while your Mac is idle or asleep.

The app runs on-device and uses native macOS tools: `pmset` and `sysctl`.

## Build

```bash
CLANG_MODULE_CACHE_PATH="$PWD/.build/clang-module-cache" swift build --disable-sandbox --cache-path .build/cache --manifest-cache local
```

To create a local `.app` bundle:

```bash
bash Scripts/build_app.sh
```

The app bundle is created at:

```text
dist/PowerNap Toggler.app
```

To create a launch DMG, with a ZIP fallback if disk image creation is unavailable:

```bash
bash Scripts/package_dmg.sh
```

The DMG is created at:

```text
dist/PowerNap-Toggler-Free-Launch-Month.dmg
```

If DMG creation is blocked by the local environment, the ZIP fallback is created at:

```text
dist/PowerNap-Toggler-Free-Launch-Month.zip
```

## Notes

macOS asks for an administrator password before changing system energy settings. PowerNap Toggler explains this before applying changes and verifies the reported state after each update.

PowerNap Toggler is planned to launch free for the first month, then move to a one-time paid license.

For signing and notarization, see [SIGNING_NOTARIZATION.md](SIGNING_NOTARIZATION.md).
