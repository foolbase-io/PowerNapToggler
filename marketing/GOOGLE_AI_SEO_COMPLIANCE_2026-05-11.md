# Google AI SEO Compliance — PowerNap Toggler

Status: working policy for publishing SEO articles without looking like scaled AI spam.

Sources checked:
- Google Search Central: guidance on using generative AI content on your website.
- Google Search Central: AI features and your website.
- Google Search Central: creating helpful, reliable, people-first content.
- Google Search Central: spam policies / scaled content abuse.
- Google Search Central Blog: Google Search guidance about AI-generated content.

## Google’s Practical Position

Google does not ban AI-assisted content just because AI helped create it.

The risk is content that is:
- Mass-produced.
- Thin or generic.
- Created mainly to manipulate rankings.
- Lacking original value.
- Inaccurate, misleading, or unsupported.
- Published at scale without human review.

For PowerNap Toggler, that means we can publish SEO articles, but only if each page is a genuinely useful Mac troubleshooting resource with human review, precise claims, sources, and a clear reason to exist.

## Compliance Rules

### 1) Publish Slowly

Do not publish dozens of pages at once.

Approved cadence:
- Week 1: publish the main guide only.
- Week 2: publish one supporting explainer.
- Week 3: publish the second supporting explainer.
- After that: no more than one new SEO article per week unless the article has new first-hand research, screenshots, or product evidence.

### 2) Make Every Page Useful Without The Product

Each article must help even if the reader never downloads PowerNap Toggler.

Required:
- A direct answer near the top.
- Practical checklist or steps.
- Manual commands where relevant.
- What the setting does.
- When not to change it.
- How to reverse or restore normal behavior.
- Soft CTA only after useful content.

### 3) Add Human Experience

Each page should include at least one first-hand element:
- Why the app was built.
- What the app actually changes.
- Screenshot of the app state.
- Example before/after setting output.
- Known limitation from real testing.
- Compatibility caveat.

### 4) Cite Authoritative Sources

Use sources for claims about macOS behavior.

Required source currently:
- Apple Power Nap support: `https://support.apple.com/en-asia/guide/mac-help/-mh40774/mac`

When adding claims beyond the app’s own behavior, cite Apple or another primary source when possible.

### 5) Avoid Spam Signals

Do not:
- Generate many near-duplicate pages.
- Spin the same article around multiple keyword variants.
- Stuff keywords.
- Make promises like “fixes sleep drain.”
- Publish fake stats, reviews, downloads, benchmarks, or testimonials.
- Use AI-looking generic intros.
- Hide that pages are product-adjacent.

### 6) Use Accurate AI-Feature Controls

For Google Search AI features, normal Googlebot crawling is the relevant access path. Do not block Googlebot if we want Search visibility.

Do not add `nosnippet`, `max-snippet:0`, or broad `data-nosnippet` to article content unless we intentionally want to limit snippets and AI-feature visibility.

Google-Extended is separate from regular Search crawling. Blocking Google-Extended is a business decision about Google AI training/grounding outside Search, not the same thing as opting out of Google Search.

### 7) Mark Up Only What Is Visible

Schema must match visible content.

Recommended schema:
- Article / BlogPosting for all guides.
- FAQPage only if the FAQ is visible on the page.
- SoftwareApplication on the product landing page, not every article.
- BreadcrumbList if the site has visible breadcrumb navigation.

Do not add review, rating, or aggregateRating schema unless real public reviews exist.

## Publish Gates

An article is ready to publish only if:

- [ ] It answers a real user problem.
- [ ] It has a practical checklist or steps.
- [ ] It includes manual commands where relevant.
- [ ] It explains limits and risks.
- [ ] It links to related articles and the landing page.
- [ ] It cites primary sources for platform claims.
- [ ] It has a clear last-updated date.
- [ ] It has a named author or maker attribution.
- [ ] It has a soft CTA, not a hard sales pitch.
- [ ] It has been human-reviewed for accuracy.

## Current Recommendation

Publish quietly for indexing after final Framer formatting, but do not promote broadly until the pages have original proof and the v1.0.1 link decision is resolved.

Recommended order:

1. `/what-is-power-nap-on-mac` — easiest to make source-backed with Apple support citation.
2. `/what-is-tcp-keepalive-macos` — publish after adding primary TCP/source support.
3. `/macbook-battery-drains-while-sleeping` — publish/promote as the conversion hub once the supporting pages are live.

Do not promote broadly until:
- v1.0.1 release link is live.
- Framer pages include visible source/updated/author information.
- At least the main article has one app screenshot or setting-output example.

## Agent Audit Summary

Google compliance verdict:
- Three pages is not scaled content abuse by volume.
- Risk comes from thin keyword pages and search-first language.
- Each page needs original value before promotion: first-hand testing, screenshots or command output, author/reviewer, update date, and source-backed claims.

AI search verdict:
- Add 40-60 word answer blocks.
- Add FAQs.
- Replace bare URLs with named links in Framer.
- Add Article, FAQPage, and BreadcrumbList schema where visible.
- Add SoftwareApplication schema to the landing page, not every article.

Operations verdict:
- Product Hunt stays passive.
- Publish slowly.
- Hold directories and Hacker News until v1.0.1 is live.
- Review every Friday morning.
