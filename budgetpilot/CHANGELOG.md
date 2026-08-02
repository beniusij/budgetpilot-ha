# Changelog

## [0.3.18] — 2026-08-01

### Fixed — 2026-08-02 (the "still to reconcile" count now matches the page)

- **The reconcile warning and the sidebar count now agree with the Reconcile page.** They were counted a different way, so the dashboard could tell you three accounts still needed reconciling and the page then showed you a different three. Both now count exactly the accounts the page lists as not yet reconciled.
- **Investment accounts are no longer chased.** They can't be reconciled — their balance is what the holdings are worth, not a statement figure — but the warning was still counting them, so the number never dropped to zero however much you reconciled.
- **A month that has drifted since you reconciled it is flagged again.** If a transaction dated inside a reconciled month arrives later (a late import, say), the account's balance no longer matches what you confirmed. The Reconcile page always showed that as a discrepancy; the warning stayed silent about it. Now it doesn't.

### Fixed — 2026-08-01 (reconcile: balances you entered stay visible)

- **A balance you typed no longer disappears when you change month.** Moving between months on the Reconcile page kept the previous month's empty input on screen, so a balance you had already saved looked as though it had never been entered — even though it had, and the difference beside it was still being worked out from it. Each month now shows its own saved balance.
- **Coming back to Reconcile returns you to the month you were reconciling.** "Save & continue later" used to lose your place: returning to the page reset it to the current month, which for a month you had just finished entering balances for meant looking at an empty table. The month you're viewing now travels in the page address, so leaving and coming back — or sharing the link — lands where you left off.

### Changed — 2026-07-31 (bills and the free-to-spend breakdown)

- **The Bills page now only offers accounts a bill is actually paid from.** The account filter and the "Paid from" picker list your current accounts and credit cards; savings and investment accounts no longer clutter either, since money you're putting aside isn't where a direct debit leaves from. Any bill already pointing at one keeps working and still shows its account name.
- **The free-to-spend breakdown says which budgets are shared.** Each budget under "Reserved for budgets" now carries a **Shared** or **Personal** tag, so a mixed list can be read at a glance instead of inferred from the share percentage. The tag only appears when there's actually a mix — under Pooled income everything reserved is the household's, so it stays out of the way.
- **Under Pooled income the fourth dashboard tile is now "Unbudgeted income"** — what's left of the household's income once every shared budget is accounted for. It replaces "Left after bills", which named the figure wrongly: the number was always every shared category's budget, and bills are only part of that (a category's own buffer carries the rest). It never goes below £0 — once the budgets claim everything, the answer is simply none.
- **"Pot" is gone from the wording.** Monzo uses Pots for savings sub-accounts, so "everything paid into the pot" invited a search for something that isn't there. The shared money is now called **household money** throughout.
- **Reconciliation now has to match exactly.** The reconciliation tolerance setting is gone — a balance counts as reconciled only when it equals the calculated figure to the penny. Previously anything within £1 was quietly absorbed, which could hide a genuinely missing transaction. A gap of any size now shows as a discrepancy, and you can still accept one deliberately, which records that you did.
- **Your household start month now sits inside the income card**, shown but not editable, with an ⓘ explaining what it does. It's the same information in one fewer card, and it reads alongside the income it applies from. This is the same under every finance model.
- **Income and split changes now simply apply from the current month**, which is what nearly every change means. The "Effective from" picker has gone, so a future pay rise can no longer be scheduled ahead of time, and a past month's income or split can no longer be corrected — months you've already recorded keep the figures they were recorded with.

### Changed — 2026-07-30 (household start month)

- **Your start month is now set automatically** when your household is created — it's the month you started — and is shown in Settings rather than edited there. It's the first month Taupa budgets and it's shared by both of you, so moving it would change which months and transactions exist for the other person too. Households created before this keep working exactly as they did.

### Added — 2026-07-30 (pooled income)

- **The Pooled income model now actually works.** Until now, picking a finance model in Settings recorded your choice but changed nothing — every figure in Taupa was worked out the proportional way, as each person's share. Choosing **Pooled income** now reconfigures the app for households that treat their money as one pot.
- **Both of you see the same numbers.** Income, spending, what's committed and what's free to spend are the household's, not your slice of them — so there's one set of figures to talk about instead of two that never quite match.
- **Personal money stays out of the household figures.** Everything on the dashboard counts the shared pot alone. Your own personal spending is left out just as your partner's is: the two kinds of money answer different questions, and a total mixing them describes neither. Your personal categories and settings are all kept, ready for when a keep-back arrives.
- **Money paid into the pot counts as household income.** A new **Shared income categories** setting says which shared categories are money coming in — so a salary paid straight into the joint account and a transfer in from a personal account both count, as long as they're categorised as income. It's one setting for the household rather than one each, since there can only be one answer.
- **Spending by category opens on Shared**, which is what a pooled household is actually looking at.
- **Settings that belong to the household now say so.** Income shows a field for each of you under one "Household income" heading, the Needs / Wants / Savings target becomes the household's rather than one each, and both pay schedules are visible — the pot's income depends on when you're both paid. Either of you can change any of them, and each shows **who changed it last and when**, so a figure that's moved since you last looked explains itself. Your individual targets are kept, and come back if you switch models.
- **The things that don't apply simply disappear.** There's no contribution ratio to set, so that card is gone from Settings. Bills show the household total rather than splitting each one between you, and the per-bill split control goes away — but anything you'd already set up is kept, so switching back restores it exactly.
- **Month-end works on the household's figures**, and the running "carried forward" balance isn't kept — with one pot, what matters is what's actually in it, not how far ahead or behind a personal plan you are.
- **Changing model asks first.** Because it changes how every figure is worked out, switching now shows a confirmation. Months you've already closed keep the figures they were closed with and aren't recalculated, so an old month and today's view of it can disagree — the confirmation says so.
- **Savings work the same as before.** A joint savings or emergency pot still isn't counted as free to spend — money you've set aside has already left the account you spend from.
- **Proportional households are unaffected.** Everything works exactly as before unless you choose Pooled income. Designated payer is still to come.
