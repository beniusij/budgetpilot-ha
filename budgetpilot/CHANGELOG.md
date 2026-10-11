# Changelog

## [0.4.45] — 2026-10-11

### Internal

- **The roadmap board shows Free to Spend, one pot at a time, as done.**

### Fixed

- **A month that ended on payday no longer reads short.** If your pay lands at the end of the month and counts towards the next one, the money you move to the joint account that same day now counts towards the next month too. Before, an ended month could show "ended short" in Personal and too much in Shared, by the size of that transfer. This applies to households that split shared costs by a ratio. Your partner's month-end transfer is not yet treated this way in your view of the Shared left-over.

### Added

- **Choose which Free to Spend view opens first.** In a household that splits shared costs by a ratio, Settings → This device now has "Free to Spend opens on", with Personal or Shared. It is set for you, on this device only, and you can still switch beside the month at any time.
- **See what still needs a category.** On Transactions, a line above the filters says how many of the month's transactions are still uncategorised, with a link that shows just those. File them one by one or in bulk and the list empties as you go; when the last one is done it says so. The Category filter has an Uncategorised choice too.
- **Select a run of transactions with Shift-click.** Tick one transaction, then Shift-click another to tick everything between them. Shift-click a ticked one to untick the run.

### Changed

- **Free to Spend no longer counts joint money as yours to spend.** In a household that splits shared costs by a ratio, the figure used to add a share of the joint account to your own cash. Money moved into a joint account is the household's, so the dashboard now shows one pot at a time: **Personal** (your own accounts, cards and budgets) or **Shared** (the joint accounts, cards and budgets in full, the same figure for both of you). A Personal / Shared switch beside the month picks which, and it opens on Personal. The sum under the figure, "How this is worked out", the category list, what an ended month left over and the "Statements to" date all follow it. The figure is named for the pot it counts ("Free to spend · Personal" or "Free to spend · Shared"). Under Personal, a line states your share of the month's bills, because it stays in the figure until you have moved it to the joint account. The category list no longer has a switch of its own in these households. Households that pool their income, use a designated payer, or have one member see no change.
- **Closing a month tells you what is still uncategorised.** If transactions in the month have no category, the close confirmation says "N transactions still need a category" with a link that opens them on Transactions. It is a heads-up only: you can still close.
- **A transaction with no category is easy to spot.** Its category box keeps a dashed outline instead of looking like plain text.
- **The empty Transactions list no longer claims the month is empty when a filter is hiding it.** It says nothing matches the filters, or that there is nothing left to categorise.
- **Goal figures wait for your transactions.** The Goals page used to show each goal at its starting balance, then jump once your savings transactions arrived. It now shows a dash and "Loading…" in the summary, and a loading line for the cards, until everything is in.
- **Edit and Delete on a goal are reachable without a mouse.** They now appear when you tab to a goal card, and always show on touch screens, instead of only when hovering.

### Fixed

- **Deleting several transactions at once now asks first.** Select two or more and press Delete, and a box says how many will go before anything is removed. Deleting a single transaction is still one click.
- **Searching Transactions now looks at notes and amounts, as the box says.** It only looked at descriptions before. Amounts can be typed as 12.50, £12.5 or 1,250.
- **The Accounts page no longer shows balances that then change.** It now waits until your transactions, holdings and loans have loaded before showing any figure, so you never see an opening balance flash up and jump. The "0 accounts · net balance £0" line no longer shows while the page loads, and an account holding bought today is counted without reloading a window left open overnight.
- **The Add account button's plus sign is hidden from screen readers**, so the button reads simply as "Add account".
- **The Loans page no longer shows the wrong balance while it loads.** Until your repayments have loaded, the totals show a dash instead of the full amount you borrowed, and each loan waits instead of briefly showing it as untouched.
- **The Loans page says so when it cannot load your loans.** Before, a loan list that failed to load looked the same as having no loans yet. It now tells you it could not load and to reload the page.
- **Edit and delete on a loan can be reached without a mouse.** The buttons now appear when you tab to a loan, and are always visible on touch screens.

### Security

- **Your auto-categorisation rules stay yours.** The app now only ever sends a member their own rules, refuses to save a rule list on another member's behalf ("You can only change your own rules"), and leaves the rules out when it shows the other member a sync disagreement about your settings. Before, the Rules page only showed your own, but the other member's list still travelled with it behind the scenes.

### Internal

- **The product notes now describe Free to Spend as one pot at a time**, with the reasoning written up as a decision.
- **The roadmap board shows the Accounts UX pass as done.**
- **The roadmap board shows the Loans UX pass as done.**
- **The roadmap board shows private auto-categorisation rules as done.** Its feedback note now says the app itself keeps each member's rules to them, not only the Rules page.
- **The roadmap board shows the app icon recolour as done.** The browser theme colour is split into its own card, still to do.
