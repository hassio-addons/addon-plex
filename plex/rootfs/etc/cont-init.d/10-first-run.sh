#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Plex
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
    xmlstarlet ed --inplace --update "/Preferences/@${key}" -v "${value}" "${prefs}"
  else
    xmlstarlet ed --inplace --insert "/Preferences"  --type attr -n "${key}" -v "${value}" "${prefs}"
  fi
}

if ! hass.file_exists "${prefs}"; then
  hass.log.info 'First run! Initializing configuration files...'

  mkdir -p "$(dirname "${prefs}")"

  cat > "${prefs}" <<-EOF
<?xml version="1.0" encoding="utf-8"?>
<Preferences/>
EOF

  hass.log.debug "Generating unique serial & client id's..."
  serial=$(uuidgen)
  clientId=$(sha1sum <<< "${serial} - Hass.io Plex add-on" | cut -b 1-40)
  setPref "MachineIdentifier" "${serial}"
  setPref "ProcessedMachineIdentifier" "${clientId}"

  if hass.config.has_value 'claim_code'; then
    hass.log.debug "Claiming server with PlexOnline..."
    claim_code=$(hass.config.get 'claim_code')
    loginInfo="$(curl -X POST \
        -H "X-Plex-Client-Identifier: ${clientId}" \
        -H 'X-Plex-Product: Plex Media Server' \
        -H 'X-Plex-Version: 1.1' \
        -H 'X-Plex-Provides: server' \
        -H 'X-Plex-Platform: Linux' \
        -H 'X-Plex-Platform-Version: 1.0' \
        -H 'X-Plex-Device-Name: PlexMediaServer' \
        -H 'X-Plex-Device: Linux' \
        "https://plex.tv/api/claim/exchange?token=${claim_code}")"
    token="$(echo "$loginInfo" | sed -n 's/.*<authentication-token>\(.*\)<\/authentication-token>.*/\1/p')"
    setPref "PlexOnlineToken" "${token}"
  fi

  mkdir -p "/share/transcode"
  setPref "TranscoderTempDirectory" "/share/transcode"
fi
