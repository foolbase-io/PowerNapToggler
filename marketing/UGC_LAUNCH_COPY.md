# UGC Launch Copy

Tone: indie maker, relatable, useful, lightly funny. Lead with the Mac battery problem, then introduce PowerNap Toggler as the tiny fix.

## Core Angle

Your MacBook should not feel like it ran errands while it was asleep.

The founder moment: closing a MacBook at night, opening it later, and getting that tiny "wait, why is the battery lower?" annoyance. PowerNap Toggler is built for that specific feeling, not as a giant battery suite.

PowerNap Toggler is a tiny macOS menu bar app that switches Power Nap and TCP keepalive between Battery Saver and Normal Mode. It is free during the launch window, then moves to a $9 one-time license.

No tracking. No App Store. No subscription.

## X / Twitter

### Post 1

I got tired of opening my MacBook and wondering why the battery dropped while it was supposed to be sleeping.

So I rebuilt a tiny menu bar app I made:

PowerNap Toggler.

It switches Power Nap + TCP keepalive between Battery Saver and Normal Mode.

Free through June 8, 2026.

### Post 2

Tiny indie app launch:

PowerNap Toggler sits in your Mac menu bar and gives you one clean switch:

- Battery Saver
- Normal Mode

It controls Power Nap + TCP keepalive, explains the macOS permission prompt, and does not track anything.

Free through June 8, 2026, then planned at $9 once.

### Post 3

MacBook battery drain while sleeping is one of those small problems that makes you feel slightly insane.

PowerNap Toggler is my tiny attempt to make it less annoying:

one menu bar switch for Power Nap + TCP keepalive.

No account. No tracking. Just a little Mac utility.

### Post 4

I did not want a giant battery app.

I wanted one switch for one annoying Mac problem:

When I care about battery, quiet background wake/network behavior.
When I need normal behavior, turn it back on.

That is PowerNap Toggler.

Free through June 8, 2026.

## Indie Hackers / Build In Public

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

It is free during the launch window while I collect feedback, then it moves to a $9 one-time license.

I would love feedback from MacBook users, indie devs, and anyone who has opened their laptop and thought: "why is the battery lower, it was asleep."

## Product Hunt Archive

This section is historical after the quiet Product Hunt launch. Do not reuse as an active launch asset. Repurpose the angle into a "what I learned from a quiet Product Hunt launch" post instead.

## Original Product Hunt Draft

### Tagline

A tiny Mac menu bar switch for sleep battery drain annoyances

### Short Description

PowerNap Toggler helps Mac users switch Power Nap and TCP keepalive between Battery Saver and Normal Mode from one compact menu bar panel. Built by an indie maker, free during launch, no tracking, no subscription.

### First Comment

Hey Product Hunt,

I built PowerNap Toggler because I kept running into a small but annoying MacBook problem: sleep does not always feel like sleep.

Sometimes you open the laptop and the battery is lower than expected. There are a bunch of possible reasons, but Power Nap and TCP keepalive are two built-in macOS behaviors worth checking when background wake or network activity is part of the story.

PowerNap Toggler keeps that simple:

- Battery Saver turns Power Nap and TCP keepalive off
- Normal Mode turns them back on

The app lives in the menu bar, explains the macOS admin prompt before changing settings, verifies state after changes, and does not track anything.

I rebuilt it as a tiny indie utility: minimal icon, glossy dark panel, one job.

It is free during the launch window, then it moves to a $9 one-time license.

Would love feedback from MacBook users, indie devs, and anyone who has chased weird battery drain while the lid was closed.

## Reddit / Hacker News Reply

### Helpful Reply, No Product Mention

One thing worth checking is whether macOS is doing background wake or network activity while the machine is idle/asleep.

Two settings that can be relevant:

```bash
pmset -g custom | grep powernap
sysctl net.inet.tcp.always_keepalive
```

Turning them off can reduce that kind of background behavior, but it depends on whether you want the Mac to keep doing things in the background while asleep.

### Helpful Reply, Soft Product Mention

One thing worth checking is whether Power Nap or TCP keepalive is part of the sleep-drain story.

You can inspect them manually:

```bash
pmset -g custom | grep powernap
sysctl net.inet.tcp.always_keepalive
```

Disclosure: I made a tiny menu bar app called PowerNap Toggler for this exact annoyance. It switches those settings between Battery Saver and Normal Mode without making you remember the commands.

I would still start with the commands above first, because it is useful to know what your Mac is actually reporting before installing anything.

## Landing Page Hero Options

### Option A

Headline: Your MacBook should sleep like it means it.

Subheadline: PowerNap Toggler is a tiny menu bar app that switches Power Nap and TCP keepalive between Battery Saver and Normal Mode.

CTA: Download Free During Launch

### Option B

Headline: A tiny switch for sneaky Mac battery drain.

Subheadline: Quiet background wake/network behavior when you care about battery. Turn normal behavior back on when you need it.

CTA: Get PowerNap Toggler

### Option C

Headline: Stop guessing why your Mac lost battery asleep.

Subheadline: PowerNap Toggler gives you one clean menu bar control for Power Nap and TCP keepalive.

CTA: Download the Launch Build

## Safety Notes

- Do not promise a fixed percentage of battery improvement.
- Say Power Nap and TCP keepalive can be part of the sleep-drain story, not always the only cause.
- Keep the offer phrasing as "free during the launch window, then $9 once."
- Do not say early users keep it free forever.
- Do not claim App Store availability.
