#!/bin/bash

if [ ! -f .HA_TOKEN ]; then
    echo "No HA API Token found"
    exit 1
fi

function call_api() {
  curl -X $1 \
    -H "Authorization: Bearer $(cat .HA_TOKEN)" \
    -H "Content-Type: application/json" \
    http://hassio:8123/api/$2 2>/dev/null | json_pp
}

case "$1" in
"restart")
    echo "Restarting home assistant... "
    call_api POST services/homeassistant/restart
    ;;
"check")
    echo "Checking config... "
    call_api POST services/homeassistant/check_config
    ;;
"services")
    echo "Listing services... "
    call_api GET services
    ;;
*)
    echo "nothing to do"
esac






