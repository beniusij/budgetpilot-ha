# Changelog

## [0.3.62] — 2026-09-14

### Fixed

- The archive confirmation no longer says an account can be restored from a trash. Nothing in Taupa brings an archived account back, so the promise was untrue — what the dialog still tells you is what actually happens: the account is hidden, and its past transactions stay put but lose the account link.
- Importing a statement no longer says it is writing to Notion. It writes to your own database, as it has since the move off Notion.
