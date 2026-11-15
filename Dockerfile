# ── Stage 1: Build / Install deps ───────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files first (layer caching)
COPY package*.json ./
RUN npm ci --only=production

# ── Stage 2: Lean runtime image ──────────────────────────
FROM node:20-alpine AS runner

# Non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy installed deps from builder
COPY --from=builder /app/node_modules ./node_modules

# Copy source code
COPY src/ ./src/

# Switch to non-root
USER appuser

# Expose port
EXPOSE 3000

# Health check built into image
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Start the app
CMD ["node", "src/index.js"]
