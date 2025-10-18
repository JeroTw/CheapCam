#!/bin/bash

SERVER_IP="10.25.0.1"

while true; do
    if ! curl -s --connect-timeout 5 "$SERVER_IP" > /dev/null; then
        echo "$(date): Connection failed, restarting WireGuard..."
        wg-quick down wg0
        sleep 1
        wg-quick up wg0
        echo "$(date): WireGuard restarted"
    fi
    sleep 10
done
