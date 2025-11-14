ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:8.1.4
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64
ARG PLEX_VERSION=1.42.2.10156
ARG PLEX_HASH=f737b826c

# hadolint ignore=DL3008
RUN \
    echo "deb http://deb.debian.org/debian trixie contrib non-free" \
        >> /etc/apt/sources.list \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        xmlstarlet>="1.6.1-4" \
        uuid-runtime=2.41-5 \
        unrar=1:7.1.8-1 \
    \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then ARCH="amd64"; fi \
    \
    && curl -J -L -o /tmp/plexmediaserver.deb \
        "https://downloads.plex.tv/plex-media-server-new/${PLEX_VERSION}-${PLEX_HASH}/debian/plexmediaserver_${PLEX_VERSION}-${PLEX_HASH}_${ARCH}.deb" \
    \
    && dpkg --install /tmp/plexmediaserver.deb \
    \
    && apt-get -y clean \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
