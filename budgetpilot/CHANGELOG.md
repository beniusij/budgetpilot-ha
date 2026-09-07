# Changelog

## [0.3.59] — 2026-09-07

### Changed

- Notifications now appear in the bottom-right corner instead of the top-right, so they no longer cover the page heading and filter row of whatever you were looking at. When several arrive at once, the newest sits closest to the corner.
- **Drop-down lists now open underneath the control you clicked, instead of on top of it.** Every picker in the app — the filter chips, the category on a transaction row, and every field in a form — used the one your operating system draws, which puts the current choice directly over the button, so the thing you had just clicked disappeared behind the list. The list is now Taupa's own: it opens below the field (or above it, when the field is near the bottom of the screen), ticks the current choice rather than hiding it, and keeps the keyboard behaviour you would expect — arrow keys and Home/End to move, Enter to choose, Escape to give up, and typing the first few letters of an option to jump to it.
