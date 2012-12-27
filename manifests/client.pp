define openvpn::client(
	$ip="",
	$port="1194",
	$proto="udp"
) {
	if $ip {
		file { "openvpn-client-${title}":
			ensure => present,
			path => "/etc/openvpn/client-${title}.conf",
			owner => root,
			group => root,
			mode => 600,
			require => File["openvpn-tlsauth-key"],
			content => template("${module_name}/client.erb"),
			notify => Service["openvpn"],
			tag => $ip
		}
	} else {
		notify {"openvpn::client ${title} cannot be configured without a server ip":}
	}
}
