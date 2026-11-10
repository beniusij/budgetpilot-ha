# Changelog

## [0.4.68] — 2026-11-10

### Fixed

- **Importing a bank file that adds references no longer creates extra copies of repeated charges.** If you had imported two identical charges on one day (two coffees, say) from a statement that had no transaction references, a later export that did carry them used to match only the first and add a third charge, so spending and balances came out too high. Each reference now attaches to its own existing transaction, and nothing new is added.

### Internal

- **Three more end-to-end tests drive the real app in a browser.** One imports a bank statement and then the same file again, and fails if the second import adds anything. One picks a category and uses Reset on the Transactions filters, and "Show them" for rows still waiting for a category. One follows a category on the Overview into the Transactions page. Each test now gets its own app and database, so they run side by side, and a household is put in place for them behind the scenes rather than by clicking through the first-run screens every time. Nothing changes in the app.
- **A first end-to-end test now drives the real app in a browser.** It builds the app, starts it on a database made just for the run, sets up a two-person household through the first-run screens, signs out, checks the sign-in screen is still showing after a reload, and signs back in. It never touches your own data or reaches the internet. Nothing changes in the app: it is the first of a set meant to catch what only a real browser sees, and it is run by hand rather than as part of the normal check.
- **The roadmap records the first part of multiple statement formats per bank.** The feedback note says what has landed and that the new formats are still to come; the board card stays open until they do.
- Which banks can be imported from a PDF statement now sits in one table instead of a check for a single bank, ready for more statement formats. Nothing changes for you today: Nationwide still takes a PDF or a CSV, and every other bank a CSV.
- **Importing a bank statement in a second format is now checked against the first.** A new test imports the same Nationwide period as a CSV and as a PDF, in either order, and fails if the second import adds any transaction or changes the balance. It also checks that a part-month CSV followed by the full-month PDF adds only the missing transactions, that a statement's rows add up to its printed opening and closing balances, and that a file from the wrong bank is still rejected. It records one known gap, that a transaction the PDF prints with a payment reference still reads as new when the CSV was imported first. Nothing changes in the app; every format added to a bank from now on has to pass the same check.
- **The second-format check now follows what the import really does.** It counted an extra charge in a second export, one carrying its own reference, as already imported when the import would add it, and it attached two references to the same stored transaction. Each reference now attaches to its own stored transaction and such a charge counts as added, so the check can no longer pass a second format that would double a balance.
