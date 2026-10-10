# Changelog

## [0.4.40] — 2026-10-09

### Changed

- **Rows no longer light up under the pointer.** In tables and lists across the app (transactions, bills, spending by category, categories in Settings and investments) the row's name turns apricot instead of the whole row being shaded.
- **Fewer amber warnings on the overview.** Upcoming bills are only marked when they're due today or tomorrow, rather than across the whole week. A contract that has already ended now shows in red and says when it ended, instead of giving its date twice.
- **Bills and contracts open from the overview.** Click a bill under Upcoming bills to record a new price straight away, or a contract under Contracts renewing to move its end date on after you renew. Pausing and deleting a bill still happen on the Bills page.
- **Free to Spend says how long it has to last.** A line under the figure counts the days left in the month, so the same amount reads differently on the 3rd and the 28th. The rest of its small print has moved: how current your statements are now sits beside the greeting at the top ("Statements to 6 Oct", which takes you to Upload), and the month's income and the cash carried in from last month are in "How this is worked out", since neither is part of the sum.
- **The Mac app opens at a comfortable size.** The first time it starts, the window takes up most of your screen instead of a small fixed size. After that it reopens however you left it.
- **The overview now shows how Free to Spend is reached, at a glance.** The strip under it reads as a sum: the cash in your accounts, minus what you owe on cards, minus the planned spending left in your budgets, equals what's free to spend. The signs sit between the figures, so planned spending left no longer looks negative. This month's income now sits under Free to Spend, and your share of the bills (or, for households that pool their income, the income no budget has claimed yet) sits under the Shared totals of Spending by category. The separate spending figure is gone, because the table's totals already show it. The same term in the full breakdown is now called "Planned spending left" too. The household's total shared commitment no longer has a tile of its own, because beside your own income it looked like overspending. If your household leads with what's yours to keep, the overview still doesn't show free to spend.
- **Free to Spend says whether you're OK, and how current it is.** The figure is green when you have money to spare and red, with a sentence saying so, when your budgets need more than you have. A line underneath says when your last statement was imported, giving the date of the stalest account, so you can see when an import is due. A "How this is worked out" link opens the full breakdown.
- **Spending by category on the overview shows only what needs a look.** It lists the categories more than half spent, and any spending with no budget, with a button to show them all. The total still covers every category.
- **Your accounts open the panel beside Free to Spend.** Up to four are listed, current accounts and cards first, with a button to the Accounts page when you have more. A card on an instalment plan says so, since its balance is paid off as a bill rather than out of this month's money.
- **The needs, wants and savings bar matches its percentages.** Each band is drawn at the share of income it shows, so the empty part of the bar is what's still unspent. A caption says what the percentages are of.
- **You can pause the rotating panel beside Free to Spend.** A pause button sits next to its dots, and the panel also holds still while you're tabbing through it.
- **Goals on the overview show whole pounds**, like every other figure there.
- **The Mac app's window blends in with the app.** The grey title bar is gone. In its place a slim toolbar runs across the top of the window, above the menu, with the page's name on the left, the month picker in the middle on pages that have one, and Upload statements on the right of every page. Drag the toolbar to move the window, or double-click it to zoom.
- **The overview's greeting stands on its own**, without the line underneath it.
- **On a phone or tablet, the menu no longer squeezes the page.** It is tucked away behind a menu button at the top, and opens over the page when you need it. Tap outside it, close it, or pick a page and it gets out of the way.

### Fixed

- **Saving more than planned no longer shows in red.** In Spending by category, a savings category past its target now reads as fine; only needs and wants turn red when they go over.
