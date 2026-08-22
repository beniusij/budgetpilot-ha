# Changelog

## [0.3.24] — 2026-08-22

### Fixed — 2026-08-22

- **Released builds were packaged as development builds.** They started slower and carried extra debugging weight, and — because the app treats offline caching as a release-only feature — each one removed its own offline cache on startup instead of setting it up, so the app always needed the network to load. Releases are now packaged correctly: the app is lighter, starts faster, and keeps loading through a brief network drop.

### Added — 2026-08-18

- **Designated Payer households — share the bills without sharing the money.** For housemates, newer couples, and anyone who shares a home without merging finances. Each household bill names the member who pays it, and that member carries it in full; there is no split, no share percentage, and no settling up between you. Every figure you see counts only what your own accounts paid for.
- Bills you already pay from one of your accounts are assigned to you automatically — the account answers who pays it, so there is nothing to set up. You can name a different payer on any household bill, or leave one unassigned.
- Spending now includes what you paid towards household bills, instead of setting it aside as something to settle later. Your commitments count the household bills that are yours to pay, and none of your housemate's.
- The app stops offering to create shared money you don't have: no shared/personal choice when adding an account or a category, and no "mark shared" or shared scope on a transaction. Nothing you already share is rewritten, and switching back to another model restores every setting untouched.
- A joint account left over from another model no longer counts its balance towards both of you at once. Settings lists the ones still marked shared so you can claim whichever are yours; claiming one makes it personal, returns its balance to your figures, and takes it out of your housemate's view. Anything you genuinely share can stay as it is.
