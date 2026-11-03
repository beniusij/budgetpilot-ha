# Changelog

## [0.4.49] — 2026-11-03

### Fixed

- **Amex card payments no longer import twice.** Amex sometimes gives a payment a new reference number after it first appears, so a later statement read the same payment as a second one, and deleting the copy didn't stick. Taupa now recognises Amex transactions by their date, amount and merchant instead of Amex's reference, while still keeping two genuinely identical charges on the same day apart. Your existing Amex transactions are updated the first time you open this version, and copies of a payment you had already deleted stay deleted.

### Changed

- **Shorter wording for possible duplicates.** When an imported row looks like a transaction you already have, its checkbox now just says "Duplicate": leave it ticked to skip the row, or untick it to import the row anyway. The note above the table that counts rows already imported is shorter too.
