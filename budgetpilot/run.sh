#!/usr/bin/env sh
set -e

# Read config from HA options file (mounted at /data/options.json by Supervisor)
if [ -f /data/options.json ]; then
  export PRICE_FEED_ENABLED="$(bun -e "console.log(require('/data/options.json').price_feed_enabled)")"
  export PRICE_FEED_INTERVAL_HOURS="$(bun -e "console.log(require('/data/options.json').price_feed_interval_hours)")"
fi

# The SQLite database on the add-on's /data volume is the single persistent
# store (survives restarts/rebuilds). BP_SETTINGS_FILE points at any pre-DB
# settings.json so the first boot after upgrading folds it into the database;
# afterwards it's ignored (the DB is authoritative).
export BP_DB_FILE="${BP_DB_FILE:-/data/taupa.db}"
export BP_SETTINGS_FILE="${BP_SETTINGS_FILE:-/data/settings.json}"

# One-time database seed. Drop a `taupa-seed.db` into the Home Assistant config
# directory (mapped read-write via `config:rw`) and restart the add-on: it's
# installed as the database, then the seed is deleted so a later restart can't
# clobber live data. Used to import an existing household (e.g. migrated from a
# dev machine) onto the device without needing docker/host access. Both the
# legacy (/config) and newer (/homeassistant) mount points are checked.
for _seed_dir in /config /homeassistant; do
  _seed="$_seed_dir/taupa-seed.db"
  if [ -f "$_seed" ]; then
    echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Seeding database from $_seed"
    cp "$_seed" "$BP_DB_FILE"
    rm -f "$_seed" "${BP_DB_FILE}-wal" "${BP_DB_FILE}-shm"
  fi
done

export PORT="${PORT:-3000}"
export NODE_ENV="production"

echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] Starting BudgetPilot on port ${PORT}..."
exec bun src/server/index.ts