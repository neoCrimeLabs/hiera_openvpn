define openvpn::server(
    $vpnserver = "",
    $port="1194",
    $ip="",
    $subnet="",
    $mask="255.255.255.0",
    $proto="udp",
    $port_share="",
) {
    if $subnet {

        file { "openvpn-server-${title}":
            ensure => present,
            path => "/etc/openvpn/server-${ip}-${port}-${proto}.conf",
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
        notify { "openvpn::server ${vpnserver} ${title} cannot be configured without private subnet address.": }
    }
}
