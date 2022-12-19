#!/command/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Home Assistant Community Add-on: Plex Media Server
# Initializes all kinds of stuff on the first run of the Plex Media Server
# ==============================================================================
readonly prefs="/data/Plex Media Server/Preferences.xml"
readonly claim="/data/claim_code"

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

if ! bashio::fs.file_exists "${claim}"; then
    touch "${claim}"
fi

if ! bashio::fs.file_exists "${prefs}"; then
    if ! bashio::config.has_value "claim_code"; then
        bashio::log.fatal
        bashio::log.fatal "Add-on configuration is incomplete!"
        bashio::log.fatal
        bashio::log.fatal "Plex requires a claim code on the first run!"
        bashio::log.fatal
        bashio::log.fatal "Please check the installation manual of the add-on."
        bashio::log.fatal
        bashio::exit.nok
    fi

    bashio::log.info 'First run! Initializing configuration files...'

    mkdir -p "$(dirname "${prefs}")"
    cat > "${prefs}" <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<Preferences/>
EOF

    serial=$(uuidgen)
    clientId=$(sha1sum <<< "${serial} - Home Assistant Plex add-on" | cut -b 1-40)

    setPref "MachineIdentifier" "${serial}"
    setPref "ProcessedMachineIdentifier" "${clientId}"
    setPref "FriendlyName" "Home Assistant"

    mkdir -p "/share/transcode"
    setPref "TranscoderTempDirectory" "/share/transcode"
fi

previous_claim_code=$(<"${claim}")
claim_code=$(bashio::config 'claim_code')
if bashio::var.has_value "${claim_code}" && [[ "${previous_claim_code}" != "${claim_code}" ]]; then
    bashio::log.debug "Generating unique serial & client id's..."
    clientId=$(getPref "ProcessedMachineIdentifier")
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
        bashio::log.debug "${response}"
        bashio::log.fatal
        bashio::log.fatal "Something went wrong contacting the Plex API"
        bashio::log.fatal "Maybe your claim code is wrong or expired?"
        bashio::log.fatal
        bashio::exit.nok
    fi

    status=${response##*$'\n'}
    response="${response%"$status"}"

    if [[ "${status}" -ne 200 ]]; then
        bashio::log.debug "${response}"
        bashio::log.fatal
        bashio::log.fatal "Something went wrong contacting the Plex API"
        bashio::log.fatal "Maybe your claim code is wrong or expired?"
        bashio::exit.nok
    fi

    bashio::log.debug "Plex API HTTP Response code: ${status}"
    bashio::log.debug "Plex API Response: ${response}"

    token="$(echo "${response}" | sed -n 's/.*<authentication-token>\(.*\)<\/authentication-token>.*/\1/p')"

    setPref "PlexOnlineToken" "${token}"
    echo "${claim_code}" > "${claim}"
fi
