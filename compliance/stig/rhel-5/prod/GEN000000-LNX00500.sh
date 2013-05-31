#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.
##########################################################################

##################### Fusion Technology LLC #############################
# By Shannon Mitchell                                                   #
# Fusion Technology LLC                                                 #
# Shannon[.]Mitchell[@]fusiontechnology-llc[.]com                       #
# www.fusiontechnology-llc.com                                          #
##################### Fusion Technology LLC #############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Shannon Mitchell   | 15-jul-2012|
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-4335
# Group Title: GEN000000-LNX00500
# Rule ID: SV-37257r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN000000-LNX00500
# Rule Title: The /etc/sysctl.conf file must be group-owned by root.
#
# Vulnerability Discussion: The sysctl.conf file specifies the values for 
# kernel parameters to be set on boot.  These settings can affect the 
# system's security.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check /etc/sysctl.conf group ownership: 
# ls -lL /etc/sysctl.conf 
# If /etc/sysctl.conf is not group-owned by root, this is a finding.
#
# Fix Text: 
#
# Use the chgrp command to change the group owner of /etc/sysctl.conf to 
# root:
# chgrp root /etc/sysctl.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN000000-LNX00500
	
# Start-Lockdown

if [ -a "/etc/sysctl.conf" ]
then
  CURGOWN=`stat -c %G /etc/sysctl.conf`;

  if [ "$CURGOWN" != "root" ]
  then
      chgrp root /etc/sysctl.conf
  fi
fi
