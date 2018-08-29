#!/bin/bash

## Force the user to run the script with root privileges
if [[ $(whoami) != root ]]; then
        echo -e "\033[1;33mYou must run this script as root or with sudo privileges!\033[1;00m"
        echo -e "\033[1;33mRestarting with sudo\033[1;00m"
        sudo "$0"
        exit $?
fi

## Define bin
APT="$(which apt-get)"
DPKG="$(which dpkg)"
SERVICE="$(which service)"
EPPCLIENTDAEMON=epp-client-daemon-d

## Begin installation with prerequisites
echo 'Begin EPP Client Uninstall'

## Check if epp-client already installed
EPPINSTALLED="$($DPKG -l | grep epp-client | awk '{print $3}' | head -1)"
if [ "$EPPINSTALLED" != "" ]; then
	echo "epp-client is installed. Proceeding with uninstall"
	echo "Stopping $EPPCLIENTDAEMON"
	$SERVICE $EPPCLIENTDAEMON stop
	echo "Uninstalling epp-client"
	$DPKG --purge epp-client
	$DPKG --purge epp-client-config
	$DPKG --purge epp-client-cap-def
	$DPKG --purge cososys-filesystem
	sudo rm -rf /opt/cososys
	sudo rm -rf /var/opt/cososys
	sudo rm -rf /var/log/epp-client
	sudo rm -f /etc/init.d/epp-client-daemon-d
	sudo kill -9 $(ps aux | grep [e]pp-client | awk '{print $2}')
	sudo kill -9 $(ps aux | grep [c]heck-eppclient-process.sh | awk '{print $2}') 
	killall -TERM epp-client
	sudo rm -f /etc/init.d/check-eppclient-process.sh
	sudo crontab -u root -l | sed 's/.*check-eppclient-process.sh.*$//g' | crontab -u root -
	echo
	echo -e "\033[1;34mEpp-client successfully uninstalled!\033[1;00m"
	echo
	exit 1
else
	echo
	echo -e "\033[1;34mEpp-client package is not installed. Nothing to do...\033[1;00m"
	echo
fi
