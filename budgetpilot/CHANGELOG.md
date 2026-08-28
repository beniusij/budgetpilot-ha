# Changelog

## [0.3.31] — 2026-08-28

### Added — 2026-08-27

- **⌘F now searches your money, not the page.** On Bills and Transactions, the find shortcut (⌘F on a Mac, Ctrl+F elsewhere) puts the cursor straight in the page's own keyword box and highlights whatever is already typed there, so you can start a new search immediately. Unlike the browser's find bar, it looks through the whole register rather than only the rows currently on screen, and the counts and totals follow what it finds. With a dialog open the shortcut still opens the browser's own find bar.

### Fixed — 2026-08-27

- **A savings goal can now say which savings it is.** Goals already knew which accounts fund them, but an account only says where the money left — a transfer to your emergency fund and one to a stocks ISA leave the same current account, and both are savings. Every savings transfer out of that account was therefore counted towards the goal, quietly lifting it above what the savings account actually holds. A goal can now name the savings categories that feed it, in its Add/Edit box alongside the funding accounts, and only transfers in those categories are picked up when you import a statement — so two pots fed from one account can be told apart. Leave the categories empty and nothing changes: the goal keeps taking every savings transfer from its funding accounts. Contributions already tagged by hand are untouched either way; to correct an existing goal, pick its categories and clear any wrong tags from the Transactions page.
