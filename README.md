# Hiera_OpenVPN

A proof of concept puppet module for managing openvpn using hiera and puppet's existing certificates.

* Any puppet-managed host can be a server
* Any puppet-managed host can be a client
* Caveat:  As long as they are signed by the same CA

This may not seem useful unless you manage workstations/laptops with puppet.  ;-)

## Known Limitations

* This is focused on Ubuntu 12.04.  It should work on most Linux distributions, though you may need to supply the openvpn package (redhat)
* Currently you have to roll TLS-Auth key and DH-Params by hand (see script in files)
* And more...

## Known Todo

* Documentation
* Support multiple ports per server, but single client config (ie, UDP w/ TCP fallback)
* Roll keys with puppet

## How to use

* Go to files dir and run the makekeys.sh script
* Edit your hiera datafile of choice similar to the example in examples/common.yaml
* Add "include openvpn" to any hosts you want to join in the fun
 * Servers will automatically figure out if they are a server or not
 * All hosts will get client configs for all servers
 * User hiera for restricting VPN's to groups of servers (config data doesn't need to be in common.yaml)

## Support, Feedback, Comments

I'm happy to answer any questions.

Ways to contact me:
* Issue me a bug here
* irc.mozilla.org as tinfoil
* Freenode #puppet as tinfoil
* https://twitter.com/neoCrimeLabs

Keep in mind:  This is a proof of concept module, and I'm a puppet newb at the time of writing it.  It's bound to have issues and not be perfect.  


