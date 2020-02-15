#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Plex Media Server
# Enables the WebTools plugin if the user requested that
# ==============================================================================
if bashio::config.true 'webtools' && ! bashio::fs.directory_exists \
        "/data/Plex Media Server/Plug-ins/WebTools.bundle"; then
    bashio::log.info 'Enabling WebTools plugin...'
    mkdir -p "/data/Plex Media Server/Plug-ins/"
    ln -s "/opt/WebTools.bundle" "/data/Plex Media Server/Plug-ins/"
fi

if bashio::config.false 'webtools' && bashio::fs.directory_exists \
        "/data/Plex Media Server/Plug-ins/WebTools.bundle"; then
    rm -f "/data/Plex Media Server/Plug-ins/WebTools.bundle"
fi
