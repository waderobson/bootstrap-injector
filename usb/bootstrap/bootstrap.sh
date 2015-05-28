#!/bin/bash
#
#
#
# Hostname to ping. could be google 
# could be your munki server
HOST='google.ca'

# ################ MUNKI STUFF #######################
# URL that points to munkitools pkg
MUNKI_TOOLS_URL='https://munkibuilds.org/munkitools2-latest.pkg'
MUNKI_REPO='http://10.0.10.192/munki'
MUNKI_MANIFEST='general'
MUNKI_REPORT_SERVER='http://10.0.10.192/munki/report'

# ############# CASPER STUFF ######################
# the URL of your JSS, if you are behind a load balancer you can use the URL and do not put a slash on the end
# example = https://myjss.company.com:8443
jssURL=''

# an inviation code from a quickadd package generated from Recon.app
invitationCode=''
# ##################################################

# Uncomment if you want to use wifi
# . tools/wifi/install_wifi.sh

# Load all the common stuff
. tools/clear_reg.sh
. tools/enable_external_network_adapter.sh
. tools/disable_apple_icloud_and_diagnostic_pop_ups.sh
. tools/wait_for_network.sh

#####  
# This is where you chose 
# The management you want to use

# Include Munki
. munki/munkiBootstrap.sh

# Include Casper
# . casper/jamfBootstrap.sh

# Clean up
rm /Library/LaunchDaemons/bsi.launchd.plist
rm -rf /Library/Scripts/bootstrap
rm $0

reboot
exit 0