ARG BUILD_FROM=ghcr.io/hassio-addons/ubuntu-base:8.2.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        xmlstarlet=1.6.1-2build1 \
        uuid-runtime=2.34-0.1ubuntu9.3 \
        unrar=1:5.6.6-2build1 \
    \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="aarch64"; fi \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then ARCH="x86_64"; fi \
    && if [ "${BUILD_ARCH}" = "armv7" ]; then ARCH="armv7hf"; fi \
    \
    && curl -J -L -o /tmp/plexmediaserver.tgz \
        "https://downloads.plex.tv/plex-media-server-new/1.32.4.7195-7c8f9d3b6/synology/PlexMediaServer-1.32.4.7195-7c8f9d3b6-${ARCH}_DSM6.spk" \
    \
    && mkdir /usr/lib/plexmediaserver \
    && tar -xOf /tmp/plexmediaserver.tgz package.tgz | tar -xzf - -C /usr/lib/plexmediaserver/ \
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
