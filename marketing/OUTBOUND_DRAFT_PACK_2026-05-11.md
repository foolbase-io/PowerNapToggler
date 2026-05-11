# Outbound Draft Pack — PowerNap Toggler

Status: ready to post manually after final approval.

Rules:
- Do not claim guaranteed battery savings.
- Do not imply Product Hunt traction.
- Do not invent user numbers, testimonials, or reviews.
- Prefer helpful education before app promotion in communities.
- Use the landing page first when possible, not a raw download link.

## X / Twitter

### Post 1 — Pain First

I got tired of opening my MacBook and wondering why the battery dropped while it was supposed to be sleeping.

So I rebuilt a tiny menu bar app:

PowerNap Toggler.

It switches Power Nap + TCP keepalive between Battery Saver and Normal Mode.

My favorite part is boring on purpose: it explains the admin prompt before changing anything.

### Post 2 — Builder Story

Tiny indie Mac app launch:

PowerNap Toggler gives you one clean switch:

- Battery Saver
- Normal Mode

It controls Power Nap + TCP keepalive, explains the macOS permission prompt, and does not track anything.

Free through June 8, 2026.

### Post 3 — Relatable Problem

MacBook battery drain while sleeping is one of those small problems that makes you feel slightly insane.

PowerNap Toggler is my tiny attempt to make it less annoying:

one menu bar switch for Power Nap + TCP keepalive.

No account. No tracking. No subscription.

### Post 4 — Direct Utility

I did not want a giant battery app.

I wanted one switch for one annoying Mac problem:

When I care about battery, quiet background wake/network behavior.
When I need normal behavior, turn it back on.

That is PowerNap Toggler.

## Indie Hackers

Title:

> I relaunched a tiny Mac app after getting annoyed by sleep battery drain

Post:

I just relaunched a tiny Mac app I built a while ago because the problem still annoys me:

MacBooks sometimes lose battery while they are supposed to be asleep.

Part of that can come from background wake/network behavior. macOS has settings for this, but they are not exactly friendly if you do not want to remember terminal commands.

So I rebuilt PowerNap Toggler as a small menu bar app with two modes:

- Battery Saver: turns off Power Nap and TCP keepalive
- Normal Mode: turns them back on

The rebuild is intentionally small:

- minimal menu bar icon
- glossy dark popover
- clear admin permission explanation
- verifies the reported macOS state after changes
- no tracking
- no subscription

It is free through June 8, 2026 while I collect feedback, then it is planned to move to a $9 one-time license.

Product Hunt was quiet, which honestly made the next step clearer: this probably grows from people actively searching for Mac sleep-drain fixes, not from a one-day launch event.

I would love feedback from MacBook users, indie devs, and anyone who has opened their laptop and thought: “why is the battery lower, it was asleep?”

## Hacker News

Title:

> Show HN: A tiny Mac menu bar app for Power Nap and TCP keepalive

Post:

I built PowerNap Toggler because I wanted a simple way to switch two macOS settings without remembering terminal commands:

- Power Nap
- TCP keepalive

The app has two modes:

- Battery Saver: turns both off
- Normal Mode: turns both back on

It uses native macOS tools (`pmset` and `sysctl`) and needs administrator permission because those settings are system-level. It does not claim to fix every sleep-drain cause; it only makes these two settings easier to inspect and switch.

It is a small direct-download Mac utility: signed and notarized for Gatekeeper, no tracking, no subscription, and no App Store dependency.

It is free through June 8, 2026 while I collect feedback, then planned as $9 once.

I am especially interested in feedback from people who have dealt with MacBook sleep battery drain or background wake behavior.

## Reddit Helpful Reply — No Product Mention

One thing worth checking is whether macOS is doing background wake or network activity while the machine is idle/asleep.

Two settings that can be relevant:

```bash
pmset -g custom | grep powernap
sysctl net.inet.tcp.always_keepalive
```

Turning them off can reduce that kind of background behavior, but it depends on whether you want the Mac to keep doing things in the background while asleep.

## Reddit Helpful Reply — Soft Mention

One thing worth checking is whether Power Nap or TCP keepalive is part of the sleep-drain story.

You can inspect them manually:

```bash
pmset -g custom | grep powernap
sysctl net.inet.tcp.always_keepalive
```

Disclosure: I made a tiny menu bar app called PowerNap Toggler for this exact annoyance. It switches those settings between Battery Saver and Normal Mode without making you remember the commands.

I would still start with the commands above first, because it is useful to know what your Mac is actually reporting before installing anything.

## Directory Blurb

PowerNap Toggler is a lightweight macOS menu bar utility for switching Power Nap and TCP keepalive between Battery Saver and Normal Mode. It is built for MacBook users who want a simple way to quiet background wake/network behavior when battery matters, then return to normal macOS behavior when needed.

No tracking. No subscription. Direct download. Current public ZIP is signed and notarized for Gatekeeper.

## Safety Review

Approved claims:
- Tiny macOS menu bar utility.
- Switches between Battery Saver and Normal Mode.
- Controls Power Nap and TCP keepalive.
- Runs on-device.
- No tracking.
- Direct download, no App Store required.
- Current public ZIP is signed and notarized for Gatekeeper.

Blocked claims:
- Guaranteed battery improvement.
- Specific battery percentage savings.
- Large user/download/review counts.
- “Security audited.”
- “Fixes all Mac sleep drain.”
