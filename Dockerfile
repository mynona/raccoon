# ================================
# Build stage
# ================================
FROM swift:6.3-noble AS build

# Install OS updates and dependencies
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# First copy package manifests to cache dependency resolution
COPY Package.swift Package.resolved* ./
RUN swift package resolve

# Copy source code, tests (required by Package.swift manifest), and public assets
COPY Sources ./Sources
COPY Tests ./Tests
COPY Public ./Public

# Compile the Preview executable in release mode
RUN swift build -c release --product Preview --static-swift-stdlib

# Stage binary and static assets
WORKDIR /staging
RUN cp "$(swift build -c release --show-bin-path)/Preview" ./Preview \
    && [ -d "/build/Public" ] && cp -Ra /build/Public ./Public || true

# ================================
# Run stage
# ================================
FROM ubuntu:noble AS run

# Install runtime libraries
RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y \
    && apt-get -q install -y --no-install-recommends \
        ca-certificates \
        tzdata \
        libcurl4 \
        libxml2 \
    && rm -rf /var/lib/apt/lists/*

# Run as non-root user for security
RUN useradd --user-group --create-home --system --skel /dev/null --home-dir /app vapor
WORKDIR /app

# Copy staged artifacts from build stage
COPY --from=build --chown=vapor:vapor /staging /app

USER vapor:vapor

ENV ENVIRONMENT=production
EXPOSE 8090

ENTRYPOINT ["./Preview"]
CMD ["serve"]
