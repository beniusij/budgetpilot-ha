# Changelog

## [0.3.27] — 2026-08-23

### Fixed — 2026-08-23

- **Changing a filter on the Transactions page no longer leaves the old rows on screen.** Filtering by repayment status could show transactions that plainly didn't match — transfers and savings rows sitting above the ones you'd asked for. The filter was right all along; the ledger was still displaying part of the previous, unfiltered view. It happened only on days carrying a transfer whose two sides fell on different dates, which split that day into two headings and confused the page about which rows it had already drawn. Each day is now drawn once, so what you see is always the result of the filter you set.

- **The Outstanding and Pending filters no longer list things you don't owe.** Filtering credit-card transactions by repayment status could return rows that aren't repayments at all: a payment onto the card that arrived without a category was read as a merchant refund and listed as money owed, and reconciliation adjustments — the balancing rows that stand in for activity rather than being any — were listed alongside real purchases. Both are now left out, of the filters, the row badges and the dashboard's per-card outstanding figure.
- **A card you're paying off over time no longer tracks each purchase separately.** Purchases on a card marked *Financed* were given the same Outstanding/Pending state as ones on a card you clear every month — but you never settle those individually, so they sat outstanding forever with no way to clear them. A financed card's balance is a loan repaid as a bill, so its rows now carry no repayment status at all, and its tile drops the outstanding/pending hover figure that would only ever have read zero.
