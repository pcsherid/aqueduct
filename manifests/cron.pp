############################################################
# Class: cron
#
# Description:
#	- This will configure workstations to run puppet at a randomly
#	determined interval.
#	- It will configure machines to check RPM permissions once a week.
#	- It will configure machines to check for SUID and SGID binaries
#	once a week.
#
# Variables:
#	shared::puppetserver
#	shared::server
#	checkkernelversion
#	first
#	second
#	puppetcron
#
# Facts:
#	fqdn
#
# Files:
#	aqueduct/files/cron/check_kernel_version
#	aqueduct/files/cron/rpmverify
#	aqueduct/files/cron/suidsgidcheck
#
# Templates:
#	cron/crontab.erb
#
# Dependencies:
#	None
############################################################
class cron {

	# This is an example of how to set up a unique run time for puppet agent on each workstation. The
	# resulting cron line is invoked in modules/aqueduct/templates/cron/crontab.erb
	$first = fqdn_rand(30)
	$second = $first + 30

	$puppetcron = "$first,$second * * * * root /usr/bin/puppet agent --test > /dev/null 2>&1"

	file {
		"/etc/cron.deny":
			ensure  => absent;
		"/etc/at.deny":
			ensure  => absent;

		"/etc/cron.allow":
			owner   => root,
			group   => root,
			mode    => 600,
			content => "root\n";
		"/etc/crontab":
			owner   => root,
			group   => root,
			mode    => 644,
			content => template("aqueduct/cron/crontab.erb");
		"/etc/cron.d":
			owner   => root,
			group   => root,
			mode    => 600,
			recurse => true;
		"/etc/cron.weekly/rpmverify":
			owner   => root,
			group   => root,
			mode    => 700,
			source  => "puppet:///modules/aqueduct/cron/rpmverify";
		"/etc/cron.weekly/suidsgidcheck":
			owner   => root,
			group   => root,
			mode    => 700,
			source  => "puppet:///modules/aqueduct/cron/suidsgidcheck";
	}
}
