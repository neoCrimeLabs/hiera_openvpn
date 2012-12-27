#!/bin/sh

echo "Making TLS Auth Key..."
openvpn --genkey --secret ta.key

echo "Making DH Parameters..."
openssl dhparam -out dh2048.pem 2048

im sqchmod 644 dh2048.pem ta.key
