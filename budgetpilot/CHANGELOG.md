# Changelog

## [0.3.15] — 2026-07-28

### Added — 2026-07-28 (loans, experimental)

- **Track what you owe and what you're owed.** A new Loans page records mortgages, car finance, personal loans, money you've lent to someone else, and IOUs between household members. Each loan shows how much is left, how much you've cleared, the month it finishes and the interest still to come.
- **The balance works itself out.** You enter the loan once — amount, rate, term, monthly payment — and tag the repayments as they arrive. Taupa works the outstanding balance out from those payments, so there's no figure to keep up to date by hand and nothing that can quietly disagree with your transactions. Miss a month and the balance grows, as it really would; overpay and it clears sooner.
- **Tag repayments from the Transactions page.** Select the payments and use **Assign to loan**; the loan's balance updates from them. Re-uploading the same statement won't lose the tag.
- **Loans now count towards net worth.** On the Accounts page, money you owe counts against your net worth and money lent to you counts towards it, alongside your cash and investments.
- **An IOU is visible to both of you.** A loan recorded against another household member shows for them too, so "I lent you £500" isn't invisible to the person who owes it. Every other personal loan stays private to whoever recorded it.
- Loans sit behind the **Experimental features** toggle in the user menu. With it off, the page is hidden and net worth is unchanged.
### Fixed — 2026-07-28 (free to spend and credit cards)

- **Spending on a credit card no longer increases your Free to spend.** Card purchases counted against your budgets straight away, but the money hadn't left any account yet — so importing a card statement could push the figure up instead of down, then drop it sharply when the bill was paid. Free to spend now subtracts what your cards owe, so a card purchase affects it exactly like a debit-card purchase does, and paying the bill changes nothing.
- **Free to spend now shows what you owe on cards.** The explanation panel behind the figure gains an "Owed on cards" section listing each card and your share of its balance, and the running total reads `cash − owed − reserved`.

### Added — 2026-07-28 (credit card repayment mode)

- **Credit cards can be marked "Pay in full" or "Financed".** A card you clear each month is money already spent, so its balance comes off Free to spend. A card holding a 0% or instalment balance you're paying down over time is a loan rather than this month's bill, so its balance is left out — add a bill for the monthly payment and that gets reserved instead. The option appears only on credit cards. Existing cards start as "Pay in full", so mark any card on an instalment plan to see the figure settle.
