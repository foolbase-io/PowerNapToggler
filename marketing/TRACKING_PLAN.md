# Tracking Plan (Prep Only) — PowerNap Toggler

Goal: track **downloads by source** during the free launch window without adding in-app tracking.

Owner decision: simple tracking approved. Do not add a redirect/analytics layer yet.

## Canonical link rules

1. Use one **canonical download** destination (GitHub Releases asset) and link to it everywhere unless a channel requires otherwise.
2. For attribution, use **distinct landing page URLs** per source. Treat the landing page visit and CTA click as the attribution boundary; GitHub release asset downloads are counted only as totals unless a separate redirect layer is added.
3. Keep a single “fallback download” link (unsigned ZIP) for troubleshooting only.

## Source taxonomy

- `landing` — main landing page CTA click
- `github` — GitHub repo README or release page click
- `ph` — Product Hunt
- `x` — X / Twitter
- `reddit` — Reddit
- `hn` — Hacker News
- `directories` — macOS app directories
- `ih` — Indie Hackers

## UTM scheme

Use this pattern:

- `utm_source`: one of the taxonomy values above
- `utm_medium`: `social`, `community`, `directory`, or `owned`
- `utm_campaign`: `launch_window_2026_05`
- `utm_content`: optional, e.g. `post_1`, `comment_1`, `hero_cta`

Example (illustrative):

- landing hero CTA: `utm_source=landing&utm_medium=owned&utm_campaign=launch_window_2026_05&utm_content=hero_cta`

## Link map

Use the landing page for public social/community posts when possible:

- Main landing page: `https://powernaptoggler.framer.ai/`
- GitHub release: `https://github.com/foolbase-io/PowerNapToggler/releases/tag/v1.0.1`
- Current signed ZIP: `https://github.com/foolbase-io/PowerNapToggler/releases/download/v1.0.1/PowerNap-Toggler-Free-Launch-Month-signed.zip`

Recommended source URLs:

- X/Twitter: `https://powernaptoggler.framer.ai/?utm_source=x&utm_medium=social&utm_campaign=launch_window_2026_05&utm_content=post_1`
- Indie Hackers: `https://powernaptoggler.framer.ai/?utm_source=ih&utm_medium=community&utm_campaign=launch_window_2026_05&utm_content=build_in_public`
- Hacker News: `https://powernaptoggler.framer.ai/?utm_source=hn&utm_medium=community&utm_campaign=launch_window_2026_05&utm_content=show_hn`
- Reddit: `https://powernaptoggler.framer.ai/?utm_source=reddit&utm_medium=community&utm_campaign=launch_window_2026_05&utm_content=helpful_reply`
- Product Hunt: `https://powernaptoggler.framer.ai/?utm_source=ph&utm_medium=community&utm_campaign=launch_window_2026_05&utm_content=product_hunt`
- Directories: `https://powernaptoggler.framer.ai/?utm_source=directories&utm_medium=directory&utm_campaign=launch_window_2026_05&utm_content=listing`

Note: v1.0.1 is the promotion target once the GitHub release asset is uploaded.

## Weekly reporting template

Create a weekly snapshot with:

- Landing page visits by UTM source, if Framer or the analytics surface exposes them
- CTA clicks by source, if available
- GitHub release asset downloads as total downloads
- GitHub stars (delta)
- Top support questions (qualitative)

## Notes / constraints

- GitHub asset downloads are not source-attributed by default. Do not report source-level downloads unless a redirect layer or analytics tool captures them.
- Do not add analytics SDKs or in-app tracking as part of this plan.
