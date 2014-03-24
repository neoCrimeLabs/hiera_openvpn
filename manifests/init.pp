class openvpn () {
    $openvpn = hiera("openvpn")

    if $openvpn {
        group { "openvpn":
            system => true,
            ensure => present,
        }

        user { "openvpn":
            ensure => present,
            gid => "openvpn",
            shell => "/bin/false",
            home => "/etc/openvpn",
            system => true,
            require => Group["openvpn"],
        }

        package { "openvpn":
            ensure => present,
            require => User["openvpn"],
        }

        file { "openvpn":
            ensure => directory,
                    path => "/etc/openvpn",
                    owner => root,
                    group => root,
                    mode => 600,
                    require => Package["openvpn"],
            }

        file { "openvpn-keydir":
            ensure => directory,
                    path => "/etc/openvpn/puppet-keys",
                    owner => root,
                    group => root,
                    mode => 600,
                    require => File["openvpn"],
            }

        file { "openvpn-logdir":
            ensure => directory,
                    path => "/var/log/openvpn",
                    owner => root,
                    group => root,
                    mode => 600,
                    require => Package["openvpn"],
            }

        file { "openvpn-tlsauth-key":
            ensure => present,
                    path => "/etc/openvpn/puppet-keys/ta.key",
                    owner => root,
                    group => root,
                    mode => 600,
                    require => File["openvpn-keydir"],
            replace => true,
                source  => "puppet:///modules/${module_name}/ta.key",
            notify => Service["openvpn"],
            }

        file { "var-lib-puppet":
            ensure => directory,
            path => $setting::vardir,
            owner => puppet,
            group => puppet,
            mode => 751 # default mode is 750 - adding o+x to allow traversal without reading
        }

        file { "var-lib-puppet-ssl":
            ensure => directory,
            path => $setting::ssldir,
            owner => puppet,
            group => puppet,
            mode => 771,  # default mode is 770 - adding o+x to allow traversal without reading
            require => File["var-lib-puppet"]
        }

        service { "openvpn":
            ensure     => running,
            hasstatus  => true,
            hasrestart => true,
            enable     => true,
            require    => File["openvpn-tlsauth-key"],
        }


            create_resources(openvpn::config, $openvpn)
    }
}
