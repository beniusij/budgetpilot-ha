# Changelog

## [0.3.48] — 2026-08-30

### Added — 2026-08-30

- **A Scope filter is back on the Transactions page, for households that split costs proportionally or name one payer.** Those households see a single ledger with no Household / Mine switch, which left no way to look at just the shared spending or just your own. The filter bar now offers **Scope — All, Shared or Personal** alongside Category, Account and Type. Unlike the old one, it narrows the totals at the top of the page as well as the list below, so the figures always describe exactly the rows you can see. **Personal** means your own personal spending: your partner's stays out of it. A household that pools its income keeps the Household / Mine switch and gains no second control, since the switch already does this job. Category deep-links from the dashboard's Spending-by-category card now land on the matching scope rather than the whole month, and picking a scope clears a category filter that no longer belongs to it.

### Changed — 2026-08-30

- **Shared payments are back on the Transactions page for households that split costs proportionally — and now count towards the totals above it.** They had been dropped from that page along with the Household / Mine switch, which meant the dashboard could tell you what the household spent on rent or energy while nothing in the app would show you the payments themselves. Shared money belongs to everyone in the household, so it is listed again, and the Income, Spending and Net figures at the top of the page now include it rather than counting your own money alone. Your partner's personal spending on a shared account is still shown but still counted by nothing — that money is genuinely theirs. **Note:** the dashboard's Spending tile counts your share of shared costs rather than the full amount, so the two pages will report different figures for the same month until that is settled.
