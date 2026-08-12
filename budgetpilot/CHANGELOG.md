# Changelog

## [0.3.22] — 2026-08-12

### Fixed — 2026-08-12 (Amex: two identical charges no longer import as one)

- **Two charges on the same day, for the same amount, at the same merchant are no longer treated as one.** Booking two identical flights on the same card on the same day left only one of them in Taupa, so the card balance came out short by the missing charge. American Express prints a reference number against every transaction and Taupa was throwing it away, leaving it to compare the date, amount and description alone — by which measure the two were indistinguishable. It now reads that reference, so two genuinely separate charges stay separate.
- **When two rows still look alike, the import asks rather than guesses.** If the references differ, the second row arrives ready to import and needs a category before you can continue, so you see it. If neither row carries a reference — Lloyds, Revolut and Nationwide statements don't provide one — it is still flagged as a duplicate and skipped by default, with the same tickbox as before to say it is a separate charge.
- **Re-importing an old Amex statement repairs your history and adds anything that went missing.** Transactions imported before this change have no reference stored against them. Dropping the same statement in again quietly attaches the right reference to each one — your categories, scopes and notes are untouched — and brings in any charge that was wrongly skipped at the time. The review step shows these as "linked", and the summary reports how many were repaired alongside how many were added.
