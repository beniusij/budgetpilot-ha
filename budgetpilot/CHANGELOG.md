# Changelog

## [0.4.7] — 2026-10-01

### Changed

- **A new household starts with the categories a UK statement actually needs.** Setup used to create six — rent, utilities, groceries, eating out, entertainment and savings — while the built-in import rules were written against a different, longer list, so almost every rule pointed at a category you did not have and your first import filed nothing. There are now fourteen, covering transport, health, shopping, travel, subscriptions, phone and internet, insurance, and transfers between your own accounts, and the import rules name exactly those. Rename, retarget or archive any of them as before. If you are the only person in your household, all fourteen are yours rather than some of them being marked as shared with nobody.

### Fixed

- **Your first statement import now categorises most of itself.** Petrol, trains and parking, the supermarket, takeaways, the pharmacy and the gym, streaming, flights and hotels, online shopping, your energy and water bills, your phone and your card payments are all recognised out of the box and filed under the matching category. Before this, a brand-new household had one rule in fourteen that could land anywhere, so nearly every row waited for you to pick a category by hand.
- **Two import rules on the same shop no longer shadow each other.** If you keep one rule filing a shop's spending as shared and another filing it as your own, the one that applies is now the one matching the side of your money the transaction is on — rather than whichever happened to sit higher in the list, which claimed every row and filed half of them against the wrong side. A rule pinned to shared money simply does not apply to a personal transaction any more, so instead of pre-filling the wrong category for you to notice and correct, the row falls through to your bank's own category or waits for you to pick. Rules with no side set still apply to everything, as they always have.
