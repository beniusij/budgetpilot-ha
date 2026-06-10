# syntax=docker/dockerfile:1

# ── Stage 1: Build ────────────────────────────────────────────────────────────
FROM oven/bun:1 AS builder

WORKDIR /build

COPY package.json bun.lockb ./
COPY tsconfig.json ./
COPY app/package.json ./app/
COPY infra/package.json ./infra/

RUN bun install --frozen-lockfile

COPY app/ ./app/

RUN cd app && bun run build

# ── Stage 2: Runtime ──────────────────────────────────────────────────────────
FROM oven/bun:1-alpine

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000

# Copy built frontend assets
COPY --from=builder /build/app/dist/client ./dist/client

# Copy server source
COPY --from=builder /build/app/src/server ./src/server

# Copy app package.json only — no workspace context so bun installs standalone
COPY --from=builder /build/app/package.json ./package.json

# Install production deps in isolation
RUN bun install --production

# Copy tsconfig files needed by bun
COPY --from=builder /build/tsconfig.json /tsconfig.json
COPY --from=builder /build/app/tsconfig.json ./tsconfig.json

COPY ha-addon/run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 3000

CMD ["/run.sh"]