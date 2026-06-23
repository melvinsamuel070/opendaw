# --- Stage 1: Build Environment (Temporary) ---
FROM node:23-slim AS builder

# Install system utilities needed for building audio core packages
RUN apt-get update && apt-get install -y \
    git \
    openssl \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the entire monorepo so npm workspaces can resolve all internal package links
COPY . .

# Install the monorepo dependencies
RUN npm install

# Build only the studio app and its actual dependency graph
RUN npx turbo run build --filter=@opendaw/app-studio

# --- Stage 2: Production Web Server (Final Image) ---
FROM nginx:alpine AS runner

# Copy the statically compiled bundle out of the builder stage
COPY --from=builder /app/packages/app/studio/dist /usr/share/nginx/html

# Bake in the Nginx config (COOP/COEP headers, SPA routing, MIME types)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose HTTP port (SSL is terminated by host-level Nginx/Certbot in production)
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]