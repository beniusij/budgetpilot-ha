# Changelog

## [0.3.29] — 2026-08-27

### Added — 2026-08-27

- **Search the Bills register by keyword.** A search box now sits at the head of the Bills filter bar, alongside the Scope, Category, Frequency and Account dropdowns. It matches the bill's name and notes as well as the names of the category it funds and the account it is paid from, so "utilities" or "Monzo" finds a bill just as readily as its own name. It narrows what the dropdowns have already selected rather than replacing them, and the bill count and monthly-equivalent total follow along.

### Fixed — 2026-08-27

- **Weekly bills now cost what the month actually charges.** A £10 weekly bill read £43.33 a month in every month — the yearly average, spread over twelve — which is a figure no household ever pays. A weekly bill is now counted against the calendar instead: if its due date falls on a Friday, it costs £40 in a month with four Fridays and £50 in a month with five, and the figure moves as you step between months. The change carries everywhere the monthly figure is used — each bill's "/ mo" line, the filter bar and table totals, the summary strip, category budgets, and the dashboard's Committed bills and Free to spend. Quarterly and yearly bills are unchanged: their cash genuinely doesn't fit inside a month, so they stay spread evenly. A weekly bill with no due date set still falls back to the old yearly average, so set one to get the accurate figure.
- **Deep links to the Bills page can now pre-select the Weekly frequency.** A link carrying `frequency=Weekly` silently showed every bill instead, even though the filter itself offers Weekly.
