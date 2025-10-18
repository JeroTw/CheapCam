#!/bin/bash

CONN_NAME="tt"
DEFAULT_GW="172.16.250.1"
CHECK_URL="ipwho.is"

while true; do
    # 1. Проверяем маршрут по умолчанию (отдельно!)
    if ! ip route | grep -q "default via $DEFAULT_GW dev tun0"; then
        echo "Маршрут по умолчанию отсутствует. Добавляем..."
        ip route add default via "$DEFAULT_GW" dev tun0
    fi

    # 2. Проверяем интернет через tun0 (отдельно!)
    if ! curl --max-time 60 --interface tun0 -s "$CHECK_URL" > /dev/null; then
        echo "Нет интернета на tun0. Переподключаем $CONN_NAME..."
        nmcli conn up "$CONN_NAME"
    fi

    sleep 120
done
