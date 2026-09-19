# Changelog

## [0.4.3] — 2026-09-19

### Added

- **Manage your household's members from Settings.** The household's admin can now rename anyone, add a partner to a household of one, hand the admin role to the other member, or remove a member, all from the Members card under Settings → Household. Adding a partner asks the same questions as setup: how you'll handle money together, how you'll split shared costs, and their PIN if your household uses PINs. Before you remove someone, Taupa lists everything of theirs that will be deleted and asks you to type their name. What the two of you shared stays. Once you're on your own, Taupa offers to switch the household to solo, which makes everything you shared yours. It saves a copy of the household as it was before the switch.
- **A PIN is now optional.** Setting up a household still offers one and still ticks the box for you, but you can turn it off — useful if Taupa lives on a laptop only you use, or on one you and your partner already share. Without a PIN, Taupa opens straight to your dashboard if you are the only member, or asks which of you it is if there are two. The choice is the household's rather than each member's: either everyone sets a PIN or nobody does, since a half-locked household protects nobody. The wizard says plainly what turning it off gives up — with no PIN, anyone at that device can open Taupa as either of you, including the accounts, spending and goals each of you keeps personal.

### Fixed

- **Sign out now signs you out.** Clicking it appeared to do nothing — the app stayed on the dashboard, then dropped you at the login screen on its own a few minutes later. It now returns you to the login screen straight away, and clears what the previous session had loaded, so nothing from it is left on screen for whoever signs in next.
