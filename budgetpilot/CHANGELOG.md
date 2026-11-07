# Changelog

## [0.4.63] — 2026-11-07

### Changed

- **The Transactions search box has a name a screen reader can read.** It is now announced as "Search transactions", as the other search boxes already were. The five search boxes (Bills, Transactions, Categories, Rules and Holdings) are now one shared piece, so they look and behave the same from one place; nothing else about them changes on screen.
- **The message for an interest only loan with no term uses the form's wording.** Saving an interest only loan without a term now says "An interest only loan needs a term", matching the "Interest only" option on the form.
- **The bill form's icon list says which icon is picked.** Each icon in the list beside the bill name now tells a screen reader whether it is the one chosen, so the choice no longer rests on colour alone. It is the same icon list the loan form uses.

### Fixed

- **The Investments value chart no longer calls itself month-end.** The line under "Value over time" said "Month-end GBP", but the chart plots a point for every week, so the line is gone.

### Internal

- **The roadmap records the investments search and chart headline, the loan form changes, and the wider Spending by category on the dashboard.** The feedback list gains a Loans section.
