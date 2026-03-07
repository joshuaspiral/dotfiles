#!/bin/bash

# 1. auto-detect the first WiFi interface (e.g., wlo1)
# use nmcli to list devices, grep for wifi, and grab the first one.
INTERFACE=$(nmcli --get-values DEVICE,TYPE device | grep ":wifi" | cut -d: -f1 | head -n 1)

if [ -z "$INTERFACE" ]; then
    echo "Error: No WiFi interface found."
    exit 1
fi

echo "Detected WiFi Interface: $INTERFACE"

# 2. check if the connection already exists
if nmcli connection show "eduroam" &> /dev/null; then
    echo "Connection 'eduroam' already exists. Deleting it to start fresh..."
    nmcli connection delete "eduroam"
fi

echo "----------------------------------------------------"
read -p "Enter Identity (e.g., utorid@utoronto.ca): " IDENTITY
read -s -p "Enter Password: " PASSWORD
echo -e "\n----------------------------------------------------"

# 4. create the connection
echo "Configuring Eduroam..."

nmcli con add \
    type wifi con-name "eduroam" ifname "$INTERFACE" ssid "eduroam" \
    wifi-sec.key-mgmt wpa-eap 802-1x.eap peap \
    802-1x.phase2-auth mschapv2 \
    802-1x.identity "$IDENTITY" \
    802-1x.password "$PASSWORD" \
    802-1x.system-ca-certs no \
    802-1x.ca-cert none

# 5. connect
echo "Connecting..."
nmcli con up "eduroam"
