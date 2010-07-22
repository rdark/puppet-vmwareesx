# Class for IBM ServeRAID Manager Installs 
	
class ibmserveraid::vmwareesx {
	include firewall::vmwareesx::smtpclient                                                                                              
	include firewall::vmwareesx::ibmserveraid
	include firewall::vmwareesx::httpclient::enable
	case $architecture {
		x86_64 : {
			package { "RaidMan-9.00":
				ensure => installed,
				provider => rpm,
				require => Exec["apply_esx_firewall_http_client"],
				source => "http://puppet.example.com/pub/ibm-serveraid/RaidMan-9.00.x86_64.rpm",
				}
		}
	}
}
