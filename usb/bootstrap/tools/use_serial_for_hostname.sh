# name says it all really
#
serial=$(ioreg -l |grep "IOPlatformSerialNumber"|cut -d ""="" -f 2|sed -e s/[^[:alnum:]]//g)

/usr/sbin/scutil --set ComputerName "${serial}"

/usr/sbin/scutil --set LocalHostName "${serial}"

/usr/sbin/scutil --set HostName "${serial}"
