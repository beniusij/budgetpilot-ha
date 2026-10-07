# Changelog

## [0.4.33] — 2026-10-07

### Fixed

- **A sync the Home Assistant box turned down no longer looks like a network fault.** The Developer page said "Hasn't reached the hub" for every failed sync, even when the box had answered and refused. It now says "The hub refused the last sync" in that case, with the box's reason underneath, so you can tell a connection problem from one the box needs fixing.
