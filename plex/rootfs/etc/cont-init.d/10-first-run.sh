#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Plex Media Server
# Initializes all kinds of stuff on the first run of the Plex Media Server
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly prefs="/data/Plex Media Server/Preferences.xml"

function getPref {
    local key="$1"

    xmlstarlet sel -T -t -m "/Preferences" -v "@${key}" -n "${prefs}"
}

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

if ! hass.file_exists "${prefs}"; then
    hass.log.info 'First run! Initializing configuration files...'

    if ! hass.config.has_value "claim_code"; then
        hass.log.fatal "Aborting. A claim code is required!"
        hass.die "Please check the installation manual of the add-on"
    fi

    hass.log.debug "Generating unique serial & client id's..."
    serial=$(uuidgen)
    clientId=$(sha1sum <<< "${serial} - Hass.io Plex add-on" | cut -b 1-40)
    claim_code=$(hass.config.get 'claim_code')
    if ! response=$(curl --silent --show-error \
        --write-out '\n%{http_code}' --request POST \
        -H "X-Plex-Client-Identifier: ${clientId}" \
        -H 'X-Plex-Product: Plex Media Server' \
        -H 'X-Plex-Version: 1.1' \
        -H 'X-Plex-Provides: server' \
        -H 'X-Plex-Platform: Linux' \
        -H 'X-Plex-Platform-Version: 1.0' \
        -H 'X-Plex-Device-Name: PlexMediaServer' \
        -H 'X-Plex-Device: Linux' \
        "https://plex.tv/api/claim/exchange?token=${claim_code}"
    ); then
        hass.log.debug "${response}"
        hass.log.fatal "Something went wrong contacting the Plex API"
        hass.die "Maybe your claim code is wrong or expired?"
    fi

    status=${response##*$'\n'}
    response=${response%$status}

    if [[ "${status}" -ne 200 ]]; then
        hass.log.debug "${response}"
        hass.log.fatal "Something went wrong contacting the Plex API"
        hass.die "Maybe your claim code is wrong or expired?"
    fi

    hass.log.debug "Plex API HTTP Response code: ${status}"
    hass.log.debug "Plex API Response: ${response}"

    token="$(echo "${response}" | sed -n 's/.*<authentication-token>\(.*\)<\/authentication-token>.*/\1/p')"

    mkdir -p "$(dirname "${prefs}")"

    cat > "${prefs}" <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<Preferences/>
EOF

    setPref "MachineIdentifier" "${serial}"
    setPref "ProcessedMachineIdentifier" "${clientId}"
    setPref "PlexOnlineToken" "${token}"
    setPref "FriendlyName" "Hass.io"

    mkdir -p "/share/transcode"
    setPref "TranscoderTempDirectory" "/share/transcode"
fi
