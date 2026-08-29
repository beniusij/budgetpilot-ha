# Changelog

## [0.3.39] — 2026-08-29

### Fixed — 2026-08-29

- **Months you had already reconciled stay reconciled.** Reconciliation used to allow a small rounding gap and now requires the balances to match to the penny — but that stricter rule was also being applied backwards, so accounts you had signed off long ago suddenly read as discrepancies, and in a closed month there was no way to resolve them without reopening a month you had finished with. Anything you settled under the old rule now stays settled, with a small "settled earlier" note beside the leftover pennies explaining why the figure isn't zero. The dashboard reminder and the sidebar badge stop chasing those accounts too. This only protects what was already agreed: if a backdated transaction changes what the month adds up to, the account re-opens as a genuine discrepancy, and anything reconciled from now on still has to match exactly.
