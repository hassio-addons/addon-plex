ARG BUILD_FROM=hassioaddons/ubuntu-base-amd64:1.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base system
ARG BUILD_ARCH=amd64
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        xmlstarlet=1.6.1-1ubuntu1 \
        uuid-runtime=2.27.1-6ubuntu3 \
        unrar=1:5.3.2-1 \
    \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm7"; fi \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then ARCH="x86_64"; fi \
    && if [ "${BUILD_ARCH}" = "armhf" ]; then ARCH="arm7"; fi \
    && if [ "${BUILD_ARCH}" = "i386" ]; then ARCH="x86"; fi \
    \
    && curl -J -L -o /tmp/plexmediaserver.tgz \
        "https://downloads.plex.tv/plex-media-server/1.13.0.5023-31d3c0c65/PlexMediaServer-1.13.0.5023-31d3c0c65-${ARCH}.spk" \
    \
    && mkdir /usr/lib/plexmediaserver \
    && tar -xOf /tmp/plexmediaserver.tgz package.tgz | tar -xzf - -C /usr/lib/plexmediaserver/ \
    \
    && apt-get -y autoremove \
    && apt-get -y clean \
    && rm -f -r /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/* \
    && rm -rf /var/{cache,log}/*

# Copy root filesystem
COPY rootfs /

# Build arugments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Plex" \
    io.hass.description="Recorded media, live TV, online news, and podcasts ready to stream." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Recorded media, live TV, online news, and podcasts ready to stream." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Plex" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-plex/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-plex" \
    org.label-schema.vendor="Community Hass.io Add-ons"
