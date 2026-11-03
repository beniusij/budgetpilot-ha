# Changelog

## [0.4.50] — 2026-11-03

### Fixed

- **Sync no longer asks about records both devices changed the same way.** When two devices made the identical change while apart — importing the same statement, or applying the same update to your records — sync used to list every one of them as a disagreement, even though both versions were the same. It now settles them on its own, and clears any such disagreements already waiting. You are still asked whenever the two versions really differ.

### Internal

- The roadmap marks the Amex duplicate-payment fix as done.
