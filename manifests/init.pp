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

		file { "var-puppet":
			ensure => directory,
			path => "/var/puppet",
			owner => puppet,
			group => puppet,
			mode => 751
		}

		file { "var-puppet-ssl":
			ensure => directory,
			path => "/var/puppet/ssl",
			owner => puppet,
			group => puppet,
			mode => 751,
			require => File["var-puppet"]
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
