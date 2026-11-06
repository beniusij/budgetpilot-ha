# Changelog

## [0.4.59] — 2026-11-06

### Changed

- **Deleting an investment now deletes its trades with it.** Before, the app refused until you had deleted every trade one by one. The confirmation says how many trades will go. If someone else in your household holds the same investment in their own account, the delete is refused, so their private trades are never removed without them seeing it.
- **Free to spend no longer adds a sentence under it when the figure reads negative.** The line ("The shared budgets hold back £x more than is in the joint accounts.", or "This month's budgets hold back £x more than you have." under Personal) repeated what the minus figure already says, and it was wrong whenever a card owed money, because it blamed the budgets for a gap that was partly the card. The figure keeps its minus sign and red colour, and "How this is worked out" still shows where the gap comes from.

### Internal

- **The product notes now say broker statements are imported from Upload statements.** The notes on the upload and investments pages, statement import and portfolio tracking still said they came in through the Investments page. The roadmap and feedback list record the investments chart and import fixes as done.
