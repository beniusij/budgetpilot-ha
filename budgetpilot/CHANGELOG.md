# Changelog

All notable changes to BudgetPilot are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Most recent first.

## [Unreleased]

## [0.2.9] — 2026-07-20

### Fixed — 2026-07-19 (stale bill cost / category buffer display)

- **Bills and categories now show the cost that's actually in effect this month.** A cost change
  recorded ahead of time (e.g. "£300 from July", saved in June) updated the derived budgets on
  time but the Bills page kept showing the old amount once the month arrived — the current-value
  copy on the Notion row was only re-written when the cost history changed, so it froze at the
  pre-change value. `GET /bills` and `GET /categories` now resolve the today-effective amount
  from the Budget Change Log on every read, falling back to the stored value only for rows with
  no applicable history.

### Fixed — 2026-07-19 (Revolut dates, same-account transfer links)

- **Revolut imports now carry the date you paid, not the date the payment settled.** The parser
  preferred the CSV's `Completed Date`, but card payments settle overnight and the Revolut app
  lists them by `Started Date` — so imported transactions appeared a day late and didn't line up
  with the bank's own history. New imports now use `Started Date`; rows imported before this fix
  keep their settlement date (re-importing an overlapping statement would read those rows as new,
  so correct any that matter by editing, not re-importing).
- **Two legs of a transfer in the same account can now be linked.** The manual "Link as transfer"
  modal only offered counterpart transactions from *other* accounts, so a same-account pair — e.g.
  Revolut's "Balance migration to another region or legal entity" debit + credit — couldn't be
  linked and skewed spending. Same-account counterparts are now offered and rank by the usual
  amount/date closeness.

### Fixed — 2026-07-19 (settle modal save)

