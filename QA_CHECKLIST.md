# QA Checklist

Run this on a real Mac before publishing the release.

## Install

- [ ] DMG opens.
- [ ] App can be dragged into Applications.
- [ ] App launches from Applications.
- [ ] App appears only in the menu bar.
- [ ] App icon remains minimal and legible in light and dark menu bars.

## Panel

- [ ] Clicking the menu icon opens the panel.
- [ ] Panel fits on the screen.
- [ ] Panel scrolls if content is clipped.
- [ ] Quit button exits the app.
- [ ] Right-click menu opens.
- [ ] Right-click Quit exits the app.

## First Run

- [ ] First privileged action shows the in-app permission explanation.
- [ ] macOS administrator prompt appears after clicking the mode switch.
- [ ] Cancelling the prompt shows a clear cancellation message.
- [ ] Cancelling does not change the displayed mode incorrectly.

## Core Behavior

- [ ] Battery Saver applies successfully.
- [ ] Normal Mode applies successfully.
- [ ] Power Nap state indicator updates after applying.
- [ ] TCP keepalive state indicator updates after applying.
- [ ] Refresh button updates displayed state.
- [ ] UI does not show success if a command fails.

## Packaging

- [ ] DMG filename is correct.
- [ ] README and release notes match the shipped behavior.
- [ ] Landing page CTA points to the final release asset.
- [ ] Price copy says free through June 8, 2026, then paid.
