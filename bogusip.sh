#!/bin/bash

DNS="8.8.8.8"

check_ip() {
    host="$1"
    ip="$2"
    dns="$3"

    ip_real=$(nslookup "$host" "$dns" | awk '/^Address: / {print $2}' | tail -n 1)

    if [[ -n "$ip_real" && "$ip" != "$ip_real" ]]; then
        echo "Bogus IP for $host in etc/hosts!"
    fi
}

while read -r ip name aliases; do
    if [[ -z "$ip" || "$ip" == "#"* || "$ip" == "::1" ]]; then
        continue
    fi

    if [[ -n "$name" ]]; then
        check_ip "$name" "$ip" "$DNS"
    fi
done < /etc/hosts

