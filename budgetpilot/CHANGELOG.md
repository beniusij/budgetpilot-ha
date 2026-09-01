# Changelog

## [0.3.57] — 2026-09-01

### Added

- **When the app spots a recurring payment, you can now point it at a bill you already have** instead of only adding a new one or dismissing it. Some bills are named nothing like they appear on a statement — a landlord's name against "Rent", a provider that changed hands — so the app kept offering them as something new. Choose the bill from the list and those charges are counted as it from then on, on every device and for both of you. The bill's cost is left exactly as it is; if the charge and the bill disagree, the bill's row will say so, as it always has. Links are listed on the bill itself, under **Linked charges**, so one made by mistake can be removed.

### Fixed

- A **paused bill no longer shows a price-change marker** in its Total column. Every other figure on a paused row is already a dash, because nothing is charged that month — but a "▲ £5" was still sitting beside it, announcing a rise in a payment that is not going out.
- When a bill has **both** a recorded price change and a charge that disagrees with its cost, the two markers now sit one above the other with the amount beside them, instead of being squeezed onto a single line.
