# Changelog

## [0.3.14] — 2026-07-27

### Changed — 2026-07-26 (transaction linking & settlement)

- **Linking transactions now only offers candidates with a matching amount.** When you link two transactions as a transfer, the picker lists only the opposite-side entries whose amount exactly matches — the other half of a transfer always moves the same money — so near-miss amounts no longer clutter the list.
- **A credit-card repayment that's linked as a transfer now shows the "settle purchases" action.** Previously the settle button disappeared once a repayment was linked to its matching transfer; hovering the linked row now offers it again so you can still tie the repayment to the card purchases it covers.
