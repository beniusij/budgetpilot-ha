# Changelog

## [0.3.17] — 2026-07-30

### Added — 2026-07-30 (leave a transaction out of the figures)

- **A transaction can now be left out of the figures.** Some costs are already paid for before they arrive — the classic case is a yearly insurance or car tax bill you've been saving into a pot for. When the charge lands it isn't really this month's spending, but calling it a transfer would be wrong too, because it genuinely is a cost. There's now a third option: hover any transaction and use the eye icon to take it out of the reported figures, or select several and do it in one go.
- **Your balances are never affected.** An excluded transaction still leaves your account and still counts in every balance — money that moved is money that moved. What changes is only the reporting: it drops out of money in, money out, spending by category and your Needs/Wants/Savings split.
- **Your budget for that bill stays put.** Because the charge no longer registers as spending, the monthly amount set aside for it stays reserved rather than being released all at once. Paired with the transfer back in from savings, a yearly bill stops knocking a hole in what you have left to spend in the month it falls due.
- **Excluded rows are easy to spot.** They carry a "Not in figures" marker with a dimmed amount, and the summary at the top of the Transactions page tells you how many are excluded — so the totals never look wrong without explaining why.

### Added — 2026-07-30 (contract expiry on bills)

- **Bills can now record when a contract ends.** A new optional **Contract expires** date on each bill marks the end of a fixed term — an energy tariff, a phone contract, car finance, an insurance policy. It's separate from the payment due date: one is when you pay, the other is when the deal runs out.
- **You get 30 days' notice before a term ends.** A **Contracts renewing** card appears on the dashboard listing anything expiring within the next month, so there's time to compare providers or give notice rather than finding out after the tariff has already rolled over. The card stays out of the way entirely when nothing is coming up, and the Bills count in the sidebar turns amber when something needs a look.
- **A term that has already lapsed keeps showing.** An expiry you missed doesn't quietly disappear — it stays on the card, marked as expired, until you update the date on the bill.

### Changed — 2026-07-29 (finance models)

- **The finance models in Settings now describe the three real arrangements.** Model A is *Pooled income* — money goes into one pot, and each person can keep a percentage of their pay back rather than pooling all of it. Model C is now *Designated payer*, for households with no joint account, where each shared bill is paid by one person and the rest of the money stays separate. The old "Even split" option has gone: splitting evenly is Model B with the ratio set equally, not a separate arrangement. Only Model B is implemented so far, so the choice is still recorded rather than acted on.
