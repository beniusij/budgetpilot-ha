# Changelog

## [0.3.44] — 2026-08-30

### Added — 2026-08-29

- **Pause a bill you have put on hold.** A gym membership frozen for the winter, a subscription stopped over the summer — a bill can now be paused from the Bills register instead of deleted, and the budget for the paused months drops by exactly what it was carrying, so the money shows up as yours to spend. The bill stays on the register marked "Paused", with no due date counting down and nothing listing it among the payments coming up, and it comes back at whatever it costs when you resume it. A pause starts **from the month you are in**, so the change shows up straight away — unless that month's payment has already gone out, in which case it starts next month and the bill says so ("Paused from Sept"). That exception is there so a month whose money has already left is not reported back to you as spare. It stays paused until you resume it; nothing brings it back on its own. Contract renewal reminders still appear on a paused bill, because a fixed term ends on its own schedule whether or not you are currently paying.
- **⌘F now jumps to the search box on the Categories settings page too.** The Bills and Transactions registers already did this; Settings → Categories was the odd one out and still opened the browser's own find bar, which only searches the rows currently on screen rather than the whole list.

### Fixed — 2026-08-29

- **Changing a household member's name no longer loses what was recorded about them.** A member's name is now just a label: their history, the "Last changed by" notes on the shared settings cards, and whatever they are in the middle of doing all follow them to the new name. Previously a rename quietly cut someone off from their own money — they would keep their login but stop seeing their own accounts and lose their admin rights until they logged out and back in. Renaming is an Admin action, and for now happens behind the scenes rather than on the Settings page. One thing is left alone on purpose: under Pooled income, the Joint category named after a member for their pay keeps its old name — it is yours to rename if you want it to match.
