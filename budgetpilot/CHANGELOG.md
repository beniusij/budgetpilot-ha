# Changelog

## [0.4.8] — 2026-10-01

### Fixed

- **A closed month is now read-only everywhere, not just for spending.** Closing a month already stopped it being edited, but only for transactions. Planned amounts, reconciliations, IOU claims and investment holdings dated inside it could still be changed, quietly moving figures in a month you had finished with. They are all refused now, with the same message: reopen the month first. The rule still works the way it always has — your own accounts lock when you close, shared ones as soon as either of you does — so closing your month never locks your partner out of theirs. Importing a statement of investment holdings is the one place that does not stop: a line dated inside a closed month is reported alongside the rest and the import carries on. Recording a settlement between the two of you still works, because that is money moving today.
