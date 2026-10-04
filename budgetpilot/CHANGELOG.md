# Changelog

## [0.4.19] — 2026-10-04

### Added

- **Sync with your Home Assistant box, in the add-on and the desktop beta.** Settings now has a **Sync** tab: a machine asks the Home Assistant box for a pairing code, which appears in the add-on's log in Home Assistant beside the machine's name, then types it in to pair; the box's own Sync tab lists the machines paired with it. A paired machine can see when it last synced, point itself at a different box, and settle any edit that was made in two places at once. A brand-new machine can join the household already on the box from the first screen of setup instead of building one from scratch, and starts syncing as soon as it is paired. On a paired machine the overview says when it last synced — or that it is synchronising, offline, has a sync problem, or has disagreements waiting for an answer — and opens the Sync tab when clicked. Sync is still being finished, so it appears only in the add-on and the desktop beta; the public app shows none of it.
