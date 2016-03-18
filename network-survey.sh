#!/bin/bash -

#
# Start collecting information about the current network.
#
# @param string $1 Name of network info item to return, e.g., "nic" or "gateway_ip"
#
get_network_info () {
    local arg
    arg="$1"

    # Define network info to collect.
    local nic
    local ssid
    local wan_ip4
    local gateway_ip4
    local gateway_ip6

    # OS-specific commands
    if [[ "$OSTYPE" == darwin* ]]; then
        nic="$(networksetup -listallhardwareports | grep -A 1 Wi-Fi | grep Device | cut -d ' ' -f 2)"
        ssid="$(networksetup -getairportnetwork en0 | cut -d ':' -f 2)"
        ssid=${ssid# }
        gateway_ip4=$(netstat -rn -f inet | grep default | awk '{print $2}')
        gateway_ip6=$(netstat -rn -f inet6 | grep default | awk '{print $2}')
    elif [[ "$OSTYPE" == linux* ]]; then
        # TODO: Collect info with GNU/Linux surveyor hosts.
        echo "Not yet implemented."
    fi

    # General commands.
    wan_ip4=$(dig +short myip.opendns.com @resolver1.opendns.com)

    # "return" the requested info item
    echo "${!arg}"
}

#
# function get_mac_address_by_ip
#
get_mac_address_by_ip () {
    echo $(arp "$1" | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}')
}

# function get_geolocation
#
# Returns the latitude/longitude of an IP address using free lookup.
#
# @param string $1 The IP address to lookup geolocation for.
get_geoip_location () {
    local ip4_addr="$1"
    local resp=$(curl -L "https://freegeoip.net/xml/$ip4_addr")
    local lat=$(echo "$resp" | grep Latitude | sed -e 's/<\/\{0,1\}Latitude>//g' | tr -d '[:space:]')
    local lon=$(echo "$resp" | grep Longitude | sed -e 's/<\/\{0,1\}Longitude>//g' | tr -d '[:space:]')
    echo "$lat,$lon"
}

# Zhu Li, do the thing!
main () {
    local submit_url="$1"

    local datetime_iso8601
    datetime_iso8601=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    local network_ssid
    network_ssid="$(get_network_info ssid)"

    local network_gateway_ip4
    network_gateway_ip4="$(get_network_info gateway_ip4)"

    local network_gateway_ip6
    network_gateway_ip6="$(get_network_info gateway_ip6)"

    local network_gateway_mac
    network_gateway_mac="$(get_mac_address_by_ip $network_gateway_ip4)"

    local network_dhcp_ip4_pool

    local network_wan_ip4
    network_wan_ip4=$(get_network_info wan_ip4)

    local geo_coords
    geo_coords=$(get_geoip_location "$network_wan_ip4")
    local geo_coords_latitude=$(echo "$geo_coords" | cut -d ',' -f 1)
    local geo_coords_longitude=$(echo "$geo_coords" | cut -d ',' -f 2)

    http_post_data=$(cat <<EOF
{
    "datetime_iso8601": "$datetime_iso8601",
    "network": {
        "ssid": "$network_ssid",
        "gateway_ip4": "$network_gateway_ip4",
        "gateway_ip6": "$network_gateway_ip6",
        "gateway_mac": "$network_gateway_mac",
        "dhcp_ip4_pool": "$network_dhcp_ip4_pool",
        "wan_ip4": "$network_wan_ip4"
    },
    "geo": {
        "coords": {
            "latitude": "$geo_coords_latitude",
            "longitude": "$geo_coords_longitude"
        }
    }
})

    curl --data "survey_data=$http_post_data" $1
}
main "$@"
