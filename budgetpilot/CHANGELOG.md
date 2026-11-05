# Changelog

## [0.4.56] — 2026-11-05

### Internal

- **When publishing a desktop update or pulling the household's data can't open a connection at all, the message now points at the Mac's Local Network setting.** It used to suggest only that the add-on was down or the address was wrong, when the add-on was fine and the Mac was keeping the tool off the home network.
- **Publishing a desktop update now gets through even when the Mac keeps developer tools off the home network.** It sends the build with the Mac's own curl, which that setting does not hold back, so there is nothing to allow first. Once the update is published, the packaged app and its install images are deleted, so old builds no longer pile up on the maintainer's Mac.
