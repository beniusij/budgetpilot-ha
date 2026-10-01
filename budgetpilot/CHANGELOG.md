# Changelog

## [0.4.10] — 2026-10-01

### Removed

- **PINs are gone.** Taupa no longer asks for a PIN, and there is nothing left to
  set, change, reset or turn on. If there are two of you, Taupa opens by asking
  which of you it is and you pick your name; if you're on your own, it opens
  straight to your dashboard. The Sign-in card has been taken out of Settings, and
  so has resetting your partner's PIN — there is nothing there to reset. Any PIN
  you had chosen is deleted from your household's database when you update.

  A PIN in front of Taupa never protected the thing people assume it did. Taupa's
  database sits in a file on your own machine, and anyone who can get at that file
  can read everything in it without opening Taupa at all. What a PIN did buy was
  keeping the two of you out of each other's personal accounts, spending and goals
  — and **that is now gone too**. Either of you can open Taupa as the other and
  see what the other keeps personal. Taupa says this plainly when a new household
  is created, rather than leaving it to be discovered.

  Two other things worth knowing. If you run Taupa as the Home Assistant add-on,
  anything on your home network can now reach it and open it as either of you —
  a trusted home network is what that add-on assumes. And a Taupa you use in a
  browser on a machine that isn't yours will one day ask for an email address and
  a password instead; that is for a future web version and does not affect the
  app you install.
