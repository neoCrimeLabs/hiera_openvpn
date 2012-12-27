# Hiera_OpenVPN

A proof of concept puppet module for managing openvpn using hiera and puppet's existing certificates.

If a host is connected to puppet it can access openvpn

## Known Limitations

* Configurations are (currently) limited to the boundaries of the CA.  
* Currently you have to roll TLS-Auth key by hand

## Known Todo

* Documentation
* Support multiple ports per server, but single client config (ie, UDP w/ TCP fallback)
* Roll DH key in puppet, not by script
