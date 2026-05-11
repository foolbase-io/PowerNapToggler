# Launch Posts

## X / Twitter

### Post 1

PowerNap Toggler is free through June 8, 2026.

Tiny macOS menu bar app for switching between Battery Saver and Normal Mode by controlling Power Nap and TCP keepalive.

No tracking. No App Store required.

### Post 2

I rebuilt an old tiny Mac utility into something much cleaner:

- minimal menu bar icon
- glossy dark control panel
- Battery Saver / Normal Mode switch
- verifies macOS state after changes
- no tracking

Free through June 8, then $9 once.

### Post 3

If your MacBook loses battery while sleeping, background wake behavior may be part of the story.

PowerNap Toggler gives you a simple menu bar switch for Power Nap and TCP keepalive.

Free through June 8, then $9 once.

## Reddit / Hacker News Helpful Reply

### No Product Mention

One thing worth checking is whether Power Nap or TCP keepalive behavior is allowing background activity while the Mac is idle or asleep.

You can inspect these with native macOS tools:

```bash
pmset -g custom | grep powernap
sysctl net.inet.tcp.always_keepalive
```

Turning them off can reduce background wake/network behavior, though the right setting depends on whether you want the Mac to stay ready for background tasks.

### Soft Product Mention

One thing worth checking is whether Power Nap or TCP keepalive behavior is allowing background activity while the Mac is idle or asleep.

You can inspect these with:

```bash
pmset -g custom | grep powernap
sysctl net.inet.tcp.always_keepalive
```

I’m working on a tiny menu bar app called PowerNap Toggler that switches those between Battery Saver and Normal Mode if you prefer not to remember the commands. It is free through June 8, then $9 once.

## Indie Hackers / Build In Public

I’m relaunching a tiny macOS app I built a while ago.

PowerNap Toggler does one thing: switches Power Nap and TCP keepalive between Battery Saver and Normal Mode from the menu bar.

The rebuild focused on trust:

- clear permission explanation
- verified state after applying changes
- minimal menu icon
- dark compact control panel
- no tracking

Plan: launch free for one month, collect feedback, then move to a $9 one-time license.
