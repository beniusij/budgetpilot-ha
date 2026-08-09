# Changelog

## [0.3.20] — 2026-08-09

### Added — 2026-08-08 (Bills: move through the months)

- **The Bills page now has month arrows, like Transactions and the dashboard.** It opens on the current month, and stepping back or forward shows what your bills cost in *that* month. So if you have recorded that your energy tariff goes up in October, stepping forward to October shows the new price, the new totals, and how much more the month costs — before it arrives. Stepping back shows what you were actually paying at the time, using the household split that was in force then. Bills you had not taken on yet simply are not there.
- **A new "Cost changes" figure at the top of the page.** It answers two questions at once: how many of your bills changed price, and what that adds up to per month. A rise is shown in red, a drop in green, and both carry a sign so the direction never depends on colour. It compares like for like — a bill you added since is new spending, not a price change, so it is not counted.
- **Choose how far back to compare: 1, 3, 6 or 12 months.** The buttons sit under the figure itself. A one-month view catches what has just landed; a year catches the slow drift you only see when you look up, like a tariff that has stepped twice since last summer. If some of your bills do not go back that far, the page says so rather than quietly leaving them out — "2 of 9 bills changed price vs August 2025".
- **Each repriced bill is marked in the table.** A small up or down badge sits beside the bill's amount showing how much it moved over whichever window you have chosen, and hovering it names both the old and the new price. It is distinct from the existing amber flag, which means something different: that a charge on your statement disagrees with the price you have recorded.
- **Due dates follow the month you are looking at.** Viewing September shows when each bill falls due in September, rather than always counting from today, and the "in N days" countdown disappears once the date is in the past instead of counting backwards.

### Changed — 2026-08-08 (one consistent look across every screen)

- **No text in the app is too small to read any more.** Roughly a hundred and thirty small labels — table headings, status pills, category tags, the dates beside transactions, section headings, hints under form fields, chart legends, step markers in the reconcile and import flows — were set below the readable minimum, some as small as eight pixels. Every one of them has been raised, and the handful of in-between sizes scattered around the app have been pulled onto a single set of sizes, so the same kind of information is now set the same way wherever it appears.
- **Small capitalised labels are spaced consistently.** The wide letter-spacing used for headings above figures and for status pills had drifted into eight slightly different settings; there are now two, one for labels and one for pills.
- **The PIN and first-run setup screens match the rest of the app.** Both were still on the old blue-and-grey styling from before the warm redesign, with a cartoon icon at the top and a bright red error message. They now use the same warm palette, typography and buttons as every other screen, the Taupa mark replaces the icon, and errors are shown in the muted red used elsewhere alongside a warning icon rather than relying on colour alone. PINs are set in the same typewriter figures the app uses for every other number.
- **Progress bars and highlights now follow the light/dark theme properly.** A few bars, hover highlights and the current step marker in the reconcile flow had their colours fixed to the dark theme, so they were nearly invisible on the light one. They now change with the theme like everything else.

### Changed — 2026-08-07 (Accounts: readability and reaching the controls)

- **Edit and Archive no longer hide behind the mouse.** On the Accounts page the two buttons on each row only appeared while the pointer was over that row, which meant that on a touchscreen they were not there at all, and that moving through the page with the keyboard landed you on a button you could not see. They now appear when you tab to a row, and stay permanently visible on any device without a mouse.
- **Small grey text on the Accounts page is legible again.** The line under each account name — the bank and account type, or what an investment account holds — was set in a grey too faint to meet the accessible-contrast standard, at a size below the readable minimum. It is now larger and darker. The muted grey used across the app in light mode was also too pale throughout, and has been deepened.
- **Account rows are easier to hit.** Edit and Archive are now full-size buttons with more space between them, and Archive carries a small archive icon so the one that changes something is recognisable without depending on it turning red.
- **The summary figures across the top now wrap instead of squashing.** On a narrow window the row of headline numbers used to compress until the amounts were clipped; it now reflows onto fewer columns.
- **Opening the page no longer jumps.** The Accounts page shows a placeholder in the shape of the real layout while it loads, rather than a line of text that is then replaced. If you have no accounts yet, the page now explains what to add and offers the button, instead of just saying there is nothing there.
- **Current account and credit card are told apart at a glance.** Their two icons were near-identical at the size they are actually drawn.

### Changed — 2026-08-08 (faint grey text across the whole app)

- **The faintest grey in the app is no longer used for words.** Dates, table headings, account types, hints under form fields, "Signed in as", the version number, placeholder text in search boxes and the small icons beside things — all were set in a grey too pale to meet the accessible-contrast standard, in both light and dark themes. Every one of them has moved up to the next tier, which is legible. The pale grey is now only used to fill in a chart segment or a progress bar, where nothing has to be read.
- **Status pills and the labels above summary figures are bigger.** Both sat below the readable minimum; they now match the rest of the small text in the app.
- **Headings are in the right order for screen readers.** Some section and card titles were announced a level below where they belong, which made the page outline read as though content was missing.

### Added — 2026-08-07

- **A design reference for the project.** `DESIGN.md` records the colours, type, spacing and component rules the app is built from, in an open format that coding tools can read, so new screens stay consistent with the existing ones.
