#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Plex Media Server
# Ensures the Plex Media Server is advertised using a custom IP
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly prefs="/data/Plex Media Server/Preferences.xml"

function setPref {
    local key="$1"
    local value="$2"

    count="$(xmlstarlet sel -t -v "count(/Preferences/@${key})" "${prefs}")"
    count=$((count + 0))
    if [[ $count -gt 0 ]]; then
        xmlstarlet ed --inplace --update \
            "/Preferences/@${key}" -v "${value}" "${prefs}"
    else
        xmlstarlet ed --inplace --insert \
            "/Preferences"  --type attr -n "${key}" -v "${value}" "${prefs}"
    fi
}

if ! hass.config.has_value 'advertise_ip'; then
    hass.die 'Please set the advertise_ip option!'
fi

setPref "customConnections" "$(hass.config.get 'advertise_ip')"
