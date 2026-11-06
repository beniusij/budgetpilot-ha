# Changelog

## [0.4.57] — 2026-11-06

### Added

- **An investment can now hold its ISIN, and importing a statement uses it.** A Moneybox statement names each fund by its ISIN, but an ETF or share whose ticker is its exchange symbol (VHYG.L, NVDA) used to go unrecognised, so an import created a second, empty copy of it. Add the ISIN once in the asset's edit form and every later statement finds the right asset. Funds an import creates keep their ISIN automatically.
- **Moneybox and eToro statements can now be imported from Upload statements, the same way as a bank statement.** With Experimental features on, your investment accounts are listed there. Pick one, drag its statement in or choose it, check the trades, and import. Trades you've already recorded start unticked, and the finish says how many were added and how many were skipped. This replaces the Investments page's Import statement button, whose drop area didn't take a dragged file.

### Fixed

- **Investment trades and prices can now be added to a month that's already closed.** A broker statement usually arrives after its month is closed, and its trades were turned away, so importing it added nothing. Closing a month still locks its transactions, planned amounts and balances; investments were never part of what a close signs off.
- **Importing a Moneybox statement no longer skips trades that fall across a page break.** A purchase or sale whose line started at the bottom of one page and carried on at the top of the next was left out without a word. It is read now, along with trades of a thousand units or more. If a statement ever holds a trade line that still can't be read, the review before importing says how many, so you can add them by hand.