- **Saving a settlement is now a single request.** The modal used to chain two mutations (the
  settle link, then a bulk clear of the covered rows' stored status), so the Save button briefly
  re-enabled mid-save, two success toasts appeared, and the modal lingered open well after the
  list had updated. The server now clears the covered rows' status inside
  `POST /transactions/:id/settle`, so one "Settlement saved" toast shows, the button stays
  disabled while saving, and the modal closes as soon as the refreshed transactions land.

### Fixed — 2026-07-19 (repayments)

- **Settled credit-card purchases no longer leak back into Pending/Outstanding.** The Notion API
  truncates a relation list to its first 25 ids, so a settlement covering a whole month of card
  purchases silently lost the rest — those rows re-derived as Pending/Outstanding and reappeared in
  the Repayment filter views. The server now completes any truncated `Settles` relation via the
  page-property endpoint.
- **Shared transfers to a credit card no longer show "Outstanding".** The bank-repayment exclusion
  matched a single "Transfers" category id, but scoped categories mean a personal and a shared
  "Transfers" can coexist — inflows filed under the other one were mistaken for merchant refunds.
  Repayment badges, month summaries, and category spend now match every category named "Transfers"
  (`categoryIdsNamed`), whichever scope it belongs to.

### Changed — 2026-07-19 (settle modal)

- **Settle modal candidates are scope-matched.** The "Settle purchases" picker now lists only
  pending purchases whose Personal/Shared scope matches the repayment being settled (a scope-less
  payment still lists both sides; rows an existing settlement already covers stay listed for
  editing).

### Changed — 2026-07-19

- **Scope-filtered category options.** When the Scope filter is set to Personal or Shared, the
  Category filter on the Transactions and Bills pages now lists only that side's categories, and a
  selected category that falls out of scope resets to All when the scope changes.
- **"Split" renamed to "Scope" in the UI.** The Transactions filter chip and the Add-transaction
  modal's Shared/Personal field are now labelled "Scope", matching the Bills page and the
  transactions table column. (The bill modal's Proportional/Fixed "Split" field — how a shared
  bill divides between members — keeps its name.)
- **Bills monthly-equivalent total shows pence.** The filter bar's monthly-equivalent figure now
  renders with two decimal places instead of whole pounds.

### Fixed — 2026-07-19

- **Category hover tooltips now show the real monthly budget.** The category tooltip on the
  Transactions ledger and the Bills table showed "none set" for categories whose budget lives in
  the Budget Change Log or comes from linked bills (e.g. Groceries at £1,000/mo), because it read
  the raw `Monthly Target` property. It now shows the month-effective budget
  (`categoryBudgetForMonth`: smoothed bills + budget-log buffer).

- **Bill icons with long keys no longer fail validation.** Saving a bill with an icon whose key is
  longer than 8 characters (e.g. Education's `education`, `subscription`, `entertainment`) was
  rejected with "icon must be a short string (≤ 8 chars) or null" — a leftover limit from the emoji
  era. The server now accepts icon values up to 32 characters.

## [0.2.8] — 2026-07-19

### Changed — 2026-07-19

- **Category filters now mark each option as personal or shared.** The Transactions category filter,
  the bulk-action "Set category…" dropdown, and the Bills category filter label every option with
  its scope (`Groceries · Shared` / `Hobbies · Personal`), matching the settings rules editor's
  indicator style, and sort options by label so same-named categories sit together. The label format
  lives in one shared helper (`client/categories/categoryOptions.ts`), also reused by the rules
  editor.

## [0.2.7] — 2026-07-19

### Added — 2026-07-19

- **Override false duplicate flags on CSV upload.** A review row flagged as a duplicate by content
  match (date + amount + description) — e.g. two identical same-day charges like a repeated Autopay
  payment — now carries an untick option ("duplicate of an existing transaction — untick if this is
  a separate charge") to mark it "not a duplicate" and import it anyway. Rows matched by the bank's
  stable transaction id are genuinely the same transaction and stay excluded.

## [0.2.6] — 2026-07-14

### Fixed — 2026-07-14

- **Rule category picker no longer offers a bare duplicate of a scoped category.** A built-in or
  legacy rule without a `scope` used to add its category as an extra scope-less option (e.g.
  "Savings" alongside "Savings · Personal"). The picker now shows only the scoped variant(s) —
  "· Personal", "· Shared", or both when the name exists as both — and keeps a bare option only for
  a rule category that doesn't exist at all. A scope-less rule pre-selects the single matching
  variant; when both variants exist it shows the placeholder so the member disambiguates.

### Added — 2026-07-14

- **Duplicate an auto-categorisation rule.** Each rule row has a copy button that inserts an
  identical rule right below it — a quick starting point for a variant.
- **Undo for rule deletion.** Deleting a rule shows a toast with an **Undo** button (visible for
  1 minute) that restores the rule at its original position.

### Fixed — 2026-07-13

- **Auto-rule categories that don't fit a row's split no longer slip through import.** A rule that
  landed a shared (`Joint`) category onto a personal transaction (or vice-versa) produced a category
  the split-filtered picker can't show — the row rendered as the empty "Choose category…"
  placeholder yet wasn't highlighted and didn't block the Import button. `needsCategory` now treats a
  category invalid for the row's split as **uncategorised**, so the row is flagged and import is
  blocked until it's set. This also covers flipping a row's split (per-row or **Set all**) after
  auto-categorisation.

### Added — 2026-07-13

- **Auto-categorisation rules can target an exact shared/personal category.** When the same category
  name exists as both a shared (`Joint`) and a personal category (e.g. two "Travel"), a rule now
  pins which one via a `scope` (`Shared`/`Personal`). The Settings → Auto-categorisation rules card
  shows a shared/personal indicator on each category option and lists the two variants separately, so
  the choice is explicit; import resolves the rule to that exact category (name + owner).

## [0.2.5] — 2026-07-13

### Fixed — 2026-07-13

- **Duplicate transactions from a single import.** Statement import now de-duplicates a batch
  against **itself**, not just against transactions already in Notion. Previously the dedup index
  was built once from existing rows and never updated as the batch created rows, so if the same
  transaction appeared twice in one file/import both copies were written — silently skewing the
  account balance (e.g. a doubled Monzo charge). Both the server (`runImport`) and the review step
  (`buildReviewRows`) now register each row as it's imported, so a repeated `bankTxId` (or identical
  date+amount+description) later in the same batch is recognised as a duplicate and skipped.

## [0.2.3] — 2026-07-13

### Added — 2026-07-12

- **Customisable auto-categorisation rules.** The "Auto-categorisation rules" card in Settings ›
  Categories is now editable (previously read-only): add, edit, reorder (first keyword match wins),
  and delete the keyword→category rules that pre-fill categories during CSV import. Rules are
  **per-member and private**, seeded from the built-in defaults until you customise them, and stored
  in the settings JSON (`categoryRules`). CSV import applies the signed-in member's rules; the
  bank-category fallback stays fixed in code. Keywords match at a **word boundary** (as a whole word
  or the start of a longer token), so short keywords like `ee` match the token "EE" without also
  firing on the "ee" inside "coffee".

## [0.2.2] — 2026-07-11

## [0.2.1] — 2026-07-11

### Changed — 2026-07-10

- The dashboard hero band's right side is now a **3-slide auto-rotating carousel** (cycling every 60s) that
  crossfades between the Needs/Wants/Savings split, the top goals, and an investments summary with a compact
  sparkline. Dots underneath show the slide count and let you jump directly (which resets the timer).
- Removed the standalone **Goals** and **Investments** cards from the dashboard grid — both are now surfaced
  in the hero carousel above.

## [0.2.0] — 2026-07-08

### Changed — 2026-07-08 (Taupa page-by-page restyle & rename)

- Restyled **every page** to the Taupa clay/dark mocks — Accounts, Goals, Bills, Reconcile, Dashboard,
  Investments, Transactions, Settings and Uploads — built on shared primitives (Card + flush variant,
  Button, Modal, StatStrip, PageHeader, FilterChip, Segmented, CategoryTag, SplitBadge, a custom clay
  checkbox and form styles) so the look stays consistent and easy to extend.
- Adopted the new **coin-mark** brand: favicon, maskable app icons, sidebar logo, and dark PWA theme colour.
- The Investments **value-over-time** chart is now a hand-rolled clay SVG area chart on a weekly grid with a
  hover readout; the Transactions ledger is a day-grouped table with a floating bulk-action bar.
- Renamed the visible app from **BudgetPilot** to **Taupa** (document title, PWA manifest, page titles, Login).

### Fixed — 2026-07-08

- Reconciliation adjustments are dated inside the reconciled month, so past-month accounts reconcile instead
  of re-showing a discrepancy.
- The dashboard **Income** figure is again the sum of the month's transactions in your configured income
  categories (a restyle pass had briefly switched it to the flat configured figure).

### Changed — 2026-07-06 (Adopt the warm-clay dark design system from the mocks)

- The app now wears the **Taupa mocks' warm-clay dark theme** — a single clay accent (`#cd7a52`) on warm
  near-black surfaces, with **Source Serif 4** display headings, **Hanken Grotesk** body, and **IBM Plex
  Mono** figures. It's a **dark-only** theme (the mocks define no light variant): the Tailwind `dark`
  variant is switched to a class strategy and pinned on `<html class="dark">`. The look is landed
  **centrally** by remapping Tailwind's colour and font tokens (`indigo-*` → clay, `gray-*`/`white` →
  warm neutrals, the font families), so every screen — including those without a mock — inherits it without
  per-component edits. **Note:** this replaces the previous indigo-on-gray light/dark system; light mode is
  no longer offered. (Supersedes the earlier light-mode muted-text contrast tweak.)

### Changed — 2026-07-06 (UX-review change set: Transactions, Investments, Reconcile, contrast)

- **Transactions:** the header gains an **Upload statements** button that links to the Uploads page
  (`/upload`), the canonical import flow. The inline **category cell** is now quiet — borderless and
  transparent until hover or keyboard focus, when it reveals the select chrome (with a focus-visible ring),
  so a full ledger no longer reads like a form. The bulk-action bar's **credit-card row** appears only when
  the selection includes a credit-card transaction. The per-row **settle** button reveals on row
  hover/focus-within and shows a focus-visible ring so it's reachable by keyboard. The header
  **transaction count** now derives from the displayed (filtered) rows so it always agrees with the footer,
  and the footer net uses the same `+£/−£` signed convention as the **Net** tile.
- **Investments:** the header actions now have a clear hierarchy — **Add asset** is the primary button,
  **Refresh** collapses to an icon-only control (with an `aria-label`/tooltip), and **Import statement** and
  **Add trade** are secondary. The header **Record price** button is removed; recording a price is a per-row
  action on each holding, which opens the same modal.
- **Info tooltips:** the summary/stat tiles on **Investments**, **Goals** and **Bills** gain `InfoHint`
  explanations describing how each figure is worked out (Transactions and the Dashboard already had them).
- **Reconcile:** the header badge and the step-1 footer note derive from **one source** (reconciled /
  discrepancy / pending) so they always agree, with the footer showing the full breakdown. **Next: Review**
  is disabled until every account reconciles, with a tooltip that explains the gate.
- **Contrast:** the muted `gray-400/500` text tiers are stepped up one shade in light mode (via the colour
  tokens, so every `text-gray-400/500` utility benefits) to clear WCAG AA for small functional text on light
  surfaces; the Tailwind defaults are restored under the dark media query where they already pass.

### Fixed — 2026-07-06 (Price feed now covers unlisted OEIC funds via FT)

- The automated price feed **auto-updates unlisted OEIC/index funds** (the Moneybox ESG share classes:
  Emerging Markets Shares, Global Property Shares, Global Shares, Overseas Corporate Bonds) that Yahoo and
  CNBC both 404 on. `fetchEquityQuote` now falls back to **FT markets data**, which quotes their daily NAV
  **by ISIN** — so their existing ISIN `Ticker` values just work and they no longer need manual pricing.
  FT is parsed currency-aware (`GBX` pence → GBP /100, `GBP` as-is) to avoid a 100× error.

### Fixed — 2026-07-06 (Hide investment accounts from the Transactions filter)

- The Transactions **Account** filter no longer lists `Investment` accounts (e.g. eToro, Moneybox).
  Those accounts never hold Transactions rows — their activity lives in Investment Lots and their
  cash deposits are intentionally dropped at import — so selecting them always showed an empty list
  and implied transactions that can't exist.

## [0.1.55] — 2026-07-06

### Changed — 2026-07-06 (Carry-forward is now a running balance)

- **Carry-forward accumulates across months** instead of resetting each month. At close the stored figure is
  `net + carry-in` — the month's viewer net **plus** what the previous closed month carried in — so unspent
  money rolls on (e.g. a £4,000 surplus that funds next month's spending is no longer lost). The dashboard
  and free-to-spend still read only the immediately-previous closed month, which now already folds in its
  predecessor. The Review step spells out the arithmetic ("Net £X + £Y brought forward = £Z"). Reopening a
  month still clears its figure, so re-close months in order to rebuild the chain.

### Fixed — 2026-07-06 (Reconcile shows each account's month-end balance)

- **Reconciling a past month now compares against that month's balance**, not today's. The calculated
  balance is opening balance + only the transactions dated on/before the month end, so viewing e.g. May
  with no activity by then shows each account's opening balance rather than its current live balance.
- The account row shows a **"Recalculating…"** indicator while an entered balance saves and its
  difference/status are recomputed. A **closed** month collapses the page to a read-only view: no step bar,
  and the footer offers only **Reopen month**.

### Added — 2026-07-05 (Carry-forward: last closed month flows into the next)

- **Closing a month now carries its surplus/deficit into the next month.** The month's net
  (income − spending) is stored on its Monthly Budget row (`Carry Forward`) at close and shown on the
  next month's dashboard — "▲ £X ahead / carried from {month}" (or "▼ behind") — and folded into
  Free-to-spend. It's **last-month-only and only once closed**: an open prior month carries nothing, and
  reopening a month clears its carry-forward. The Review step previews the figure before you close.
- Replaces the previous placeholder that approximated carry-forward from an unmaintained budget field.
- Requires a **`Carry Forward`** number column on the Monthly Budget Notion database.

### Added — 2026-07-05 (Reconcile Step 2: Review & close the month, with a read-only lock)

- **The Reconcile page can now close a month.** After reconciling, "Next: Review" opens a month-end
  summary — **viewer-relative like the dashboard** (your income = your money-in in your income
  categories; your spending = your personal spend + your share of shared spend), plus Needs/Wants/Savings
  vs targets and any unreconciled accounts — and a **Close month** action. Closing marks the month closed
  on its Monthly Budget row (`Status=Closed` + `Closed Date`, creating the row if the month has none). A
  closed month shows a Closed badge and can be **Reopened**.
- **Investment accounts are excluded from reconciliation** — their balance is holdings market value, not a
  cash balance to match against a statement, and the fluctuation isn't income until assets are sold.
- **Closed months are read-only.** The server rejects every transaction mutation (manual add, import,
  edit, bulk, transfer link/unlink, settle) that targets a closed month with a 409; the Transactions
  page for a closed month disables its edit controls and shows a read-only banner.
- Requires a **`Closed Date`** date column on the Monthly Budget Notion database (and `Closed` as a
  `Status` option).

### Fixed — 2026-07-04 (re-importing a statement restores deleted transactions)

- **Re-importing a statement no longer silently skips transactions you had deleted.**
  Import duplicate-detection read existing transactions through the stale-while-revalidate
  cache, so a snapshot captured before a soft-delete could reintroduce the deleted rows
  into the dedup index — and a re-import matched them by bank transaction ID and skipped
  them, so the transactions never came back. The import now reads **live, uncached** data
  (server `getTransactionsForImport()`; the review via `GET /transactions?fresh=1`) and
  **includes soft-deleted rows**: a re-imported row that matches a previously deleted one
  is now **resurrected in place** (its `Deleted` flag cleared and amount/date/description
  refreshed) instead of being skipped or duplicated.

### Fixed — 2026-07-04 (resilient Notion reads, reconcile warning opens its own month)

- **Server-side stale-while-revalidate cache in front of every Notion list read.**
  Notion's API has intermittent multi-second latency spikes; the cache serves the
  last-known-good data instantly and refreshes in the background, so a slow spell no
  longer hangs the dashboard (and a failed refresh keeps serving the cached value).
  Writes invalidate the affected dataset so edits still show immediately. Tunable via
  `NOTION_CACHE_TTL_MS` (default 60s).
- **The Notion cache now persists to disk** (`BP_NOTION_CACHE_FILE`, on the HA add-on's
  `/data` volume), so a restart or deploy reloads the last-known-good data and serves
  the first load warm while it revalidates — the dashboard no longer cold-hangs on a
  slow Notion right after a restart.
- The Notion client now uses a 20-second request timeout instead of the SDK's
  60-second default, so a Notion API slowdown surfaces as a quick, retryable error
  rather than a minute-long hang that leaves pages stuck loading.
- The Dashboard's "X accounts not reconciled for <month>" warning now opens the Reconcile
  page on **that** month rather than the current one. The link carries the month as a
  `?month=YYYY-MM` query param, which Reconcile reads to seed its viewed month; opening
  Reconcile directly (or via the sidebar) still defaults to the current month.

## [0.1.54] — 2026-07-02

### Changed — 2026-07-02 (HA add-on changelog now shipped & versioned)

- The root `CHANGELOG.md` is now copied into the Home Assistant add-on on every deploy,
  so the add-on's Changelog is no longer empty in the HA UI.
- `bump-version.sh` now cuts a release: it moves the `[Unreleased]` entries beneath a
  dated `## [<version>]` heading and starts a fresh `[Unreleased]`, so the changelog
  follows per-version sections from here on.

## [0.1.53] — 2026-07-02

### Fixed — 2026-07-02 (HA add-on: missing budget-log DB ID, price feed now configurable)

- **The Budget Change Log database ID is now passed to the Home Assistant add-on.**
  `notion_budget_log_db_id` was the one Notion DB ID missing from the add-on's `config.yaml`
  and `run.sh`, so `NOTION_BUDGET_LOG_DB_ID` was undefined in production. Budget-log queries
  then sent a blank `database_id`, which Notion rejected as `invalid_request_url` — the
  recurring `[Notion] Invalid request URL.` log lines. Set the new **Notion budget log DB id**
  option in the add-on config to fix it.
- **The automated price feed can now be enabled from the add-on config.** Added
  `price_feed_enabled` (toggle, off by default) and `price_feed_interval_hours` (1–168, default
  24) options, wired through `run.sh` to `PRICE_FEED_ENABLED` / `PRICE_FEED_INTERVAL_HOURS`.
- **`NotionAdapter` now fails loud on an unconfigured database ID.** A missing DB ID throws a
  descriptive error naming the database instead of silently sending a blank `database_id`, so a
  future misconfiguration is obvious rather than an opaque Notion URL error.

### Changed — 2026-07-01 (Investments "Value over time" chart: fixed 12-month window, consistent x-axis)

- The **Value over time** chart now samples the **last 12 months** on a uniform monthly
  grid (or from the first lot's month when history is shorter) instead of growing unbounded
  from the first-ever trade. `valueSeries`/`valueSeriesByAccount` take an optional `monthsBack`
  (default 12).
- The chart renders x-axis labels at **consistent intervals** (`equidistantPreserveStart`),
  replacing recharts' default that dropped ticks unevenly from the end.

### Changed — 2026-07-01 (Price-feed resilience, Holdings "Unit price" column, clearer chart labels)

- **The automated price feed now falls back to CNBC when Yahoo Finance fails.** Yahoo has grown
  aggressive about rate-limiting (`429 Too Many Requests`), which was silently starving equity
  prices. `fetchEquityQuote` now tries Yahoo first and, on any failure, retries against CNBC's
  keyless quote service — which accepts the same symbols (`VWRL.L`, `AAPL`) and the same `GBp`
  pence convention, so no ticker changes are needed. Both errors are surfaced together in the
  run's failure summary when neither source resolves.
- **The feed now runs once a day by default** (`PRICE_FEED_INTERVAL_HOURS` default `4` → `24`);
  daily-close prices don't need four refreshes a day, and less polling means fewer Yahoo 429s.
- **The Holdings table gained a "Unit price" column** showing the current GBP price per unit with
  a small "last updated" hint underneath — a relative "x minutes/hours ago" when the price was
  refreshed within 24 hours, or an absolute "last updated <date>" beyond that (day and month for
  the current year, with the year appended for a prior one). The timestamp comes from each price
  row's Notion `last_edited_time`, so it tracks the feed's in-place refreshes.
- **The Value-over-time chart's x-axis now shows a full year** (`Jul 2026`, not `Jul 26`), which
  was being misread as a day-of-month (the 26th of July).

### Added — 2026-07-01 (Configurable income categories)

- **You now choose which categories count as income.** A new per-member **Income categories**
  card on Settings → Household (`IncomeCategoriesCard`) lists your **strictly personal**
  categories (those you own, minus Transfers/Adjustments) as a checkbox list. The dashboard
  **Monthly income** tile and the Transactions summary strip now count only inflows filed under
  the categories you ticked — instead of every positive transaction — and the two always agree.
- Stored per member as `Settings.incomeCategoryIds` (validated and deep-merged like `nwsTargets`).
  When unconfigured, a name heuristic (`/salary|interest|refund/i`) pre-selects likely income
  categories; if none match, income falls back to the previous all-inflows behaviour, so nothing
  changes until you configure it. Ticking none reads £0.
- **Note:** only categories **you own** appear — `Joint`-owned categories (e.g. a shared
  `Interest`/`Refund`) won't be selectable until you set their `Owner` to your name in the Notion
  Budget Categories DB.

### Fixed — 2026-06-30 (Settle button on all credit-card inflows, Weekly bill frequency)

- **The "Settle purchases" button now shows on every incoming transaction to a credit-card
  account**, not only ones categorised `Transfers`. Previously a credit-card payment filed under
  any other category (or none) had no settle icon, so it couldn't be linked to its Pending
  purchases. Eligibility moved into a tested pure helper `canSettlePayment` (`settlement.ts`).
- **Bills can now be set to a `Weekly` frequency**, alongside Monthly/Quarterly/Yearly. It is
  selectable in the bill add/edit modal and the Bills filter bar.
- Weekly bills are normalised to a **monthly-equivalent** cost (×52/12 ≈ 4.333) everywhere bills
  are summed — the Bills table monthly subtotals, the summary strip, the dashboard cards, and the
  smoothed category budgets — so every frequency is comparable as a cost for the month. Each bill
  row shows the `≈ £x/mo` subtext for non-Monthly bills (Monthly rows already read per month).
- A Weekly bill's **next due date** rolls its anchor forward in 7-day steps, and it gets a 7-day
  "due soon" amber window on the dashboard's Upcoming bills card.

### Added — 2026-06-29 (Effective-dated salary & split ratio, Automated asset price feed)

- **Income and the household split ratio are now effective-dated.** Instead of single
  flat values, `Settings.financeProfile` holds an ascending array of `YYYY-MM`-dated
  snapshots of `{ splitMode, primarySharePct, incomePeriod, primaryIncome, partnerIncome }`.
  A pay rise (or a changed split) is recorded as a new entry effective from a chosen month;
  past months keep the snapshot that applied then — so historical bill distribution stays
  accurate instead of being recomputed with today's ratio.
- **"Effective from" control on the Settings → Household tab** (`EffectiveFromCard`): a month
  picker plus quick-nav chips for every recorded change (future ones flagged *scheduled*,
  each removable). It governs which snapshot the Income and Split cards edit — pick a future
  month to schedule a change, or a past month to correct history. Editing upserts the snapshot,
  inheriting the currently-effective values so the other member's income carries forward.
- **The dashboard now applies the month-correct split.** `SharedBillsCard` ("Your share") and
  `StatStrip` resolve `primaryShareFraction` for the **viewed month** via `financeProfileForMonth`,
  so stepping back to a past month distributes shared bills by the ratio of its time. The Bills
  page uses the current month.
- Legacy `settings.json` files migrate transparently — the old flat income/split fields become a
  single baseline snapshot (effective `2000-01`) on first read.
- **Investment prices can now be fetched automatically** instead of being recorded by hand.
  A new server-side feed (`app/src/server/price-feed/`) pulls per-unit prices from free, keyless
  public APIs — **CoinGecko** for crypto, **Yahoo Finance** for stocks/ETFs/funds/bonds, and
  **Frankfurter** (ECB) for the FX rate to GBP — and writes rows with `Source = Feed`.
- Each asset's **`Ticker`** drives the lookup: a Yahoo symbol for equities (e.g. `VWRL.L`, `AAPL`)
  or a CoinGecko coin id for crypto (e.g. `bitcoin`). Assets with a blank `Ticker` or class `Other`
  are skipped and stay manual. LSE pence quotes (`GBp`) are normalised to GBP.
- The feed keeps **one `Feed` row per (asset, day)**, refreshing today's row in place rather than
  appending, so history stays one-row-per-day while the current price updates intraday. Manual and
  statement-imported prices are never touched.
- An **in-app scheduler** (`PRICE_FEED_ENABLED`, every `PRICE_FEED_INTERVAL_HOURS`, default 4) runs
  it automatically; a **Refresh prices** button on the Investments page triggers it on demand via
  `POST /api/asset-prices/refresh`, toasting an updated/skipped/failed summary.

### Changed — 2026-06-28 (Merged Assets and Holdings into one investments table, Accounts "Service", real file-type tags, unified upload wizard)

- The Investments page now shows a **single table** of every asset instead of separate
  **Holdings** and **Assets** tables. Held assets appear first (units, avg cost, value, gain);
  not-currently-held assets (fully-sold or brand-new) are listed below as "Not currently held"
  so they stay manageable. Clicking any row opens `AssetDetailModal`, which shows the asset's
  details with inline **Edit** (Save/Cancel in place) and **Delete** above its trade history —
  the old `TradeHistoryModal` and `AssetsTable` are gone. Delete is still refused with a 409 while
  trades reference the asset (now surfaced inline).
- The asset **Currency** field is now a **dropdown** (GBP/USD/EUR/CHF/JPY/CAD/AUD/SEK, preserving
  any existing out-of-list code) in both the create modal and the inline editor, replacing the
  free-text input.
- **Account "Bank" → "Service".** The account field is renamed in the UI to **Service** and now
    accepts brokers (**Moneybox**, **eToro**) alongside banks (Monzo/Lloyds/Amex/Revolut/Other). The
    options are **filtered by account type** — Investment accounts offer brokers, cash accounts offer
    banks. The Notion column is still named `Bank`; `Account.service` parses it. A new single source of
    truth (`app/src/client/upload/services.ts`) maps each service to its file type(s), CSV parser, and
    broker statement format; `CSV Format` is derived from the service rather than locked to it.
- **Upload tags show real file types.** Each account card's blue tag now shows the actual file
  type(s) it accepts — **CSV**, **PDF** (Moneybox) or **XLSX** (eToro) — instead of the generic
  "Statement". Driven by `accountFileKinds`, and able to show more than one type per account.
- **Unified upload wizard.** Broker (eToro/Moneybox) imports now follow the **same two-step wizard**
  as bank CSVs: step 1 drop the file (format auto-detected from the account's Service — no format
  toggle), step 2 review then import. `StatementImportPanel` was split into reusable pieces
  (`StatementDropzone`, `StatementReview`, `useStatementImport`, `StatementReviewTable`); the
  Investments-page import modal composes them unchanged.

### Fixed — 2026-06-28 (Investments chart end point now matches the headline value)

- The **Value over time** chart's final (live) point now applies the broker-reported
  **units-held override**, so for auto-managed funds (e.g. Moneybox) the last point on the chart
  matches the headline **Current value** instead of the larger lot-summed figure. History stays
  transaction-derived; only today's point is reconciled. Same fix applied to the dashboard
  Investments sparkline. `valueSeries`/`valueSeriesByAccount` now accept an optional `overrides` map.

### Changed — 2026-06-28 (Per-account lines on the investments value chart)

- The Investments **Value over time** chart now draws a **separate line per account** when
  **All accounts** is selected (previously one combined line). Hovering shows a tooltip naming
  each account and its value at that point. Selecting a single account still shows its one line.
  Added `valueSeriesByAccount` and widened the chart palette to keep account lines distinct.

### Added — 2026-06-28 (eToro statement import)

- The investment **statement import** now reads **eToro** account statements (`.xlsx`) alongside
  Moneybox PDFs. A format toggle on the import panel (Investments modal and the Upload page) picks
  the broker; both feed the same review/confirm table. Each `Open Position` becomes a Buy lot and
  each `Position closed` a Sell, keyed by the eToro symbol; the native unit price is reconstructed
  as `amount ÷ units` (USD) and a statement-end USD→GBP rate is read from the Account Summary.
  The `.xlsx` is parsed entirely in the browser by a tiny dependency-free reader (no SheetJS) —
  `DecompressionStream` to unzip and `DOMParser` for the worksheet XML — so the file never leaves
  the device until lots are confirmed. The upload-page account badge for investment accounts now
  reads **Statement** rather than PDF.

### Fixed — 2026-06-28 (Stale UI lingering on soft refresh)

- A soft refresh could keep showing an **outdated build** (e.g. the dashboard instead of
  `/investments`, because the cached bundle pre-dated that route and the client router fell
  through to the `/*` catch-all). The app shell is already fetched network-first, but when a
  freshly-activated service worker took control of an already-loaded tab the page kept running
  the old cached bundles. It now **reloads once on `controllerchange`** so the new worker's build
  takes over immediately. Guarded against first-visit activation and reload loops.

### Fixed — 2026-06-28 (Dashboard investment-account balances)

- The dashboard's per-account balance tiles now show an **Investment account's holdings value**
  (honouring units-held overrides) instead of £0 — they were using the cash-transaction balance,
  which is always £0 for an investment account. Extracted the shared `accountCurrentBalance`
  helper so the dashboard tiles and the Accounts page compute balances identically.

### Added — 2026-06-28 (Units-held override for auto-managed funds)

- New optional **`Units Held`** field per asset (Investment Assets DB + the asset edit modal).
  For auto-managed/rebalanced accounts (e.g. Moneybox) whose statement transactions can't be
  summed back to the live position — switches and conversions don't appear as plain sells — set
  this from the statement's "Units held" and it becomes the **authoritative current unit count**
  for value, on the Investments page, Accounts balances and the dashboard. Cost basis is then the
  lot pool's average cost × the held units; blank keeps the previous lot-sum behaviour. Holdings
  rows using an override show a small `stmt` marker.

### Added — 2026-06-27 (Manage & delete assets)

- New **Assets** catalog on `/investments` listing every asset (held or not) with **Edit** and
  **Delete** actions — previously held-only assets were unreachable to edit and there was no way
  to remove one. Delete (`DELETE /api/investment-assets/:id`, archives the page) is **blocked with
  409 while trades still reference the asset**, so holdings are never orphaned.

### Changed — 2026-06-27 (Upload page = statement upload)

- The Upload page now handles **both** CSV (cash accounts) and **PDF statement import** (Investment
  accounts) — selecting an Investment account shows the Moneybox PDF import in place of the CSV
  dropzone (reusing the same `StatementImportPanel` as the Investments page). Renamed "Import
  transactions" → **Statement upload**.
- Each account card on the upload page shows a **format badge** (CSV / PDF) for what it accepts.

### Added — 2026-06-27 (Moneybox statement import)

- **Import trades from a Moneybox S&S ISA PDF statement** — an "Import statement" action on
  `/investments` parses the statement's transaction lines into lots (date, Buy/Sell, units,
  ISIN, native price, FX→GBP, fee). Parsing runs entirely client-side (`pdfjs-dist`,
  lazy-loaded); the PDF is never uploaded until trades are confirmed.
- Trades are **matched to assets by ISIN** (new assets offered for creation) and
  **de-duplicated** against existing lots, so re-importing a statement doesn't double-count.
  A review table lets you tick/untick rows (duplicates start unchecked) before importing.
- New `POST /api/investment-lots/bulk` creates the selected lots in one request
  (per-row validated, visibility-guarded, 207 on partial failure).

### Added — 2026-06-27 (Investments: trade history & delete)

- Clicking a holdings row opens a **trade-history modal** for that asset (every Buy/Sell, with
  a per-trade total value column) and lets you **delete a trade** (`DELETE
  /api/investment-lots/:id`, archives the lot, visibility-guarded).
- Toast notifications moved to the **bottom-right**.

### Added — 2026-06-27 (Dedicated Accounts page)

- New top-level **Accounts** page (`/accounts`) for managing accounts: add, edit, and
  **archive** (soft-delete via the new `DELETE /api/accounts/:id`, viewer-visibility
  guarded — transactions reference accounts so it never hard-deletes). Accounts are
  grouped by type with **current balances** (an Investment account shows its holdings
  market value and the assets it holds) and Shared/Personal badges.
- Account management **moved out of Settings** — the Settings → Accounts tab is gone and
  `/settings/accounts` redirects to `/accounts`.
- **Asset ↔ account association** surfaced both ways: the Investments holdings table now
  shows which accounts hold each asset (`accountsHoldingAsset`), and each Investment
  account on the Accounts page lists the assets it holds.

### Added — 2026-06-27 (Investment & savings tracking)

- New **Investments** page (`/investments`) and dashboard card for holdings-level
  portfolio tracking of Investment accounts (e.g. Moneybox S&S ISA, eToro). Records
  **lot-level** buys/sells, an asset's **dated price history**, and reconstructs
  account/portfolio **value over time** (the app's first chart) from units-held-then ×
  price-then. Cost basis uses **Section 104 average-cost pooling**; unrealised gain is
  shown per asset and in total.
- **Multi-currency**: every price and lot carries an `FX Rate to GBP`, so non-GBP
  holdings (e.g. USD on eToro) fold into the GBP total at the rate that applied — no
  separate FX table needed.
- Three new Notion databases (`Investment Assets`, `Asset Prices`, `Investment Lots`)
  with env vars `NOTION_INVESTMENT_ASSETS_DB_ID`, `NOTION_ASSET_PRICES_DB_ID`,
  `NOTION_INVESTMENT_LOTS_DB_ID` (also wired into the HA add-on config). Assets carry an
  `Owner` for member privacy; lots inherit their account's visibility; prices are gated
  by the parent asset.
- New pure modules `app/src/client/investments/{holdings,savingsTrend,portfolio}.ts`
  (+ tests), the reusable dark-mode-aware `components/ui/LineChartCard` (lazy recharts),
  and `hooks/useColorScheme`. Manual prices only in v1 (a price feed and the savings
  cash-trend overlay are reserved for later).

### Changed — 2026-06-25 (Persistent auth sessions across tabs)

- The auth token/user now live in `localStorage` instead of `sessionStorage`, so
  opening a second browser tab reuses the existing session (and it survives a
  browser restart) rather than forcing a fresh login. A `storage`-event listener
  in `AuthProvider` keeps open tabs in sync on login/logout.
- Server sessions gained a **sliding two-week expiry**: each record is now
  `{ user, expiresAt }`, and every authenticated request (`requireAuth`/`GET /me`)
  runs `touchSession` to reject expired tokens and slide the window to `now + 14
  days`. The in-memory window advances per request; the disk write is throttled to
  once an hour (`SESSION_REFRESH_MS`). `loadSessions` drops expired entries and
  migrates legacy token → user-name strings on startup.

### Added — 2026-06-22 (Per-page browser tab titles)

- The browser tab title now reflects the current page, e.g. "Bills - BudgetPilot",
  "Transactions - BudgetPilot". Driven centrally from the route in `App` via a pure
  `documentTitleForPath` helper (`client/lib/pageTitle.ts`); names mirror the
  sidebar labels, with `/` and unknown paths defaulting to Dashboard.

### Added — 2026-06-22 (Dashboard month navigation)

- The dashboard's previously-inert ‹ month button now works: **‹ prev / next ›**
  buttons step a viewed month that drives the period-scoped cards (StatStrip,
  Spending by category, N/W/S, carry-forward, Shared bills). Forward is hidden at
  the current month (no navigating the future). Account balances and the
  reconciliation nudge stay anchored to "now". New `nextMonth`/`friendlyMonthYear`
  helpers. Also removed the unused `PagePlaceholder` component.

### Changed — 2026-06-22 (Dashboard nudges last month's reconciliation)

- Removed the dashboard header's "X of N accounts reconciled" line. In its place,
  the current month shows an **amber warning** (linking to `/reconcile`) when the
  **previous** month still has accounts with activity that weren't reconciled —
  judged from persisted records (`Reconciled`/`Accepted`) so a past month isn't
  mis-flagged by its since-moved-on live balance. New pure `unreconciledAccounts`
  helper. Account activity is bounded to the month, so a user who started in June
  isn't nagged to reconcile May. The warning persists until reconciled.

### Changed — 2026-06-22 (Fold credit-card repayments into Account balances)

- The standalone dashboard **Credit card** card is removed. Each **Credit Card**
  tile in **Account balances** now has a hover ⓘ hint showing that card's
  **Outstanding**, **Pending**, and outstanding-purchase count (same
  `repaymentSummary` data). `InfoHint` accepts rich content for this.

### Changed — 2026-06-22 (Merge the two upcoming-bills cards)

- The dashboard's separate **Upcoming bills** (Monthly) and **Upcoming annual
  costs** (Quarterly/Yearly) cards are now a single **Upcoming bills** card
  covering all frequencies, soonest-first, with a frequency-aware amber window
  (Monthly within 7 days, Quarterly/Yearly within 30). Its **View all** link goes
  to `/bills` (unfiltered). Removed the dead `UpcomingCosts` component and
  `annual/upcoming.ts` (`upcomingCosts`) helper.

### Added — 2026-06-22 (Info hints on dashboard & transactions tiles)

- Every dashboard `StatStrip` tile (Monthly income, Spending, Committed bills,
  Free to spend) and every Transactions-page summary cell (Income, Spending,
  Transfers, Net) now has a hover ⓘ **info balloon** explaining in plain English
  how the figure is worked out — including that "income" is *all* personal
  money-in (salary, refunds, interest…), not just salary. New reusable
  `InfoHint` component (`components/ui/InfoHint.tsx`) over the `Tooltip` primitive.

### Fixed — 2026-06-22 (Stale UI on refresh + re-login after restart)

- **Soft refresh no longer loads an old UI build.** The service worker was
  cache-first on the HTML shell with a constant cache name, so it kept serving a
  stale `index.html` pointing at old bundles. It is now **network-first for
  navigations** (cache only as an offline fallback), API/health are never cached,
  and hashed assets stay cache-first; `CACHE_NAME` bumped to purge old caches.
- **Server restarts/deploys no longer force a re-login.** Auth sessions now
  **persist to disk** (`sessions-store.ts`, `BP_SESSIONS_FILE`, default
  `app/data/sessions.json` / `/data/sessions.json` in the add-on) instead of
  living only in an in-memory Map. The client also handles a `401` by clearing
  the stale token and redirecting to `/login` rather than showing an empty
  "authenticated" screen.

### Changed — 2026-06-22 (Per-user settings: split ratio, reconcile tolerance, finance model)

- The **household split ratio** card is shown relative to the logged-in member —
  the manual input edits the viewer's own share (the partner sees/edits the
  complement, e.g. `42% to Ugnė`) and the read-out lists the viewer first. The
  stored value is unchanged; only the presentation flips.
- **Reconciliation tolerance is now per-member** (`reconcileTolerancePounds`
  became `Record<'Juozas'|'Partner', number>`). Each member sets their own; the
  Reconcile page and dashboard read the viewer's slot. Legacy single-number
  stores migrate on read.
- The **finance model** is now **admin-only**: hidden from non-admins in Settings
  and rejected with `403` server-side if a non-admin tries to change it.

### Changed — 2026-06-22 (Shared bills card reads category budgets)

- The dashboard **Shared bills** card now works out the **Monthly** shared total
  and **Your share** from the **Joint categories' effective budgets** for the
  month rather than from the bills alone. Bills feed some of those category
  budgets, but a category's manual buffer captures the rest — so the figure is a
  fuller measure of shared monthly spend and now reconciles with the Spending-by-
  category **Shared** segment's budget total. New pure helper
  `sharedBudgetForMonth` (`budget/effectiveBudget.ts`). The **Shared bills** count
  still reflects the number of Joint bills.

### Added — 2026-06-22 (Import another from the success screen)

- The CSV import **success screen** now offers an **Import another** action
  alongside **View transactions** and **Back to dashboard**. It resets the upload
  wizard back to the file-drop step in place (keeping the selected account) so a
  second statement can be imported without leaving the page.

### Removed — 2026-06-22 (Retire the Annual Commitments database)

- The **Annual Commitments** Notion database is gone — it overlapped entirely
  with Quarterly/Yearly bills in the Shared Bills Register (the same subscription
  could live in both and duplicate on the dashboard). The whole data path is
  removed: the `AnnualCommitment` type, `parseAnnualCommitment`,
  `getAnnualCommitments`, the `GET /annual` route, the `fetchAnnualCommitments`
  client fetcher, the `useAnnual` hook, `upcomingCommitments`, and the
  `NOTION_ANNUAL_DB_ID` env var (dropped from `.env.example` and the HA add-on).
- The dashboard **Upcoming annual costs** card (`UpcomingCosts`) now lists
  **Quarterly/Yearly bills only**; `upcomingCosts(bills, today, limit)` no longer
  takes commitments. Behaviour is otherwise unchanged (amber within 30 days).
- The data model is now **9 Notion databases** (was 10).

### Fixed — 2026-06-22 (Dismissed transfer suggestions stay dismissed)

- The transfer-detection banner kept resurfacing the same suggestion after every
  page reload because the dismissal lived in transient component state. Dismissals
  now persist in `localStorage` (`bp.dismissedTransfers`) keyed by the pair's two
  transaction ids (`pairKey`). Dismissing the banner, or marking a pair "Not a
  transfer" in the review modal, is remembered across reloads and month navigation.

### Fixed — 2026-06-21 (HA add-on container start)

- The HA add-on Docker image started and immediately crashed with
  `Cannot find module '../../budget/temporal.js'` — the runtime stage copied
  `src/server` and `src/shared` but not `src/budget` (`valueAt`), which the
  routes import at runtime. The Dockerfile now copies `src/budget` too; the
  container boots and serves on port 3000.

### Fixed — 2026-06-21 (No "-£0" for zero balances)

- A value that rounds to zero (a tiny negative float residual, or `-0`) no longer
  renders with a minus sign — `gbp`/`gbpWhole` normalise it to `£0`, so e.g. an
  account balance that nets to zero shows `£0`, not `-£0`.

### Fixed — 2026-06-21 (Credit-card refunds are settle-able repayment items)

- **Credit-card refunds now offset the outstanding balance via the settlement
  flow.** A refund on a card is an inflow, so it never carried a repayment badge
  and was ignored by the outstanding total — overstating the debt. A credit-card
  inflow that isn't a transfer, settlement payment, or filed under `Transfers`
  (how a bank repayment is categorised) is now a **refund repayment item**
  (`isCreditCardRefund`): it carries the same derived Outstanding/Pending/Settled
  state as a purchase (opposite sign) and can be **settled by a payment**. The
  maths nets by sign — `repaymentSummary.outstandingTotal` =
  `Σ(outstanding purchases) − Σ(outstanding refunds)` (dashboard Credit card →
  Outstanding £), the **Settle** modal lists refunds alongside purchases and
  `settlementTally` nets the covered set against the payment (a £70 repayment
  reconciles a £100 purchase plus a £30 refund), and the Transactions
  **Outstanding** filter includes refunds so the footer total reflects the true
  amount left to repay. A refund settled into a repayment drops out (Settled)
  with the purchases it offset.

### Added — 2026-06-21 (Removed-at-the-bank detection on import)

- **Imports now flag previously-imported transactions that vanished from a fresh
  export** — i.e. removed or reversed at the bank (a refunded/cancelled charge).
  `detectRemovedTransactions` compares by `Bank Transaction ID`, scoped to the
  target account and the file's date range (so out-of-window rows aren't
  mistaken for removals) and skipping soft-deleted rows; it detects nothing when
  the file carries no bank ids. The review screen lists each missing row with an
  **Archive N removed** button (a user-confirmed soft-delete) — never an
  automatic deletion, so a partial/filtered CSV can't wipe real rows.

### Added — 2026-06-21 (Bank-transaction-ID change detection on import)

- **Imports now recognise an already-imported transaction that changed at the
  bank** (the classic Monzo *pending → settled* case, where a £67.99 hold
  settles to £51.99). Previously the content-based dedup (date|amount|
  description) treated the settled row as brand-new and left the stale one
  behind — silently inflating spend and throwing off the account balance.
- The Monzo parser now captures the stable **`Transaction ID`**, stored on each
  transaction as `Bank Transaction ID`. On re-import, rows are classified by
  identity (`classifyImport`): a matching id with changed amount/date/description
  is flagged **Changed** in review (amber "↻ updates existing", old→new amount)
  and **updates the existing row in place** instead of inserting a duplicate;
  unchanged matches skip; everything else falls back to content dedup. The
  import result now reports `{ created, updated, skipped }`.
- **Notion schema:** add a **`Bank Transaction ID`** text column to the
  Transactions database. Without it, change detection degrades gracefully to the
  previous content-only dedup.

### Fixed — 2026-06-21 (Account-based transaction visibility & balances)

- **Account balances now reconcile with the real bank balance.** Transaction
  visibility is now dictated by the **account** a transaction was made from, not
  the row's split: a shared (Joint) account shows *all* its transactions to both
  members, a personal account only to its owner (`transactionVisibleTo`,
  reusing `accountVisibleTo`). Previously the partner's personal spend paid from
  a shared account was filtered out of your view and silently dropped from the
  account balance, so a Joint card could read far below the actual balance.
- **Privacy consequence:** a member's personal transactions *on a shared
  account* are now mutually visible (they're on a shared account); personal
  spend on personal accounts stays private.
- **"Your spend" stays yours:** because the partner's personal-on-shared rows
  now reach the client, the Needs/Wants/Savings card, Spending-by-category
  Personal segment, the StatStrip Spending/Income tiles and the Transactions
  personal strip attribute personal rows by `importedBy === me`, so a partner's
  personal spend on a shared account isn't counted as yours.

### Fixed — 2026-06-21 (Refunds offset category spend)

- **Spending by category** and the **Needs/Wants/Savings** card now **net
  refunds** against the spend they reverse: a positive amount in a spend
  category (e.g. a £5 club fee refunded the same day) offsets the matching
  outflow, so "Spent" reads £0 and reconciles with the Transactions footer
  total. Previously both summed outflows only and ignored every positive amount,
  so a refunded fee still showed as spent. `spendByCategory` and `nwsActuals`
  now net signed amounts; the StatStrip "Spending" tile follows automatically.

### Added — 2026-06-21 (Clickable Spending-by-category rows)

- **Dashboard → Spending by category** rows are now clickable: hovering
  highlights the full row with a pointer cursor, and clicking deep-links to the
  Transactions page pre-filtered to the same Personal/Shared segment (split) and
  that category. `filtersFromParams` now also honours `category` and `split` URL
  params alongside the existing `account`/`repayment`.

### Added — 2026-06-20 (Effective-dated budgets & bill costs)

- **Category budgets and bill costs are now effective-dated**, so history is
  retained: looking back at a past month shows the budget/cost that applied
  *then*, not today's. Backed by a new **Budget Change Log** Notion DB
  (`NOTION_BUDGET_LOG_DB_ID`) of `(Type, Category/Bill relation, Effective From
  month, Amount, Note)` rows; the current value is denormalised onto each
  category (`Monthly Target`) and bill (`Total Amount`) and re-synced on every
  change. Future-dated entries are supported (a change only bites from its month).
- **Bills link to categories via a real `Category Link` relation**
  (`Bill.categoryId`); a category's budget is always **Σ(linked bills) + buffer**,
  with the bills reverse-looked-up by that relation (no toggle). Each bill is
  smoothed to its monthly-equivalent (Monthly in full, Quarterly ÷3, Yearly ÷12)
  so an annual charge spreads evenly across the year rather than spiking in its
  due month. A category with no linked bills is just its buffer (a plain budget).
- **UI:** `BillModal` gained a shared `BudgetHistory` editor for effective-dated
  cost changes (timeline + add/edit/delete with an effective month). `CategoryModal`
  shows a **Derived from bills / Buffer / Total budget** breakdown with an editable
  buffer (no checkbox). The dashboard **Spending by category** card shows each
  category's month-effective budget and now lists budgeted categories even with
  zero spend in the segment.
- **Migration:** `bun run --cwd app migrate:budget-log` seeds a genesis entry per
  category/bill (current value, effective from the earliest transaction month) and
  converts each bill's legacy `Category` select to the new relation. Idempotent.

### Added — 2026-06-20 (Link accounts to bills)

- **Bills now link to a paying account.** Each bill carries an optional `Account`
  relation (`Bill.accountId`). A "Paid from account" picker was added to
  `BillModal`, the Bills table gained an **Account** column (between Category and
  Scope), and `BillsFilterBar` gained an **Account** filter (any account, "No
  account", or a specific account). Backed by a new `Account` relation on the
  Shared Bills Register Notion DB; legacy rows parse to `accountId: null`. The
  link is descriptive only — no bill-owner/account-owner matching is enforced.

### Changed — 2026-06-20 (Dashboard & settings feedback)

- **Account balance cards** now sort by type — Current Account → Credit Card →
  Savings → Investment → untyped — then alphabetically by name within each type
  (new pure helper `dashboard/accountSort.ts`).
- **Credit card card** shows a **Balance** figure (opening balance ± transactions)
  alongside Outstanding and Pending on one three-column row.
- **Upcoming bills** / **Upcoming annual costs** cards gained a header **View →**
  link to the Bills page (`/bills?frequency=Monthly` / `/bills?frequency=Yearly`).
  The Bills page now seeds its filters from URL query params via
  `billFiltersFromParams`.
- **Household settings tab** renders the split-ratio and Needs/Wants/Savings
  cards side by side in an equal-height two-column grid, above the Reconciliation
  tolerance card. The split-ratio control's percentage slider was removed —
  manual mode now uses a single number input.

### Added — 2026-06-19 (Personal vs shared accounts)

- Accounts now carry an **`Owner`** (`Juozas`/`Partner`/`Joint`), mirroring
  Categories/Bills/Goals. `Joint` is a **shared/household** account visible to
  both members; a member-owned account is **personal and private** to that member.
  `GET /accounts` filters by the viewer server-side (`accountVisibleTo`), so a
  member never sees the other's personal accounts. Existing ownerless accounts
  default to `Joint` (visible to all) until an owner is assigned.
- The `AccountModal` replaces the "Shared / joint account" checkbox with a
  **Visibility** control (Shared/Personal); create/patch send a viewer-relative
  `'Me'`/`'Joint'` that the server resolves to the caller.
- `Account.shared` is now **derived** (`owner === 'Joint'`); the legacy Notion
  `Shared` checkbox is no longer read or written (an `Owner` select must be added
  to the Accounts database).

### Added — 2026-06-19 (Personal vs shared categories)

- Budget Categories now carry an **`Owner`** (`Juozas`/`Partner`/`Joint`). `Joint`
  is a **shared/household** category visible to both members; a member-owned
  category is **personal and private** to that member, **including its budget**.
  `GET /categories` filters by the viewer server-side (`categoryVisibleTo`), so a
  member never receives the other's personal categories. Existing ownerless
  categories default to `Joint` (unchanged behaviour).
- The category modals (Settings + inline upload) gained a **Visibility** control
  (Shared/Personal); create/patch send a viewer-relative `'Me'`/`'Joint'` that the
  server resolves to the caller. The Settings categories list shows a
  Shared/Personal badge.
- **Split-aware category pickers:** assigning a category to a transaction now only
  offers categories valid for that row's split (`categoriesForSplit`) — a
  `Personal` transaction lists the viewer's own personal categories, a `Shared`
  one only `Joint` categories. Applies to the Add-transaction modal, the inline
  table select, and the CSV review rows; the inline upload **+ New category** modal
  defaults its visibility from the row's split.

### Added — 2026-06-19 (Count-up animation across pages + progress bars)

- Extended the count-up tween beyond the dashboard. `AnimatedNumber` now drives
  the headline figures in the **Transactions**, **Bills**, and **Goals** summary
  strips, plus the dashboard **GoalsCard** / **NeedsWantsSavings** sub-figures and
  the Goals-page **GoalCard** (saved £ and %). Table-row cells and minor sub-text
  stay static.
- The shared **`ProgressBar`** gained an opt-in `animate` prop: the fill now tweens
  on the same ease-out clock (0 → final on first reveal; current → new on change),
  snapping under `prefers-reduced-motion: reduce`. Enabled on the dashboard and
  Goals bars; live indicators (e.g. the import progress bar) keep their plain CSS
  transition.

### Added — 2026-06-16 (Dashboard count-up number animation)

- The dashboard's headline money figures now **count up from `0` to their final
  value** over a smooth ~0.6s ease-out-cubic tween once data has loaded, and tween
  from the currently-displayed value → the new value on later changes (month nav,
  refetch) rather than re-running from 0. Snaps straight to the value under
  `prefers-reduced-motion: reduce`. New `client/hooks/useCountUp.ts` (the RAF tween
  hook + tested pure helpers `easeOutCubic`/`frameValue`) and `client/components/ui/AnimatedNumber.tsx`
  (a fragment-rendering wrapper that inherits parent typography). Wired into the
  `StatStrip` four cells and `AccountBalances`; dashboard-only scope.

### Changed — 2026-06-16 (Softer pastel toast styling)

- Toast notifications now use **soft pastel surfaces** with gentle, readable text
  (and a dark-mode variant) instead of the default saturated colored theme —
  easier on the eyes. The countdown **progress bar is hidden**. Restyled via
  scoped `.Toastify__*` overrides in `client/index.css`; the container switched
  to `theme="light"` with `hideProgressBar`.

### Fixed — 2026-06-16 (Bulk transaction ops: attempt every row, report partial failures)

- A bulk transaction op (category/split/goal/delete) now **attempts every
  selected row** instead of aborting on the first failure, and returns
  `{ updated, failed }` counts (HTTP 207 when any failed, else 200). The
  Transactions page shows a plain success toast only when nothing failed;
  otherwise a **persistent warning** ("N updated, M failed"), so a partial
  failure no longer reads as fully successful. New tested helper
  `client/transactions/bulkFeedback.ts`.

### Added — 2026-06-16 (Toast notifications + busy-state buttons)

- Global toast notifications for background operations (success and failure), via
  a React Query `MutationCache` + `react-toastify`. Failed mutations always
  surface an error toast (no auto-dismiss); meaningful writes confirm with a
  success toast. Components that render their own inline error (add/edit/delete
  modals, the import wizard) suppress the duplicate global error toast. Bulk-action
  buttons on the Transactions page are disabled while their operation runs.

### Changed — 2026-06-16 (Spending by category: NWS-type pills + type-grouped sort)

- The dashboard **Spending by category** table now shows a colour-coded NWS-type
  pill next to each category name — Needs **indigo**, Wants **amber**, Savings
  **green** (grey for an untyped category). Rows are grouped by type in
  Needs → Wants → Savings order, then alphabetically within each type. Applies to
  both the Personal and Shared segments. New pure helper
  `client/dashboard/nwsType.ts` (`nwsTypeRank`/`nwsTypeTone`) with tests.

### Changed — 2026-06-16 (Dashboard Spending tile is one viewer total)

- The dashboard `StatStrip` "Spending" tile no longer shows a two-up Personal |
  Shared breakdown. It is now a single **your spend** figure — your personal
  spend in full plus your share of shared spend (`personalSpend + sharedSpend ×
  shareFraction`, the same viewer share the N/W/S card uses) — so it answers
  "how much have I spent this month". It now reconciles with the N/W/S card's
  £ actuals rather than the full-shared "Spending by category" total. (Restores
  WIP that had been stranded in a stash and never merged.)

### Changed — 2026-06-16 (Settle modal: Pending-only candidates + scope; Outstanding default restored)

- The settle-purchases modal now lists **only same-account purchases marked
  `Pending`** (plus any rows the payment already covers, so editing an existing
  settlement still works), and each candidate row shows its **scope**
  (Personal/Shared). `settlementCandidates` gained the Pending filter; the
  Personal/Shared `SplitBadge` was extracted from `TransactionRow` into a shared
  component. This gives a clear lifecycle: mark a purchase `Pending` when you
  repay it, then settle the payment against it.
- A credit-card purchase once again **defaults to Outstanding** ("still owed").
  The state is **derived** (not written at import), so every unmarked purchase
  counts as outstanding again — partially reverting the prior "explicit, never
  auto-Outstanding" change. `Pending` stays an explicit, user-set state and
  `Settled` is still derived from settlement links and takes precedence. "Clear
  status" now returns a purchase to the derived Outstanding default.

### Changed — 2026-06-16 (Repayment state is now explicit, never auto-Outstanding)

- A newly-imported credit-card purchase was treated as **Outstanding** by
  default (any unsettled, non-pending purchase). Outstanding is now an
  **explicit, user-set** state: a purchase has **no** repayment state until you
  mark it. The `Repayment Pending` checkbox is replaced by a single
  **`Repayment Status`** Notion select (`Outstanding` / `Pending`; blank =
  none); `Settled` stays derived from settlement links and takes precedence. The
  `BulkActionBar` now offers **Mark outstanding · Mark pending · Clear status**
  (one `repayment` bulk op), the Settle modal pre-selects `Pending` purchases and
  clears their stored status once covered, and the dashboard Credit-card card /
  Repayment filter / row badges count only explicitly-marked purchases. Requires
  adding the `Repayment Status` select in Notion (options `Outstanding`,
  `Pending`); migrate rows where `Repayment Pending = true` → `Repayment Status =
  Pending`.

### Fixed — 2026-06-15 (Manual transactions: direction control for the amount sign)

- A manually-added credit-card purchase entered with a positive amount was read
  as money *in*, so it never qualified as a purchase (`amount < 0`) and showed no
  Outstanding/Pending repayment badge even after "Mark pending". The **Add
  transaction** modal now has an explicit **Direction** control (Money out /
  Money in, default Money out) and an unsigned amount field; the sign is applied
  via a new pure `toSignedAmount` helper, so purchases are stored negative and
  track correctly. Removes the error-prone "negative = money out" typed-sign
  requirement.

### Fixed — 2026-06-15 (Goal saved-amount sign for savings contributions)

- A goal's saved amount was computed with the wrong sign. Contributions are
  recorded as transfers **out** of an account (e.g. "Transfer to Revolut") — a
  negative amount — but `goalContributions` first summed `|amount|` (so a
  withdrawal grew the goal) and then summed the raw signed amount (so
  contributions *reduced* the goal: the Emergency Fund showed £578.76 instead of
  £876.76 for £727.76 + £149). It now **negates** the signed amount — money out
  of an account adds to the goal, money coming back in subtracts — fixing both
  the inverted balance and the original withdrawal case. The goal-card
  contributions subtext remains sign-aware.

### Added — 2026-06-15 (Per-member income in Settings)

- New per-viewer **"Your income"** card in the Household tab — always available
  (no longer gated behind "From income" split mode) and each member can set only
  their own income. Switching the split to income-based now requires both
  members' incomes to be set: the toggle is blocked with a message naming
  whoever is missing (keeping ratio-based split), enforced client- and
  server-side. Income anchors the viewer's Needs/Wants/Savings card to "% of
  income" and feeds the household split; it is distinct from the dashboard
  "Monthly income" tile (actual transaction money-in).

### Added — 2026-06-15 (Credit-card repayment tracking)

- Credit-card repayment tracking: Outstanding/Pending/Settled state for credit-card purchases. New `Repayment Pending` flag, a Repayment filter and per-row badges on the Transactions page, a "Mark pending" bulk action, Settle-modal pre-selection of pending purchases, and a "Credit card" dashboard card summarising outstanding/pending balances.

### Fixed — 2026-06-14 (Annual Commitments query sort property)

- `getAnnualCommitments()` sorted the Annual Commitments database by a
  non-existent `Date` property, so `GET /annual` (the dashboard "Upcoming annual
  costs" card) failed with a Notion `validation_error`. Sort by `Due Date`, the
  database's actual date field.

### Changed — 2026-06-14 (Dashboard Goals card now sorted)

- The dashboard **Goals card** now sorts its goals instead of showing them in
  Notion's arbitrary order. It reuses the Goals page's `sortGoals`: status first
  (Active → Paused), then soonest due date (undated last), then priority. Status
  leads so an undated Active goal still ranks above a dated Paused one.

### Changed — 2026-06-14 (Bills: due dates for all frequencies + dashboard card routing)

- Bills can now carry a due-date anchor for **any** frequency (not just
  Quarterly/Yearly). `BillModal` shows the date input for Monthly too, and the
  server persists it (`nextDueDate` rolls Monthly/Quarterly/Yearly anchors by
  1/3/12 months; undated bills return null).
- The dashboard **Upcoming bills** card now lists **Monthly** bills only and
  turns the date badge amber within **7 days**.
- The dashboard **Upcoming annual costs** card now merges **Quarterly/Yearly
  bills** with Active annual commitments (new `upcomingCosts` helper in
  `annual/upcoming.ts`), self-fetching its data via `useBills()` + `useAnnual()`,
  with amber badges within **30 days**.

### Added — 2026-06-14 (Spending by category: exact-amount hover balloons)

- Hovering any money figure in the dashboard "Spending by category" table (Budget
  / Spent / Left, in both the rows and the Total footer) now shows a balloon with
  the exact amount to the penny. The cells still display rounded whole pounds.

### Changed — 2026-06-14 (Dashboard: Monthly income is now the viewer's)

- The dashboard "Monthly income" tile now shows the **viewer's** income for the
  selected month — actual money-in from the month's (privacy-filtered)
  transactions, personal view (shared-account income dropped to avoid
  double-counting) — instead of the combined household `budget.netIncome`.
- "Free to spend" now uses that same viewer income (`viewerIncome − committed
  bills ± carry-forward`), so it pairs the viewer's income with the viewer's
  bills rather than mixing household income with personal bills.

### Changed — 2026-06-14 (Goals: sort Active first + estimated completion date)

- The Goals page now sorts **Active goals to the front**, then Paused, then
  Achieved (`sortGoals` gained a status-rank primary key; date + priority remain
  the tie-breakers).
- Goal cards with a target amount and a monthly contribution but **no target
  date** now show an `Est. completion: Mon YYYY` line, projected from the
  remaining gap at the current contribution (new pure `estimatedCompletionDate`).

### Changed — 2026-06-14 (N/W/S now reconciles with the dashboard Spending tile)

- The "Needs / Wants / Savings" card total and the `StatStrip` "Spending" tile's
  Personal figure are now computed on the same basis, so they always match. Both
  are driven by each transaction's **scope (`Split`)** — a `Shared` row never
  counts toward N/W/S (even on a personal account like a credit card), a
  `Personal` row always does — and by **category**, not the `isTransfer` flag:
  a savings top-up categorised as a Saving type counts as savings/spend, while a
  pure internal movement categorised `Transfers` is excluded from both.
- `nwsActuals` dropped its account-shared + `importedBy` filtering in favour of
  the `Split === 'Personal'` rule; `spendByCategory`/`segmentSpendTotal` now take
  a `transfersCategoryId` and exclude that category instead of skipping
  `isTransfer` legs. The Transactions-page Income/Spending/Net strip
  (`monthSummary`) is unchanged — it stays a pure cash-flow view.

### Added — 2026-06-14 (Dashboard hover tooltips: Spending by category + N/W/S)

- "Spending by category" rows now show a hover tooltip with each category's type
  and monthly budget (same `Tooltip` + `categoryTooltipContent` as the Bills and
  Transactions tables). The "Needs / Wants / Savings" gauges now show a hover
  balloon with that bucket's spend in pounds.

### Changed — 2026-06-14 (Upcoming bills: due-soon highlight)

- The dashboard "Upcoming bills" card now shows each due-date badge in amber only
  when the bill is due within 30 days; further-out bills use a muted gray badge
  that blends into the card. Backed by a new shared `daysUntil` date helper (also
  now used by the Bills table row).

### Added — 2026-06-14 (Totals footer: Bills + Transactions tables)

- The Bills and Transactions tables now end with a bold **Total** footer row
  (like the dashboard "Spending by category" table), reflecting the currently
  filtered/sorted rows. Bills sums the Total / Your share / Partner share columns
  (with ≈/mo monthly-equivalent subtotals when a non-monthly bill is shown) plus
  a bill count; Transactions nets the displayed single-row amounts (transfers
  excluded) plus a transaction count. Backed by pure `billsTableTotals` and
  `displayRowsTotal` helpers.

### Added — 2026-06-14 (Category tooltip: Bills + Transactions)

- Hovering a category in the Bills table (badge) or the Transactions table
  (select) now shows a tooltip with the matched Budget Category's type
  (Need/Want/Saving) and monthly budget. Built on a new reusable `Tooltip` UI
  primitive — portal-rendered (so it's never clipped by the table), appearing
  instantly and fading in over 400ms — with shared `categoryTooltipContent`.

### Added — 2026-06-14 (Bill due dates)

- Bill due dates: Quarterly/Yearly bills carry a Due Date anchor that auto-rolls to the next occurrence. Shown as a sortable "Next due" column in the Bills table, editable in the bill modal, and surfaced on a new dashboard "Upcoming bills" card.

### Added — 2026-06-14 (Upload: duplicate preview in review step)

- The CSV review step now flags rows that already exist in Notion. Duplicates
  (matched on date + amount + description, the same `dedupKey` the server skips
  on) render greyed-out with an "already imported" badge, don't need a category,
  and are excluded from the import. A duplicate count shows in the review
  summary. `dedupKey` is now shared between client and server
  (`app/src/shared/dedup.ts`).

### Changed — 2026-06-14 (Dashboard: Spending split into Personal | Shared)

- The dashboard StatStrip's spending tile no longer shows a single combined
  total. It now shows **Personal | Shared** side by side, keyed off each
  transaction's `split` and summed over the same typed categories as the
  "Spending by category" breakdown — so the tile's Personal figure reconciles
  with that table's total. Backed by a new `segmentSpendTotal` helper.

### Changed — 2026-06-14 (Drop category "shared"; transaction split is the sole scope signal)

- Removed the **shared** attribute from Budget Categories. Shared-vs-personal is
  now determined **solely** by each transaction's `Split` (Shared/Personal).
  `Category.shared` is gone from the type, parser, create/update inputs +
  validation, and the Notion `Shared?` column is no longer read or written
  (legacy). The "Shared category" toggle was removed from both the Settings
  category modal and the inline upload AddCategoryModal.
- At CSV import, a row's split now **defaults from the target account's `Shared`
  flag** (shared/joint account → `Shared`, otherwise `Personal`) instead of the
  category's old shared flag — still per-row overridable in review.
- Renamed the Transactions table **"Split" column → "Scope"** (and the filter's
  "Shared / personal" label → "Scope") for consistency with the Bills page.

### Changed — 2026-06-13 (Settings: category "None" type)

- The category **Type** dropdown now offers a **None** option (alongside
  Need/Want/Saving). Saving clears the Notion `Type` select; untyped categories
  fall out of the Needs/Wants/Savings computation, as intended.

### Added — 2026-06-13 (Goals ↔ savings-transaction linking)

- Savings goals now track the transactions that fund them. A goal declares an
  **Owner** (Me/Joint) and **Funding Accounts**; each transaction gains a `Goal`
  relation. At CSV import, a **Saving-type** row from a goal's funding account is
  auto-tagged to that goal (only when the account funds a single Active goal —
  ambiguous accounts are left for manual tagging). On the Transactions page,
  select rows → **🎯 Assign to goal** to set/clear the tag (overrides, backfill,
  or split same-account savings across goals); tagged rows show a 🎯 badge.
- A goal's progress is now **starting balance + Σ tagged Saving-type
  contributions** (the old "Current Amount" is relabelled **Starting balance**).
  A met-but-still-Active goal keeps counting and shows the overshoot (e.g.
  £120/£100) with the bar capped at 100%. Goal cards show the saved amount and a
  `+£X from N savings transactions` subtext.
- **Personal vs Shared goals** mirror Bills: a Shared (Joint) goal links only
  shared accounts and is visible to everyone; a Personal goal links only
  non-shared accounts and is **private to its owner** (`GET /goals` is now
  member-privacy-filtered; `PATCH`/`DELETE` 404 the other member's personal
  goal). Funding-account eligibility is validated server-side.

### Added — 2026-06-13 (Same-account settlement links)

- Link a single same-account **payment** (e.g. a credit-card repayment) to the
  earlier **purchases** it covers. Select the payment row → **🧾 Settle
  purchases** → tick the same-account purchases, with a live reconciliation tally
  (Σ covered £ vs payment £, ✓/⚠). The payment drops out of income/spending while
  the purchases keep counting as spending — unlike a cross-account transfer, which
  drops both legs. Backed by a new `Settles` one-way self-relation on the
  Transactions database (`Transaction.settlesIds`) and `POST
  /transactions/:id/settle | settle-clear` (same-account enforced server-side).
  Manual only; 1-month lookback.

### Changed — 2026-06-13 (Dashboard committed bills)

- The dashboard StatStrip now reads **Monthly income · Total spent · Committed
  bills · Free to spend**. "Committed bills" is your smoothed monthly bill share
  (your portion of joint bills + your personal bills); "Free to spend" is
  income − committed bills (± last month's carry-forward). Committed bills are
  kept separate from the transaction-derived "Total spent" so a bill you've paid
  and imported isn't counted twice. (Replaces the old "Remaining" and "Shared
  bills" tiles; bill detail still lives in the Shared bills card below.)

### Added — 2026-06-13 (Bill icons)

- Bills can now carry an optional **emoji icon**, shown next to the bill name in
  the Bills table. Set it in the add/edit modal via a text field or a row of
  quick-pick suggestions (🏠 💡 💧 📶 …). Backed by a new `Icon` rich_text
  property on the Shared Bills Register; blank/legacy rows show no icon.

### Added — 2026-06-13 (HA add-on Web UI button)

- `ha-addon/config.yaml` now declares `webui:`, so the Home Assistant Supervisor
  shows an **Open Web UI** button on the add-on page. (Surfacing the app in HA's
  navigation sidebar needs `ingress`, which is deferred — see CLAUDE.md.)

### Added — 2026-06-13 (Favicon)

- Added an SVG favicon (paper-plane mark on the indigo brand colour) wired into
  `index.html`, so browser tabs no longer show a blank icon.

### Changed — 2026-06-13 (Makefile)

- `make bump-version` now includes the new version number in the commit message
  (e.g. `Bump version to 1.2.3`).

### Added — 2026-06-13 (Goal target estimate)

- A goal with no explicit target now shows an **estimated** target — what you'll
  have saved by the target date at the current monthly contribution
  (`current + monthly × months remaining`). The card marks it `~£X (est.)`, and the
  progress bar / amount-remaining measure against it. Goals with neither a future
  date nor a contribution show "No target set".

### Fixed — 2026-06-12 (Sidebar polish)

- Collapsed-sidebar icons are now properly centered (the hidden labels no longer
  reserve horizontal space).
- The app version sits inline beneath the user name in the account row instead of
  on a separate line.

### Added — 2026-06-12 (Transactions UX)

- The Transactions table now has a **Split** column showing whether each row is
  Personal or Shared.
- Clicking anywhere on a transaction row (except the Category dropdown) toggles its
  selection checkbox; a header checkbox selects/clears all rows at once.

### Changed — 2026-06-12 (Auto Needs/Wants/Savings)

- The dashboard Needs/Wants/Savings gauges are now computed live from your
  transactions — your spend in your own (non-shared) accounts, classified by each
  category's Need/Want/Saving Type — instead of hand-entered Notion fields.
- Transfers into savings/investments and into the joint account count when the
  category is typed; spending from the shared account is excluded.
- Needs/Wants/Savings targets are configurable per member in Settings (default 50/30/20).

### Added — 2026-06-12

- Accounts have a **Shared / joint** flag, used to exclude joint-account spend from
  each member's Needs/Wants/Savings.

### Changed — 2026-06-12 (Bills revamp)

- Bills can be **Personal** (private to you) or **Joint** (shared, split between you);
  the page, summary, table filters and dashboard card are all member-aware.
- Joint bills support a per-bill **proportional or fixed** split (fixed = enter both
  shares; warns if they don't sum to Total).
- Bill categories now come from your **Budget Categories** (names aligned with
  transactions).
- Filter by scope/category/frequency and sort by any column (default: name).
- Removed the who-owes-whom settlement (joint bills are funded at source).

### Fixed — 2026-06-12 (Feedback round 1)

- **Needs/Wants/Savings showed 0%** — Notion percent-number fields come back as
  fractions (68% → 0.68); `parseBudgetMonth` now scales them to whole percentages.
- Transactions filter selects now match the search field height (consistent `h-9`).

### Changed — 2026-06-12 (Feedback round 1)

- Goals are sorted by soonest target date, then priority (High → Low).
- Quarterly/Yearly bills show their monthly-equivalent as sub-text under the
  total, my share and partner share.
- Removed the `Paused` option from Goal **priority** (priority is now
  High/Medium/Low; Status keeps its own Paused). Legacy Paused priorities coerce
  to none.
- Transactions summary Spending & Net now show a **personal view** — rows split
  as `Shared` are excluded (personal spend on a shared account still counts).

### Changed — 2026-06-12 (Dashboard all-cards-live)

- Every dashboard card now reads live Notion data; `mockData.ts` is deleted.
- **Upcoming annual costs** wired to a new **Annual Commitments** data path
  (`parseAnnualCommitment` + typed `GET /annual`, client `annual/` domain with
  `useAnnual()` and pure `upcomingCommitments`).
- **Carry-forward** (header badge + StatStrip "Remaining" subtitle) now derives
  from the previous month's budget `remaining` (`dashboard/carryForward.ts`);
  omitted entirely when there is no prior-month budget.
- **Reconciliation count** in the header ("X of N accounts reconciled") is live
  from the reconciliations + accounts + settings tolerance.
- **Needs/Wants/Savings** and **Recent transactions** drop their mock fallbacks
  and render empty states when there is no budget / no transactions.

### Added — 2026-06-12 (Settings page)

- Settings page (`/settings`) with Household & model, Accounts, and Categories & rules tabs.
- Editable household split ratio (manual % or derived from each member's income) that now takes effect across Bills and the dashboard.
- Configurable reconciliation tolerance applied on the Reconcile page.
- Category edit/archive from Settings; server-side JSON settings store at `BP_SETTINGS_FILE`.

### Added — 2026-06-12 (Reconcile page — Step 1)

- **Reconcile page** (`/reconcile`) — Step 1 of the Reconcile & Close workflow
  (PRODUCT.md §8.7), replacing the placeholder, lazy-loaded:
  - Enter each account's **actual balance** from the bank and compare it to the
    **calculated balance** (`opening + Σ all transactions`, reusing `accountBalance`).
    Differences within **±£1** auto-reconcile; larger gaps flag a discrepancy.
  - **Resolve a discrepancy** three ways (`ResolveDiscrepancyModal`): **log an
    adjustment** (recommended — creates a Transaction under a new `Adjustments`
    category that closes the gap and reconciles the account), **find transaction**
    (links to Transactions/Upload), or **accept as-is**.
  - **Persistence:** new Notion **Reconciliations** database (one row per
    account + month) via typed `GET /api/reconciliations?month=`, `POST`, and
    `PATCH /:id` (`reconcile-helpers.ts` validate + build, `parseReconciliation`).
  - **Logic (client, pure — `reconcile/reconcile.ts`):** `buildReconcileRows`,
    `rowStatus` (pending / reconciled / discrepancy), `reconcileSummary`, tolerance.
  - Steps 2 (Review & Close) and 3 (Carry forward) render disabled — deferred.
- **Reconciliation adjustments excluded from spending** — `monthSummary` now also
  drops the `Adjustments` category from income and spending (reported separately),
  wired into the Transactions page and dashboard `StatStrip`.
- **New env var** `NOTION_RECONCILIATIONS_DB_ID`.

### Added — 2026-06-12 (Goals page)

- **Goals page** (`/goals`) — data-backed view of the **Financial Goals** register
  (replaces the placeholder), lazy-loaded:
  - Typed data layer: new `Goal` type + `parseGoal` transform; `GET /api/goals` now
    returns parsed goals instead of raw Notion data.
  - **Layout:** responsive grid of progress cards (`GoalCard`) — progress bar, amount
    remaining, monthly contribution, target date, priority + status badges, and
    edit/delete actions on hover. Summary strip totals saved / target / monthly contributions.
  - **Full CRUD:** add / edit / delete (archive) via typed `POST /goals`, `PATCH /goals/:id`,
    `DELETE /goals/:id` (`goal-helpers.ts` validate + build). The `Progress %` formula
    column is never written.
  - **Progress (client, pure — `goals/progress.ts`):** progress is recomputed in-browser
    (`current/target`, clamped 0–100) rather than read from the Notion `Progress %` formula,
    so the page never depends on the formula resolving.
- **Dashboard now uses real goals data** — `GoalsCard` reads the live register via
  `useGoals()`; the `mockData.goals` placeholder is removed.

### Added — 2026-06-11 (Bills: CRUD, dashboard wiring, member-aware settlement)

- **Add / edit / delete shared bills** from the Bills page — `BillModal` (add+edit)
  and a delete confirm, backed by typed `POST /bills`, `PATCH /bills/:id`,
  `DELETE /bills/:id` (archive). The `My/Partner Share` formula columns are never
  written; they recompute from `Total Amount`.
- **Dashboard now uses real bills data** — `SharedBillsCard` and the `StatStrip`
  "Shared bills" tile read the live register via `useBills()`; the
  `mockData.sharedBills` placeholder is removed.
- **Member-aware settlement** — `settlement` now returns a household-absolute
  result (`{ debtor: 'primary' | 'partner' | null, amount }`) and
  `settlementDirection(s, viewerIsPrimary)` projects it onto the logged-in member,
  so the partner sees "you owe / owes you" correctly (not just the primary's view).

### Added — 2026-06-11 (Bills page)

- **Bills page** (`/bills`) — data-backed view of the Shared Bills Register
  (replaces the placeholder):
  - Typed data layer: new `SharedBill` type + `parseSharedBill` transform;
    `GET /api/bills` now returns parsed bills instead of raw Notion data.
  - **Settlement** (`bills/settlement.ts`, pure + tested): `settlement` derives
    who-owes-whom from each bill's `Paid By` × the fixed 58/42 shares (Joint =
    no debt); `billsSummary` totals on a monthly-equivalent basis (Quarterly ÷3,
    Yearly ÷12).
  - UI: header, summary strip (monthly total / my share / partner share),
    settlement panel, and the register table — lazy-loaded like Transactions.
  - The wireframe's month-over-month trends chart is deferred to phase 2.

### Added — 2026-06-11 (Edit accounts)

- **Edit existing accounts** from the Upload wizard — a pencil button on each
  account card (shown on hover/focus) opens the account modal pre-filled.
  `AddAccountModal` is now `AccountModal`, serving both add and edit. Saves go to
  the new typed `PATCH /api/accounts/:id` (reuses the create validator/builder).

### Changed — 2026-06-11

- **Transfers are now category-driven in the summary.** A transaction filed
  under the `Transfers` category is excluded from both Income and Spending (in
  addition to linked `isTransfer` legs). This replaces the earlier account-type
  income exclusion and detection-based spending exclusion, and works for
  single-account imports where the matching leg isn't present. Both the
  Transactions page and the dashboard "Total spent" tile apply the rule.
- **Credit-card payments auto-categorise to `Transfers`.** `american exp`/`amex`
  payment descriptions in a current-account statement now map to the `Transfers`
  category on import, so they no longer count as spending. (Savings/Monzo moves
  are intentionally left to leg-pairing.)
- Account modal no longer exposes a separate **CSV format** picker — it's now
  determined by the chosen bank (the bank already sets the import parser).

### Added — 2026-06-11 (Transactions page)

- **Transactions page** (`/transactions`) — full interactive view built from the
  wireframe:
  - Month navigation (◄ / ►) with a server-side date-range filter; summary strip
    (Income / Spending — transfers excluded / Transfers ↔ / Net).
  - Search + Account / Category / Type / Shared filters and sortable Date / Amount
    columns (pure helpers in `client/transactions/`).
  - Inline per-row category change and a bulk action bar (recategorise, mark
    Shared/Personal, soft-delete) over multi-selected rows.
  - **Transfer handling:** linked legs collapse into one expandable row; an
    in-month auto-detect banner opens a confirm-queue modal; a manual
    "Link as transfer" modal (best-match ranked) covers what auto-detect misses;
    transfer rows can be unlinked.
  - **Add transaction** modal (typed `POST /api/transactions`; `Imported By` is
    derived from the session, never trusted from the client).
- **Member privacy (server-enforced):** `GET /api/transactions` returns Shared and
  blank-split rows to everyone, but a `Personal` row only to the member who
  imported it — the other member's personal rows never reach the client.
- **Live dashboard cards:** SpendingByCategory (live Spent + per-category
  `Monthly Target` budget + Shared/Personal segment), StatStrip "Total spent", and
  AccountBalances (opening balance + Σ transactions) now use live data.
- **Sidebar:** collapse toggle moved to the bottom (above the divider); nav labels
  fade out/in on collapse/expand.
- **Server:** paginated + date/`Deleted`-filtered `getTransactions`; new
  `POST /api/transactions/bulk` (category/split/delete, 207 partial-progress on
  failure), `POST /api/transactions/:id/transfer-link|transfer-unlink`, and a typed
  `PATCH /api/transactions/:id`.

### Fixed — 2026-06-11 (Transactions page)

- The Transactions page now lands on the **most recent month that has data**
  (via `latestMonth` over the shared `['transactions']` cache) instead of the
  literal current month, so it no longer opens on an empty month when the latest
  imports predate today.
- Dark mode: the category dropdown (`TransactionRow`), filter selects + search
  (`FilterBar`) and the bulk-bar select set a dark background but no text colour,
  leaving black-on-dark text — added `text-gray-900 dark:text-gray-100`.
- Dark mode: the month-navigation arrow buttons (`TransactionsHeader`) had no text
  colour, so the chevrons rendered dark-on-dark — added a muted
  `text-gray-500 dark:text-gray-400` icon colour matching the rest of the page.

### Notion schema (Transactions page)

- Added a **`Deleted`** checkbox to the Transactions database for soft-delete;
  filtered out server-side.
- `Category` now exposes **`Monthly Target`** (£) and **`Pay From`**;
  `Transaction` now exposes `deleted` and `linkedTransferId`.

### Added — 2026-06-11

- **CSV Upload feature** (`/upload`) — a two-step wizard to import bank
  transactions into Notion:
  - Account selection with an inline **Add account** modal (the Accounts DB
    starts empty); the chosen account sets the parser and links every imported row.
  - Drag-and-drop CSV upload with header validation against the account's format.
  - **Bank parsers** for Amex, Monzo, Lloyds and Revolut
    (`app/src/client/upload/parsers/`), normalising each export to a common
    signed-amount shape (Amex's inverted sign is corrected; Revolut keeps only
    COMPLETED GBP rows).
  - **Auto-categorisation** via a keyword→category map in code
    (`app/src/client/upload/categorisation/`), falling back to the bank's own
    category column.
  - **Transfer detection** (`app/src/client/upload/transfers/`) — flags
    inter-account transfers (equal amount, opposite direction, ±3 days) so they
    are excluded from spending and the two sides are linked.
  - Editable review table (category dropdown, Shared/Personal toggle, bulk
    actions) before the write.
  - **Import progress bar** — rows are sent in batches of 15 so the review screen
    shows a real "Importing X of N…" progress bar during the write.
  - Server: `POST /api/transactions/import` (validated typed payload, dedup,
    transfer back-linking), typed `POST /api/accounts`, and typed `GET /api/categories`.
  - **Inline category creation** — a "+ New category…" option in the review
    dropdown creates a Budget Category in Notion (`POST /api/categories`) and
    assigns it to the row.
  - **Transfers category** — detected transfers are filed under a dedicated
    `Transfers` category (created on first import if missing); they remain
    excluded from spending via `Is Transfer`.
- **Sidebar** — collapse toggle (chevron) to an icons-only rail (logo only, no
  wordmark; preference persisted in `localStorage`), and a user-icon menu
  showing the signed-in name with a sign-out action.

### Changed — 2026-06-11

- `Transaction` type/transform now include `categoryId` and `split`; `Account`
  now includes `csvFormat`; added a `Category` type and `parseCategory`.
- `NotionAdapter.getTransactions` no longer applies the broken `Month` select
  filter (Month is a relation) — it returns recent rows for in-memory use.
- `express.json` body limit raised to 1 MB for bulk imports.

### Notion schema

- Added a **`Split`** select (Shared / Personal) to the Transactions database to
  persist per-row cost ownership.
