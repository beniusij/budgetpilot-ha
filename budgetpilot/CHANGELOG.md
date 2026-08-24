# Changelog

## [0.3.28] — 2026-08-24

### Fixed — 2026-08-24

- **Lloyds credit card statements now import.** Dropping a Lloyds credit card CSV onto its account was refused with "this file doesn't look like a Lloyds export": Lloyds writes its credit card statements in a different shape from its current account ones, and only the current account shape was recognised. Both are now accepted on the same Lloyds account, with charges and payments read the right way round.
