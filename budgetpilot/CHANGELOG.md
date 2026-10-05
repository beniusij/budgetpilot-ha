# Changelog

## [0.4.22] — 2026-10-05

### Added

- **The desktop app updates itself from your Home Assistant box.** When the box has a newer version, a banner offers it: install and restart straight away, or choose Later and it installs in the background, ready for the next time you open Taupa. Each update is checked against Taupa's signature before it is installed, and your household's data is left exactly as it is. Updates within the same major version arrive this way; a new major version still needs a fresh download.

### Changed

- **Installing the desktop beta without an administrator's password.** The install window now explains what to do if dragging Taupa into Applications asks for a password: drag it into the Applications folder in your home folder instead. Your household's data stays in your own account either way.

### Fixed

- **The desktop beta can reach your Home Assistant box after an update.** Each new build used to look like a different app to macOS, so the permission to use the local network did not carry over and syncing failed with a message about a typo in the address. Builds now keep the same identity: allow Taupa on the local network once and it stays allowed.
- **Pairing a Mac with the Home Assistant box now says why it could not connect.** When macOS has not allowed Taupa on the local network, the Sync tab used to ask whether the address had a typo; it now says to turn Taupa on under System Settings → Privacy & Security → Local Network. A box that is switched off or refusing connections is also described in plain words on the desktop app, as it already was in the add-on.
