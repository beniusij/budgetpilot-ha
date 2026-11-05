# Changelog

## [0.4.54] — 2026-11-05

### Added

- **A new Analytics page shows how your spending and income change month by month.** Spending is one bar per month, split by category, over the last 3, 6 or 12 months, using exactly the figures of the Overview's Spending by category card. Hover or tap a bar for the month's figures, and click a category in it to open those transactions. Click a category in the legend under the chart to see only that one, and again to see them all, or Shift+click to pick several. Income is a line across the same months, counted the way the Overview counts it. A household that shares costs in proportion chooses Personal or Shared, in the same place as on the Overview, and the choice carries between the two pages. Find it in the sidebar, under Goals.

### Changed

- **A hover balloon too tall to fit above what you are pointing at now opens below it.** A long one, such as a month's spending listed by category, could run off the top of the window; it now opens under the bar, or whatever it describes, when there is more room there.
- **In the test builds, Experimental features now also turns on features still being built.** In the Home Assistant add-on, the beta app and a developer's own copy, switching on Experimental features in the user menu shows every unfinished feature too, so there is nothing more to find in the Developer page. A feature switched off by hand there stays off. The public app is unchanged: Experimental features still means Investments and Loans, and nothing unfinished.

### Fixed

- **On the Developer page, each feature flag's name and description show beside its switch again.** The As shipped / On / Off switch spread across the whole row and squeezed them out; it now keeps its own width.
