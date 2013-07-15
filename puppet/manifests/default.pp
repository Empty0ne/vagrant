Exec { path => [ "/bin/", "/sbin/", "/usr/sbin/", "/usr/bin/" ] }

class system-update {
	exec { 'apt-get update':
		command => 'apt-get update',
	}
	$sysPackages = [ "build-essential" ]
		package { $sysPackages:
		ensure => "installed",
		require => Exec['apt-get update'],
	}
}



class apache {
	package { apache2:
		ensure => present,
		require => Class["system-update"],
	}
	
	service { "apache2":
		ensure => "running",
		require => Package["apache2"],
	}
}

include system-update
include apache
