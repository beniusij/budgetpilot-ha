# Changelog

## [0.4.51] — 2026-11-03

### Fixed

- **Answering a sync disagreement no longer shows a database error.** Choosing the hub's version of a transaction could fail when another copy of the same bank transaction, still waiting for its own answer, held its bank reference — and the screen showed the raw database message. Taupa now tells you which disagreement to answer first, and any other failure shows a plain "Something went wrong" instead.
