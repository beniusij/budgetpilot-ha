# Changelog

## [0.3.58] — 2026-09-07

### Added

- Setting up a household now asks how you manage money — on your own, pooling everything, splitting shared costs, or each paying certain bills — and configures Taupa around the answer. Previously every household started out splitting costs proportionally, whether or not that was how it worked.
- Households that split shared costs are asked for their share during setup, starting from an even split.
- **Importing a statement now looks for the transfers that settled up.** The ordinary case was never quite finished: you settle up on the Sunday, your bank statement arrives a week later, and the settlement went on reading "not yet seen in your ledger" until you happened to reopen the tally and ask it to look again. An import now checks your outstanding settlements against what it has just brought in, links the ones that are unambiguous, and says how many on the "Import complete" screen. Where two payments could equally be it, nothing is guessed — the settlement waits for you to pick, exactly as before. Each of you confirms your own side from your own statement; nothing about the other person's account is read or revealed. And if the check itself cannot run, the import still stands and says so, rather than leaving a settlement looking unconfirmed for no reason.
- A short **"finish setting up" list on the dashboard**, pointing at the two things a new household still has to do — say which of your categories are income, and import a statement. It clears itself as you do them, and can be dismissed.

### Changed

- **Households that share costs proportionally now start at an even 50/50 split.** If you have never set your own split, your shared figures will shift slightly — the previous starting point was 58/42, which was not a sensible default for anyone. Your split is unchanged if you have already set one, and you can change it any time under Settings → Household.

### Fixed

- A household with only one person now sees its figures in full. Previously a solo household was shown a share of its own money, as though a second member were carrying the rest, and was offered per-person split columns it had no use for.
