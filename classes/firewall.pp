# Classes for configuring firewalls

class firewall::vmwareesx::smtpclient {
	include firewall::vmwareesx::refreshservices

	file { "smtpClient.xml":
		ensure => present,
		owner => root,
		group => root,
		mode => 600,
		checksum => md5,
		notify => [ Exec["refresh_esx_firewall"], Exec["apply_esx_firewall_smtp_client"] ],
		source => "puppet:///files/vmware-firewall/etc/vmware/firewall/smtpClient.xml",
		path => "/etc/vmware/firewall/smtpClient.xml"
	}

	exec { "esxcfg-firewall -e 'SMTP Client'":
		path => "/usr/sbin:/usr/bin:/bin",
		alias => "apply_esx_firewall_smtp_client",
		refreshonly => true
	}
}

class firewall::vmwareesx::puppetclient {
	include firewall::vmwareesx::refreshservices

	file { "puppetClient.xml":
		ensure => present,
		owner => root,
		group => root,
		mode => 600,
		checksum => md5,
		notify => [ Exec["refresh_esx_firewall"], Exec["apply_esx_firewall_puppet_client"] ],
		source => "puppet:///files/vmware-firewall/etc/vmware/firewall/puppetClient.xml",
		path => "/etc/vmware/firewall/puppetClient.xml"
	}

	exec { "esxcfg-firewall -e 'Puppet Client'":
		path => "/usr/sbin:/usr/bin:/bin",
		alias => "apply_esx_firewall_puppet_client",
		refreshonly => true
	}
}

class firewall::vmwareesx::ibmserveraid{
	include firewall::vmwareesx::refreshservices

	file { "ibmServeRaid.xml":
		ensure => present,
		owner => root,
		group => root,
		mode => 600,
		checksum => md5,
		notify => [ Exec["refresh_esx_firewall"], Exec["apply_esx_firewall_ibm_serveraid"] ],
		source => "puppet:///files/vmware-firewall/etc/vmware/firewall/ibmServeRaid.xml",
		path => "/etc/vmware/firewall/ibmServeRaid.xml"
	}

	exec { "esxcfg-firewall -e 'IBM ServeRaid'":
		path => "/usr/sbin:/usr/bin:/bin",
		alias => "apply_esx_firewall_ibm_serveraid",
		refreshonly => true
	}
	
}

class firewall::vmwareesx::refreshservices {

	# Update services (only call if rule has been added/updated)
	exec { "esxcfg-firewall -l":
		path => "/usr/sbin:/usr/bin:/bin",
		alias => "refresh_esx_firewall",
		refreshonly => true,
	}
}	
