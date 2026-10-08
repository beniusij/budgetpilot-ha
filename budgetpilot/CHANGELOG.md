# Changelog

## [0.4.39] — 2026-10-08

### Changed

- **The Free to Spend breakdown is shorter.** It opens on the bar and three lines: the cash in your accounts, what you owe on cards, and what is reserved for budgets, followed by the result. Click any line to see the accounts, cards or budgets behind it.
- **The Account filter on Bills no longer offers "No account".** It lists All and each of your accounts.
- **Bill cost changes on the Bills page are now a small arrow beside the total.** Hover over the arrow, or tab to it, to see how much the cost moved. Every row keeps the same height. A detected price change is now dismissed from inside the bill, where the charge, its date and the bill's cost are spelled out.
- **Taupa has a new look.** The menu is now a deep oxblood, the main action on each page is a soft apricot, and headings and figures use new typefaces. Anything you have confirmed shows a green marker with the day you confirmed it: an account reconciled to the penny, or a month you've closed. Pages, layout and wording are unchanged, and dark mode is still the default.

### Fixed

- **An account at £0.00 no longer shows in red on the Accounts page.** A balance left with a fraction of a penny below zero read £0.00 but was coloured as money owed. It now follows the figure you see, as the overview already did. The same goes for the Credit total at the top of the page.
- **Account rows no longer repeat their type.** Each panel on the Accounts page already says Current, Credit card or Savings, so the line under an account now shows only its provider.
- **The page behind a dialog stays still.** Scrolling inside a dialog, such as how free to spend is worked out, no longer scrolls the page underneath it too.
