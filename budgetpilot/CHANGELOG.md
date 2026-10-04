# Changelog

## [0.4.13] — 2026-10-02

### Fixed

- **A Home Assistant box set up before sync can now hand a second device the whole household.** The box only passed on what had changed since sync was installed, so a new device would have been sent a few recent transactions without the accounts, categories and people they belong to, and would rightly have refused them. When the box issues a pairing code it now gives everything already there its place in the queue first. Sync is not switched on in the app yet; this turned up while testing it against a real box.

### Internal

- Roadmap: the two-device sync test against a real box has started, and the colour-scheme redesign is now a Phase 2 card, to be done with Impeccable, a design toolkit for coding agents.
