# Don't go further unless we can ping 
# Something

while true
do 
ping -c1 ${HOST}
if [ "$?" = 0 ]
	then
	break
fi
sleep 3
#reboot
done