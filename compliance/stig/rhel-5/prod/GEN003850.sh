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
# Group ID (Vulid): V-24386
# Group Title: GEN003850
# Rule ID: SV-37444r1_rule
# Severity: high
# Rule Version (STIG-ID): GEN003850
# Rule Title: The telnet daemon must not be running.
#
# Vulnerability Discussion: The telnet daemon provides a typically 
# unencrypted remote access service which does not provide for the 
# confidentiality and integrity of user passwords or the remote session.  
# If a privileged user were to log on using this service, the privileged 
# user password could be compromised.
#
# Responsibility: System Administrator
# IAControls: DCPP-1
#
# Check Content:
#
# The telnet service included in the RHEL distribution is part of 
# krb5-workstation. There are two versions of telnetd server provided. The 
# xinetd.d file ekrb5-telnet allows only connections authenticated through 
# kerberos. The xinetd.d krb5-telnet allows normal telnet connections as 
# well as kerberized connections. Both are set to "disable = yes" by 
# default. Ensure that neither is running.

# Procedure:
# Check if telnetd is running:

# ps -ef |grep telnetd

# If the telnet daemon is running, this is a finding.

# Check if telnetd is enabled on startup:

# chkconfig --list|grep telnet

# If an entry with "on" is found, this is a finding.
#
# Fix Text: 
#
# Identify the telnet service running and disable it.

# Procedure:

# Disable the telnet server.
# chkconfig telnet off

# Verify the telnet daemon is no longer running.
# ps -ef |grep telnet  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003850
	
# Start-Lockdown
#Check if telnet installed
for TELNETCONF in `ls /etc/xinetd.d/*telnet*`
do
  if [ -e $TELNETCONF ]
  then
    sed -i 's/[[:blank:]]*disable[[:blank:]]*=[[:blank:]]*no/        disable                 = yes/g' $TELNETCONF
  fi
done
