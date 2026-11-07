# Changelog

## [0.4.64] — 2026-11-07

### Changed

- **Every page is the same width.** The content used to be wider on Overview, Transactions, Bills and Investments than on the other pages, so its edges moved as you went from one page to another. All pages now use the width Transactions had. Pages that are mostly reading, such as the guides and the terms, keep their lines at a comfortable length inside it.

### Fixed

- **Moving between pages no longer redraws the whole window.** The sidebar and the toolbar along the top now stay where they are as you go from page to page, and the page you are leaving stays on screen until the next one is ready, instead of the window going blank with "Loading…" for a moment. This applies in the desktop app and in the browser.
