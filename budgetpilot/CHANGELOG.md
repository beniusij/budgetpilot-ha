# Changelog

## [0.4.38] — 2026-10-08

### Changed

- **Amex and Monzo transactions must carry the bank's own reference.** Those banks give every transaction one, and Taupa relies on it to tell duplicates apart. A row that arrives without one is now skipped and counted as skipped, instead of imported and matched on date, amount and description alone. Other banks are unchanged, as are transactions you've already imported.

### Fixed

- **The category picker on a transaction no longer offers "Uncategorised".** Choosing it never worked, and a transaction's category can be changed but not cleared. A transaction with no category still reads "Uncategorised" until you pick one.
