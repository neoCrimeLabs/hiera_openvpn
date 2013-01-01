define openvpn::config (
	$vpnserver = $title,
	$ip,
	$ports = {}
) {
	if $ip {
		$defaults = {
			ip => $ip,
			vpnserver => $vpnserver,
			subnet => "",
			mask => "255.255.255.0",
			port => "1194",
			proto => "udp",
			port_share => ""
		}
			
		if $vpnserver == $fqdn {
			# The DH key can be public, and takes a long time to roll
			# Rolling the DH key once on puppetmaster for now
        		file { "openvpn-dh-key":
                		ensure => present,
                		path => "/etc/openvpn/puppet-keys/dh2048.pem",
                		owner => root,
                		group => root,
                		mode => 600,
                		require => File["openvpn-keydir"],
                		replace => true,
                		source  => "puppet:///modules/${module_name}/dh2048.pem",
                		notify => Service["openvpn"]
        		}

			# Seperate config for each ip-port-proto server
			create_resources(openvpn::server, $ports, $defaults)
		} else {
			# We can use one client config per server, however :-)
			openvpn::client{ "${ip}":
				ports => $ports,
				defaults => $defaults
			}
		}
	} else {
		notify{"Cannot create openvpn for ${vpnserver}, external ip not specified":}
	}
}
