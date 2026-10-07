# Changelog

## [0.4.37] — 2026-10-07

### Changed

- **A transaction's category now has to match its split.** A shared transaction takes a shared category, and a personal one takes one of your own. Taupa refuses any other pairing, so neither of you counts money under a category the other can't see. Transactions filed before this change keep their category until you change it.
- **A partner's personal transaction on a joint account is theirs alone.** You now see which of their categories it's filed under instead of "Uncategorised". You can't change it, settle it or delete it.
- **Making a shared transaction personal makes it yours.**
- **Change a transaction's split and category together.** A new edit button on each row opens a small window for both. Switch the split and it asks you for a category that fits. Changing the split or category of several transactions at once goes through the same window for any that need a new category, one at a time, and you can skip any of them.
- **New households get a personal Transfers category for each member** alongside the shared one. Transfers you import are filed under the one that matches their split.
