define openvpn::config (
	$hostname = $title,
	$ip,
	$subnet,
	$mask = "255.255.255.0",
	$port = "1194",
	$proto = "udp"
) {
	if $ip {
		if $subnet {
			if $hostname == $fqdn {
				openvpn::server{ "${ip}-${port}-${proto}":
					ip => $ip,
					subnet => $subnet,
					mask => $mask,
					port => $port,
					proto => $proto
				}
			} else {
				openvpn::client{ "${ip}-${port}-${proto}":
					ip => $ip,
					port => $port,
					proto => $proto
				}
			}
		} else {
			notify {"Cannot create openvpn for ${hostname}, unique subnet not specified":}
		}
	} else {
		notify{"Cannot create openvpn for ${hostname}, external ip not specified":}
	}
}
