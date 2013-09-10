############################################################
# Class: sudo
#
# Description:
#	This file sets up the sudoers file for an admin group
#
# Variables:
#	None
#
# Facts:
#	None
#
# Files:
#	None
#
# Templates:
#	aqueduct/templates/sudo/sudoers.erb
#
# Dependencies:
#	None
############################################################
class sudo {
	file {
		"/etc/sudoers.d/sudogroup":
			owner   => root,
			group   => root,
			mode    => 440,
			content => template("aqueduct/sudo/sudoers.erb"),
	}
}
