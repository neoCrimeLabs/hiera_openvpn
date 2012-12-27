# Hiera_OpenVPN

A proof of concept puppet module for managing openvpn using hiera and puppet's existing certificates.

* Any puppet-managed host can be a server
* Any puppet-managed host can be a client
* Caveat:  As long as they are signed by the same CA

## Known Limitations

* This is focused on Ubuntu 12.04.  It should work on most Linux distributions, though you may need to supply the openvpn package (redhat)
* Currently you have to roll TLS-Auth key and DH-Params by hand (see script in files)
* And more...

## Known Todo

* Documentation
* Support multiple ports per server, but single client config (ie, UDP w/ TCP fallback)
* Roll keys with puppet
