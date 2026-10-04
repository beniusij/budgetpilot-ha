# Changelog

## [0.4.15] — 2026-10-04

### Fixed

- **Only one machine fetches investment prices once your devices sync.** A second device connected to your Home Assistant box no longer fetches prices of its own; it gets them from the box with each sync. If both fetched, each would record its own price for the same day, and the next day the two would refuse to sync with each other at all. Pressing **Refresh prices** on a connected device now says the prices come from your Home Assistant box. A machine that isn't syncing fetches exactly as before.
