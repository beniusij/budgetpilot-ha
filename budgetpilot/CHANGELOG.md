# Changelog

## [0.3.49] — 2026-08-31

### Fixed

- The upload dropzone now reads "Choose a file" whatever the account is, instead of naming a single format. The line beneath it still lists the file types that account supports.
- **A paused bill no longer shows £0.00 in its money columns — it shows a dash.** The Bills page reads as "what am I paying this month", and a paused bill is charged nothing that month. It was already left out of the totals at the foot of the table, but printing £0.00 in Total and in the share columns made it look like a bill that costs nothing rather than one that is not being charged, and made the footer look as though it did not add up. Those cells, and the "per month" line beneath the total, are now a dash. The row still says **Paused** where the next payment date would be, so it is clear why the figures are gone.
