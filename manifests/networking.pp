############################################################
# Class: networking
#
# Description:
#	Sets up certain important files for network support
#
# Variables:
#	shared::dnsservers
#	shared::gateway
#
# Facts:
#	localinterface - custom fact created to work around em1 and eth0 detection
#	fqdn
#	macaddress
#	ipaddress
#	netmask
#
# Files:
#	None
#
# Templates:
#	aqueduct/templates/networking/ifcfg.erb
#	aqueduct/templates/networking/network.erb
#	aqueduct/templates/networking/resolv.conf.erb
#
# Dependencies:
#	aqueduct/lib/facter/localinterface.rb
############################################################
class networking {
	service {
		"network":
			ensure    => true,
			enable    => true,
			hasstatus => true;
	}

	file {
		"/etc/resolv.conf":
			owner   => root,
			group   => root,
			mode    => 644,
			content => template("aqueduct/networking/resolv.conf.erb");
		"/etc/sysconfig/network":
			owner   => root,
			group   => root,
			mode    => 644,
			content => template("aqueduct/networking/network.erb");
		"/etc/sysconfig/network-scripts/ifcfg-$localinterface":
			owner   => root,
			group   => root,
			mode    => 644,
			content => template("aqueduct/networking/ifcfg.erb");
	}
}
