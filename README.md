# Hiera_OpenVPN

A proof of concept puppet module for managing openvpn using hiera and puppet's existing certificates.

If a host is connected to puppet it can access openvpn

## Known Limitations

* This is focused on Ubuntu 12.04.  It should work on most Linux distributions, though you may need to supply the openvpn package (redhat)
* Configurations are limited to the boundaries of the CA. If you have multiple CA's, this module will require modification to make a single VPN to rule them all.
* Currently you have to roll TLS-Auth key and DH-Params by hand (see script in files)

## Known Todo

* Documentation
* Support multiple ports per server, but single client config (ie, UDP w/ TCP fallback)
* Roll keys with puppet
