# Changelog

## [0.3.61] — 2026-09-12

### Added

- **A Reset button on the Transactions and Bills filter bars**, to clear everything you have narrowed by in one click — the keyword you typed, and every drop-down including Scope, all back to All. It appears at the end of the row of filters only once something is actually filtering, so an untouched bar stays as it was, and the button being there is itself a reminder that the page is showing you less than everything. On Transactions it leaves the Household/Mine tabs alone: those choose which side of your money you are looking at rather than narrowing it.

### Fixed

- **Choosing an option from a drop-down works again.** Since the drop-downs changed in 0.3.59, clicking an item in an open list did nothing at all — the filter, or the field you were editing, was left exactly as it was. The list closes when you press away from it, and it counted a press on its own options as a press away, so it disappeared out from under the pointer before the click could be registered. This affected every picker in the app, and the keyboard — arrow keys and Enter — was the only way through. Dragging a long list's scrollbar no longer closes it either.
