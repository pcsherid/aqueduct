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

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-829
# Group Title: GEN003940
# Rule ID: SV-37461r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003940
# Rule Title: The hosts.lpd (or equivalent) must have mode 0644 or less 
# permissive.
#
# Vulnerability Discussion: Excessive permissions on the hosts.lpd (or 
# equivalent) file may permit unauthorized modification.  Unauthorized 
# modifications could disrupt access to local printers from authorized 
# remote hosts or permit unauthorized remote access to local printers.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the mode of the print service configuration file.

# Procedure:
# ls -lL /etc/cups/printers.conf

# If no print service configuration file is found, this is not applicable.
# If the mode of the print service configuration file is more permissive 
# than 0664, this is a finding.


#
# Fix Text: 
#
# Change the mode of the /etc/cups/printers.conf file to 0664 or less 
# permissive.

# Procedure:
# chmod 0664 /etc/cups/printers.conf     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003940
	
#Start-Lockdown

if [ -a "/etc/cups/printers.conf" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/cups/printers.conf`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7113)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&1)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]
      then
        chmod u-xs,g-xs,o-wxt /etc/cups/printers.conf
    fi
fi



