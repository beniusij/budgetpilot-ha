# Changelog

## [0.3.19] — 2026-08-02

### Fixed — 2026-08-02 (reconcile: balances copied from a statement)

- **A balance typed with commas in it now saves.** Entering `4,001.14` on the Reconcile page did nothing at all — the figure stayed in the box as though it had been accepted, but nothing was stored and the difference beside it went on using the old balance. Balances now read the way a statement prints them: commas, spaces and a `£`, `$` or `€` are all understood, and the box tidies itself to the plain number once saved.
- **Something that isn't a number no longer looks accepted.** If what you typed can't be read as a balance, the box now returns to the balance last saved for that account instead of leaving the text sitting there.
