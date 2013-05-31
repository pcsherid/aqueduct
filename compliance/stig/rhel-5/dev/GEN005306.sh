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
# Group ID (Vulid): V-22448
# Group Title: GEN005306
# Rule ID: SV-37693r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN005306
# Rule Title: The SNMP service must require the use of a FIPS 140-2 
# approved cryptographic hash algorithm as part of its authentication and 
# integrity methods.
#
# Vulnerability Discussion: The SNMP service must use SHA-1 or a FIPS 
# 140-2 approved successor for authentication and integrity.
#
# Responsibility: System Administrator
# IAControls: DCNR-1
#
# Check Content:
#
# Verify the SNMP daemon uses SHA for SNMPv3 users.

# Procedure:
# Examine the default install location /etc/snmp/snmpd.conf
# or:
# find / -name snmpd.conf 

# grep -v '^#' <snmpd.conf file> | grep -i createuser | grep -vi SHA
# If any line is present this is a finding.
#
# Fix Text: 
#
# Edit /etc/snmp/snmpd.conf and add the SHA keyword for any create user 
# statement without one.
# Restart the SNMP service.
# service snmpd restart   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN005306
	
# Start-Lockdown

