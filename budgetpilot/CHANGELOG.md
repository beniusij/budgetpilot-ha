# Changelog

## [0.4.9] — 2026-10-01

### Fixed

- **A failure in one part of Taupa no longer risks taking the whole app down.** If something goes wrong while Taupa is answering a request, that request now fails on its own and tells you so, and the rest of the app carries on — everyone else in the household stays signed in and nobody has to restart anything. What went wrong is written to Taupa's log with enough detail to chase it, while the message you see stays a plain "something went wrong, please try again", because the underlying detail can name things from inside your data.
