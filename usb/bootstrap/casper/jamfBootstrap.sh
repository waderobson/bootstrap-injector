#!/bin/bash
#
# Most of this was lifted from t-lark's auto_reenroll.sh
# https://github.com/JAMFSupport/autoenroll/blob/master/auto_reenroll.sh 
#

#### define user variables below:

#### start variables defined by the code and user variables

# location of the JAMF binary on any web app
jamfBinary="${jssURL}/bin/jamf.gz"

jssConnectionTest() {
jssTest=$(curl -k -I ${jssURL}/JSSResource/computers/id/1 | awk '/HTTP/ { print $2}')
if [[ ${jssTest} == '401' ]]
    then echo "we can connect to the JSS" 
else echo "JSS is not reachable...exiting"
    exit 0
fi
}
 
downloadBinary() {
curl -k --silent --retry 5 -o /tmp/jamf.gz ${jamfBinary}
}

jamfEnroll() {
if [[ -f /tmp/jamf.gz ]]
then 
    echo "looks good"
else 
    echo "failed to curl down binary"
exit 0
fi

gzip -d /tmp/jamf.gz
mv /tmp/jamf /usr/sbin/jamf
chown root:wheel /usr/sbin/jamf
chmod +rx /usr/sbin/jamf
jamf createConf -k -url ${jssURL}
jamf enroll -invitation ${invitationCode} -noRecon
}


jssConnectionTest
downloadBinary
jamfEnroll
# enable ssh
systemsetup -setremotelogin on

# Name the computer
# todo. come up with a universal namer for casper and munki 
jamf setComputerName -useSerialNumber

# This should probably be done by a package
jamf createAccount -username admin -realname administrator -password password -admin


# resets the all the policies for this machine on the server
jamf flushPolicyHistory

# Run the inventory
jamf recon

# enable jamfhelper for initial config.
# It will let you know is working. At the end of your 
# configuration policy make sure you kill it and delete it as mentioned 
# here -> https://jamfnation.jamfsoftware.com/discussion.html?id=24#responseChild151
# these three lines are needed to stop jamfhelper from loading. Put them at the end of your
# configuration policy
# ---------------
# killall -m jamfHelper                                          
# rm /Library/LaunchAgents/bsi.jamfhelper.plist             
# killall loginwindow
# ----------------
# cp casper/bsi.jamfhelper.plist /Library/LaunchAgents/






