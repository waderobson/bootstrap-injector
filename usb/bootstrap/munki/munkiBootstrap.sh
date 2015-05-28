
# Download munkitools pkg
curl ${MUNKI_TOOLS_URL} -o /tmp/munkitools.pkg

# Install munkitools pkg
/usr/sbin/installer -pkg /tmp/munkitools.pkg -target /

# Setup client preferences
defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL ${MUNKI_REPO}
defaults write /Library/Preferences/ManagedInstalls ClientIdentifier ${MUNKI_MANIFEST}
defaults write /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates -bool true

# Install munki report
/bin/bash -c "$(curl -s ${MUNKI_REPORT_SERVER}/index.php?/install)"

# Create bootstrap file
touch '/Users/Shared/.com.googlecode.munki.checkandinstallatstartup'