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

# Copy configuration files first to take advantage of Docker layer caching
COPY package*.json turbo.json ./
COPY packages/app/studio/package.json ./packages/app/studio/
COPY packages/studio/core/package.json ./packages/studio/core/

# Install the monorepo dependencies
RUN npm install

# Copy the rest of the source code and build the static studio assets
COPY . .
# RUN npm run build
RUN npx turbo run build --filter=@opendaw/app-studio

# --- Stage 2: Production Web Server (Final Image) ---
FROM nginx:alpine AS runner

# Copy the statically compiled bundle out of the builder stage
COPY --from=builder /app/packages/app/studio/dist /usr/share/nginx/html

# Expose HTTPS port
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]