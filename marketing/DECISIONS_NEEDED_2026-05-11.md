# Decisions Needed — PowerNap Toggler Marketing

Status: owner decision list after Google AI SEO compliance review.

Owner approvals recorded:
- Approved article routes.
- Approved simple tracking.
- Approved article order.
- Approved waiting for v1.0.1 before broad promotion.
- v1.0.1 signed/notarized release uploaded.

## Default Recommendation

Do not blast all three articles at once.

Use a two-track plan:

1. **Quiet indexing track:** publish one source-backed explainer first, without heavy promotion.
2. **Promotion track:** promote only the strongest problem-solving article after it has original proof, screenshots, and the v1.0.1 link decision is resolved.

## Decisions For Alon

### 1) Publish links: v1.0.0 now or wait for v1.0.1?

Recommended decision:

> Wait for v1.0.1 before broad promotion. Quiet publishing for indexing is okay if the article says the current public signed ZIP is v1.0.0.

Why:
- v1.0.1 contains the calendar-based paid cutoff.
- Directories and Hacker News should not point to stale release links.
- Quiet indexing is lower risk than social promotion.

Decision needed:

- [ ] Publish articles now with v1.0.0 links
- [ ] Hold all articles until v1.0.1 is live
- [x] Approved: publish quietly only if needed; broad promotion waits for v1.0.1

### 2) Final public article routes

Recommended routes:

- `/what-is-power-nap-on-mac`
- `/what-is-tcp-keepalive-macos`
- `/macbook-battery-drains-while-sleeping`

Decision needed:

- [x] Approved these routes
- [ ] Choose different Framer routes

### 3) Attribution level

Recommended decision:

> Keep tracking simple for now: UTM landing-page visits, CTA clicks if Framer exposes them, total GitHub downloads, and GitHub stars.

Why:
- GitHub release downloads are not source-attributed by default.
- A redirect/analytics layer adds setup complexity before we have enough traffic.

Decision needed:

- [x] Approved: simple tracking now
- [ ] Add redirect/analytics layer for source-attributed downloads

### 4) Pricing language

Recommended decision:

> Keep “Free through June 8, 2026, then planned at $9 once.”

Why:
- It is honest while v1.0.1/payment flow is still being finalized.
- It avoids overpromising if payment/licensing timing changes.

Decision needed:

- [x] Recommended: “planned at $9 once”
- [ ] Make “$9 once starting June 9, 2026” definitive everywhere

### 5) Hacker News

Recommended decision:

> Hold Hacker News until v1.0.1 is live, the landing page is clean, and the HN copy is technical.

Why:
- HN will scrutinize direct-download Mac apps, admin prompts, and technical claims.
- HN should get the technical app story, not the launch offer.

Decision needed:

- [x] Approved: hold HN
- [ ] Skip HN entirely
- [ ] Post HN immediately

### 6) Article publish order

There was a useful agent disagreement:

- Compliance agent prefers the battery-drain guide first because it best serves user intent.
- AI-search agent prefers the Power Nap guide first because it is easiest to make source-backed and citation-ready.

Recommended resolution:

1. Publish `/what-is-power-nap-on-mac` quietly first, because it has the clearest Apple source.
2. Publish `/what-is-tcp-keepalive-macos` after adding RFC/source support.
3. Publish and promote `/macbook-battery-drains-while-sleeping` last as the conversion hub, after both supporting pages are live and internal links work.

Decision needed:

- [x] Approved: explainer-first indexing, battery-drain promotion later
- [ ] Publish battery-drain guide first
- [ ] Hold all SEO until every article is fully complete

## Required Before Publishing Any Article

- [ ] Add a direct 40-60 word answer block.
- [ ] Add visible author/maker attribution.
- [ ] Add last-updated date.
- [ ] Replace bare URLs with named links in Framer.
- [ ] Add FAQ section.
- [ ] Add schema plan: Article + FAQPage + BreadcrumbList where visible.
- [ ] Add at least one original proof element: screenshot, real command output, or tested-on note.

## Required Before Promotion

- [x] v1.0.1 release link is live.
- [ ] Landing page visual QA complete.
- [ ] Main battery-drain guide includes original screenshots or command-output example.
- [ ] No claims of guaranteed battery improvement.
- [ ] No mass publishing of near-duplicate pages.
