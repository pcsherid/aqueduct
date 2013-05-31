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
# Group ID (Vulid): V-941
# Group Title: GEN006600
# Rule ID: SV-37757r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN006600
# Rule Title: The system's access control program must log each system 
# access attempt.
#
# Vulnerability Discussion: If access attempts are not logged, then 
# multiple attempts to log on to the system by an unauthorized user may go 
# undetected.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# The tcp_wrappers package is provided with the RHEL distribution. Other 
# access control programs may be available but will need to be checked 
# manually.

# Normally, tcpd logs to the mail facility in "/etc/syslog.conf". Determine 
# if syslog is configured to log events by tcpd.

# Procedure:
# more /etc/syslog.conf

# Look for entries similar to the following:
# mail.debug                         /var/adm/maillog
# mail.none                   /var/adm/maillog
# mail.*                               /var/log/mail
# authpriv.info                         /var/log/messages

# The above entries would indicate mail alerts are being logged. If no 
# entries for mail exist, then tcpd is not logging this is a finding.

# If an alternate access control program is used and it does not provide 
# logging of access attempts, this is a finding.


#
# Fix Text: 
#
# Configure the access restriction program to log every access attempt. 
# Ensure the implementation instructions for tcp_wrappers are followed so 
# system access attempts are recorded to the system log files. If an 
# alternate application is used, it must support this function.  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN006600
# The mail.none makes no sense as the results will be the opposite of what 
# you want. On testing various service log to different facilityes of which
# none seem to goto mail.  xinetd logs failed attempts to the 'daemon' facility
# and sshd logs failed attempts to the 'authpriv' facility. You can set
# the severity in the default deny and allow rules, but depending on the 
# application it may or may not use it. I will probably use authpriv.info
# in GEN006620 as a default for applications that do use the setting. We will
# keep the maillog setting to keep scanners happy.  

MAILDEBUG=$( cat /etc/syslog.conf |egrep -i '(mail\.\*|mail\.debug)' | grep -v '^#' | wc -l )
MAILNONE=$( cat /etc/syslog.conf |egrep -i '(mail\.\*|mail\.none)' | grep -v '^#' | wc -l )
MAILALL=$( cat /etc/syslog.conf |egrep -i '(mail\.\*|mail\.*)' | grep -v '^#' | wc -l )
AUTHPRIV=$( cat /etc/syslog.conf |egrep -i '(authpriv\.\*|authpriv\.info)' | grep -v '^#' | wc -l )

#Start-Lockdown

if [ $MAILDEBUG -eq 0 ]
  then
  echo "#Added for Disa GEN006600" >> /etc/syslog.conf
  echo "mail.debug							-/var/log/maillog"  >> /etc/syslog.conf
fi

if [ $MAILNONE -eq 0 ]
  then
  echo "#Added for Disa GEN006600" >> /etc/syslog.conf
  echo "mail.none							-/var/log/maillog"  >> /etc/syslog.conf
fi

if [ $MAILALL -eq 0 ]
  then
  echo "#Added for Disa GEN006600" >> /etc/syslog.conf
  echo "mail.*							-/var/log/mail"  >> /etc/syslog.conf
fi

if [ $MAILALL -eq 0 ]
  then
  echo "#Added for Disa GEN006600" >> /etc/syslog.conf
  echo "authpriv.info							-/var/log/messages"  >> /etc/syslog.conf
fi




