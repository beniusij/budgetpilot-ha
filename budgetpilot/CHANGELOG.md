# Changelog

## [0.4.44] — 2026-10-10

### Added

- **The upload page shows the dates a statement covers.** After you drop a file it says, for example, "42 transactions found · 1 Sep – 30 Sep 2026", so a wrong month is caught before you review anything.
- **A first-time household is told what to add first.** With no accounts yet, the upload page explains that you add the account the statement came from and pick its bank, once.

### Changed

- **The upload page explains itself in plain words.** The heading now says to add the statement you downloaded from your bank, that it is read on this computer and not uploaded, and links to the guide on where your data goes.
- **The Continue button no longer promises to review 0 rows.** Until you choose a file it says "Choose a file to continue".
- **The review step says how many rows still need a category** ("3 rows still need a category") instead of only that some do.
- **An account Taupa cannot read statements for says so.** If an account is not set to one of the supported banks, the upload page explains that and offers to edit the account, instead of showing a drop area that rejects every file.
- **Resources is easier to start with.** The first guide is marked "Start here", every guide says how long it takes to read, and each one ends with a link to the next so you can keep going.
- **A closed month reads as finished.** Opening Reconcile on a month you have closed now shows the green "Closed" mark with its date, and each account's balance as plain, readable text instead of a greyed-out box. A new Month summary button shows what the month carried forward, so you no longer have to leave the page to find it. The summary says "September is closed" and states the carried amount at normal size.
- **Closing a month says what it does.** The confirmation now explains that the month's transactions, planned amounts and balances are locked until you reopen it, and that anything on a shared account locks for the whole household. It names how many accounts are not yet reconciled, and no longer squeezes this beside the buttons.
- **Closing the current month early now says so.** If you close a month that has not finished, the confirmation adds a line such as "5 days left in September 2026. Its balances can still change, and you can reopen the month if they do." It is a heads-up only; you can still close.
- **Reconcile tells you why you cannot go on.** Under the account list, a line now says "Review unlocks once every account is reconciled", where before the reason only appeared if you hovered the greyed-out button. The page's opening line is plainer too.

### Fixed

- **You can choose a statement file with the keyboard.** "Choose a file" is now a real button, and a rejected file is announced by screen readers. The step bar also tells screen readers which step you are on.
- **You can no longer reconcile or close a month that has not started.** The Next arrow on Reconcile & close is no longer shown on the current month, and a link to a later month opens the current one instead. Closing a future month would have locked it and carried a balance forward from nothing, so the app refuses that as well.
- **The "free to spend" guide no longer sends you looking for a setting that does not exist.** It told you to set a start month in Settings; in fact the "Household created" month is set automatically during setup and cannot be changed. It now says so, and explains what to check instead: that each account's opening balance matches your bank on the first day of that month.
- **The second step's name was too faint to read.** "Review & close" in the step bar is no longer dimmed, and a finished step now shows a tick. The step you are on is announced as the current one by screen readers.
- **Balance boxes have names.** Each account's balance box is now called "Actual balance for" the account, so a screen reader no longer meets a row of unnamed fields.
- **"Settled earlier" can be reached from the keyboard.** The explanation beside an old gap now opens when you tab to it, not only when you hover.

### Internal

- **The project board is now updated once per piece of work, when it lands.** Work in progress is tracked in the team's task list instead of by moving the card twice.
- **A coverage check on every pull request, part of `verify`.** At least 95% of the code a change adds or alters must be run by the tests, alongside the existing mutation check. It only looks at what the change touches, so older code never holds a pull request up.
- **Roadmap board:** the Resources improvements card moved to Done.
- **The Reconcile page has a saved design critique,** with its follow-up work listed, and its card sits in Doing on the project board.
