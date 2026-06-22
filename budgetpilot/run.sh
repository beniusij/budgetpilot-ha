#!/usr/bin/env sh
set -e

# Read config from HA options file (mounted at /data/options.json by Supervisor)
if [ -f /data/options.json ]; then
  export NOTION_TOKEN="$(bun -e "console.log(require('/data/options.json').notion_token)")"
  export USER_1_NAME="$(bun -e "console.log(require('/data/options.json').user_1_name)")"
  export USER_1_PIN="$(bun -e "console.log(require('/data/options.json').user_1_pin)")"
  export USER_2_NAME="$(bun -e "console.log(require('/data/options.json').user_2_name)")"
  export USER_2_PIN="$(bun -e "console.log(require('/data/options.json').user_2_pin)")"
  export NOTION_BUDGET_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_budget_db_id)")"
  export NOTION_CATEGORIES_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_categories_db_id)")"
  export NOTION_TRANSACTIONS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_transactions_db_id)")"
  export NOTION_SAVINGS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_savings_db_id)")"
  export NOTION_GOALS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_goals_db_id)")"
  export NOTION_BILLS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_bills_db_id)")"
  export NOTION_ANNUAL_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_annual_db_id)")"
  export NOTION_ACCOUNTS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_accounts_db_id)")"
  export NOTION_RECONCILIATIONS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_reconciliations_db_id)")"
fi

# Persist settings on the add-on's /data volume (survives restarts/rebuilds).
export BP_SETTINGS_FILE="${BP_SETTINGS_FILE:-/data/settings.json}"

export PORT="${PORT:-3000}"
export NODE_ENV="production"

echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Starting BudgetPilot on port ${PORT}..."
exec bun src/server/index.ts