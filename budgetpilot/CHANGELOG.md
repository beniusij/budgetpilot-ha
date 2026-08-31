# Changelog

## [0.3.51] — 2026-08-31

### Fixed

- **The scope buttons on the Transactions selection bar now hide when they would do nothing.** Selecting several rows that are all already personal still offered "Mark personal", which rewrote them to the value they already had and reported it as a change. The bar now offers an action only when at least one selected row would actually move; a selection with a mix of both still offers both. The same applies to "Exclude from figures" and "Include in figures".
