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
  export NOTION_ACCOUNTS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_accounts_db_id)")"
  export NOTION_RECONCILIATIONS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_reconciliations_db_id)")"
  export NOTION_BUDGET_LOG_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_budget_log_db_id)")"
  export NOTION_INVESTMENT_ASSETS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_investment_assets_db_id)")"
  export NOTION_ASSET_PRICES_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_asset_prices_db_id)")"
  export NOTION_INVESTMENT_LOTS_DB_ID="$(bun -e "console.log(require('/data/options.json').notion_investment_lots_db_id)")"
  export PRICE_FEED_ENABLED="$(bun -e "console.log(require('/data/options.json').price_feed_enabled)")"
  export PRICE_FEED_INTERVAL_HOURS="$(bun -e "console.log(require('/data/options.json').price_feed_interval_hours)")"
fi

# Persist settings, sessions, and the Notion cache on the add-on's /data volume
# (survives restarts/rebuilds, so an update doesn't log everyone out or force a
# cold, hang-prone first load while Notion is slow).
export BP_SETTINGS_FILE="${BP_SETTINGS_FILE:-/data/settings.json}"
export BP_SESSIONS_FILE="${BP_SESSIONS_FILE:-/data/sessions.json}"
export BP_NOTION_CACHE_FILE="${BP_NOTION_CACHE_FILE:-/data/notion-cache.json}"

export PORT="${PORT:-3000}"
export NODE_ENV="production"

echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Starting BudgetPilot on port ${PORT}..."
exec bun src/server/index.ts