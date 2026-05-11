# Marketing Orchestration

## Control Model

The marketing pod is controlled from a command center. For now, that command center can be this Codex chat plus this file.

Agents may:
- Research audiences and channels
- Draft marketing assets
- Prepare release plans
- Review claims
- Suggest experiments
- Update local docs and approved project files

Agents may not:
- Publish public posts without approval
- Send emails without approval
- Change pricing without approval
- Invent testimonials, download counts, or benchmarks
- Claim signing, notarization, or security review before completion

## Agent Pod

### Marketing Director Agent

Owns weekly priorities and campaign sequencing.

Inputs:
- Product status
- Launch plan
- Analytics
- User feedback

Outputs:
- Weekly campaign plan
- Task assignments
- Approval queue

### Research Agent

Finds relevant audience pain points and market language.

Focus topics:
- MacBook battery drain during sleep
- Power Nap
- macOS background wake
- TCP keepalive
- menu bar utilities
- indie Mac apps

### Content Agent

Writes campaign assets.

Outputs:
- Launch posts
- Product Hunt copy
- README improvements
- Landing page sections
- Email/newsletter pitches

### Community Agent

Drafts helpful replies for communities.

Rules:
- Be useful first
- Mention the app only when directly relevant
- Provide a manual alternative when appropriate
- Never spam

### SEO Agent

Creates search-led content plans.

Starter topics:
- What is Power Nap on Mac?
- Why does my MacBook lose battery while sleeping?
- How to disable TCP keepalive on macOS
- macOS Power Nap vs Battery Saver

### Safety Reviewer

Blocks risky or inaccurate claims.

Checks:
- Accuracy
- Tone
- Unsupported claims
- Platform rules
- Privacy wording
- Pricing clarity

### Analytics Agent

Tracks launch performance.

Metrics:
- Landing page visits
- Download clicks
- GitHub stars
- Release downloads
- Conversion rate after paid switch
- Top support questions

## Weekly Control Prompt

```text
Review the current PowerNap Toggler launch plan, product status, and campaign queue.

Goal:
Launch free for 30 days, learn from users, then move to a $9 one-time license.

Return:
- This week's 3 highest-impact marketing tasks
- Agent owner for each task
- Drafts needed
- Approval required
- Success metric
- Risks or blockers
```

## Campaign Approval Template

```text
Campaign:
Channel:
Asset:
Goal:
Primary CTA:
Claims made:
Safety review:
Approved by:
Publish date:
Metric to check:
```

## Launch Month Campaigns

### Campaign 1: Free Launch Month

Message:

> PowerNap Toggler is free through June 8, 2026. Tiny macOS menu bar app. Switch between Battery Saver and Normal Mode. No tracking. No App Store required.

Channels:
- Landing page
- GitHub release
- X/Twitter
- Product Hunt
- Indie Hackers

### Campaign 2: Battery Drain Help

Message:

> If your MacBook loses battery while sleeping, Power Nap and keepalive behavior may be part of the story. PowerNap Toggler gives you a clean menu bar switch for those settings.

Channels:
- SEO posts
- Reddit helpful replies
- Hacker News comments when relevant

### Campaign 3: Build in Public

Message:

> Rebuilt an old tiny Mac utility into a cleaner menu bar app: glossy dark popover, minimal icon, verified system state, no tracking.

Channels:
- X/Twitter
- GitHub
- Indie Hackers
