define openvpn::server(
	$port="1194",
	$ip="",
	$subnet="",
	$mask="255.255.255.0",
	$proto="udp"
) {
	if $subnet {

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

		file { "openvpn-server-${title}":
			ensure => present,
			path => "/etc/openvpn/server-${title}.conf",
			owner => root,
			group => root,
			mode => 600,
			require => [
				File["openvpn-tlsauth-key"],
				File["openvpn-dh-key"]
			],
			content => template("${module_name}/server.erb"),
			notify => Service["openvpn"]
		}

	} else {
		notify { "openvpn::server ${title} cannot be configured without private subnet address.": }
	}
}
