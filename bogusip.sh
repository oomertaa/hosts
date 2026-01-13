#!/bin/bash

DNS="8.8.8.8"

cat /etc/hosts | while read -r ip name aliases; do

	if [[ -z "$ip" || "$ip" == "#"* || "$ip" == "::1" ]]; then
		continue
	fi

	if [[ ! -z "$name" ]]; then
		ip_real=$(nslookup "$name" "$DNS" | grep "Address:" | tail -n 1 | awk '{print $2}' | xargs)
		if [[ ! -z "$ip_real" ]]; then
			if [[ "$ip" != "ip_real" ]]; then
				echo "Bogus IP for $name in etc/hosts!"
			fi
		fi
	fi
done
