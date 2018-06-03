#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Plex Media Server
# Enables the WebTools plugin if the user requested that
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.true 'webtools' && ! hass.directory_exists \
        "/data/Plex Media Server/Plug-ins/WebTools.bundle"; then
    hass.log.info 'Enabling WebTools plugin...'
    mkdir -p "/data/Plex Media Server/Plug-ins/"
    ln -s "/opt/WebTools.bundle" "/data/Plex Media Server/Plug-ins/"
fi

if hass.config.false 'webtools' && hass.directory_exists \
        "/data/Plex Media Server/Plug-ins/WebTools.bundle"; then
    rm -f "/data/Plex Media Server/Plug-ins/WebTools.bundle"
fi
