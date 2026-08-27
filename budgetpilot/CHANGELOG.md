# Changelog

## [0.3.30] — 2026-08-27

### Added — 2026-08-27

- **Taupa now warns when changing your finance model would silently switch off a pay schedule.** A pay schedule names the category your pay lands in, and each finance model counts income from a different set of categories — so switching model could leave a schedule pointing at a category the new model never looks at. It kept working right up until the switch, then quietly stopped, and the only sign was an income figure sitting near zero until payday. The confirmation box now names each member whose pay schedule would stop applying before you commit to the switch, the pay schedule itself says so in Settings for as long as it isn't applying, and the dashboard's Income tile flags it with the reason in its ⓘ. Nothing is changed for you — the category you picked was a deliberate choice, so Taupa tells you rather than guessing a replacement — and the switch is never blocked.
