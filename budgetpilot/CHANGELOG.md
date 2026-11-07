# Changelog

## [0.4.65] — 2026-11-07

### Added

- **Tell a loan what your lender says you still owe.** The loan form has two new optional fields: the balance your lender shows, and the date it was true. Taupa starts from that figure and works forward, so a mortgage you took out before you began using Taupa shows where you really stand. The card says where the figure came from and when, and entering a newer one replaces it. Fill in both fields or neither.

### Changed

- **A loan older than your records asks for a balance instead of guessing one.** Repayments made before the month you started with Taupa are not in the app, so it counted them as missed and the balance read far too high, with a payoff date far too late. Until you add your lender's balance, that loan's card shows a prompt and no figures. The Loans page total it belongs to shows a dash, and so do Net worth and Debt on the Accounts page, each saying how many loans need a balance. Loans that began after you started with Taupa are unchanged.
- **The loan form has fewer explanatory lines.** The small notes under the start date, the interest rate, the balance and its date, and the household member picker are gone, since each field already says what it is.
