#!/bin/bash

## Define bin
APT="$(which apt-get)"
DPKG="$(which dpkg)"
CAT="$(which cat)"
SERVICE="$(which service)"
path=$(dirname $0)
EPPCLIENTDAEMON=epp-client-daemon-d
DEP_PATH=$path/deps
PKGS_PATH=$path/pkgs
CONFIGPATH=/opt/cososys/share/apps/epp-client
CONFIGFILE=options.ini
ARCH="$(/bin/uname -m)"
R='\033[0;31m'
G='\033[0;32m'
B='\033[0;34m'
NC='\033[0m'

## Begin installation with prerequisites
echo -e "${G}Begin EPP Client installation${NC}"

## Check if epp-client already installed

EPPINSTALLED="$(sudo $DPKG -l | awk '{print $2}'| grep '^epp-client$')"
if [ "$EPPINSTALLED" != '' ]; then
    EPPSTATUS="$(sudo $DPKG -l | grep 'epp-client' | awk '{print $1}' | head -1)"
    if [ "$EPPSTATUS" == "ii" -o "$EPPSTATUS" == "iU" ]; then
        echo -e "${G}EPP Client is installed. Updating options.ini...${NC}"
        echo "Stopping $EPPCLIENTDAEMON"
        sudo $SERVICE $EPPCLIENTDAEMON stop
        echo "Changing $CONFIGPATH/$CONFIGFILE with content:"
        sudo $CAT $path/$CONFIGFILE
	sudo chmod 777 $CONFIGPATH/$CONFIGFILE
        sudo $CAT $path/$CONFIGFILE > $CONFIGPATH/$CONFIGFILE
        echo "Starting $EPPCLIENTDAEMON"
        sudo $SERVICE $EPPCLIENTDAEMON start > /dev/null 2>&1 &
	if [ $(whoami) != root ]; then
		echo
		echo 
		echo -e "${B}Options.ini updated!${NC}"
		echo
		else
		echo		
		echo -e "${B}To activate the client notifier on logged user${NC}"
		echo -e "${B}please run: /opt/cososys/bin/epp-client &${NC}"
		echo
	fi
        exit 1
    
    fi
fi

echo -e "${G}Installing CoSoSys related packages for EPP-Client${NC}"
            
	    sudo $DPKG -i $PKGS_PATH/cososys-filesystem_1.0.0-0ubuntu1_all.deb
            sudo $DPKG -i $PKGS_PATH/epp-client-cap-def_1.0.5-0ubuntu1_all.deb
            sudo $DPKG -i $PKGS_PATH/epp-client-config_1.0.2-0ubuntu1_all.deb
        

if [ "$ARCH" == "x86_64" ]; then
            echo -e "${G}Installing $ARCH packages...${NC}"
	    sudo apt-get install -y gdebi
	    #sudo $DPKG -i $PKGS_PATH/libtinyxml2.6.2v5_2.6.2-3_amd64.deb
        else
            echo -e "${G}No EPPClient $ARCH availabel in this version!${NC}"
	    #echo -e "${G}Installing $ARCH packages...${NC}"
	    #sudo apt-get install -y gdebi
            #sudo $DPKG -i $PKGS_PATH/libtinyxml2.6.2v5_2.6.2-3_i386.deb
        fi

echo -e "${G}Changing config file to match IP/PORT/Department with provided values${NC}"
$CAT $path/$CONFIGFILE | sudo tee -a $CONFIGPATH/$CONFIGFILE

if [ "$ARCH" == "x86_64" ]; then
   echo -e "${G}Installing EPP Client $ARCH ${NC}"
   sudo gdebi -n $PKGS_PATH/epp-client_1.3.0-0ubuntu1_amd64.deb
   #sudo $DPKG -i $PKGS_PATH/epp-client_1.3.0-0ubuntu1_amd64.deb
   #sudo apt-get install -f -y
else
   echo -e "${G}No EPPClient $ARCH availabel in this version!${NC}"
   #sudo gdebi -n $PKGS_PATH/epp-client_1.3.0-0ubuntu1_i386.deb
   #sudo $DPKG -i $PKGS_PATH/epp-client_1.3.0-0ubuntu1_i386.deb
   #sudo apt-get install -f -y
   exit 1 
fi

sudo cp $PKGS_PATH/check-eppclient-process.sh /opt/cososys/check-eppclient-process.sh
sudo chmod 755 /opt/cososys/check-eppclient-process.sh
(sudo /usr/bin/crontab -u root -l; sudo /bin/echo "* * * * * /opt/cososys/check-eppclient-process.sh & > /dev/null 2>&1") | sudo /usr/bin/crontab -u root -

echo
echo
echo -e "${B}Epp client successfully installed!${NC}"
echo


CURRENT_USER=$(whoami)
if [ $(whoami) != root ]; then
/opt/cososys/bin/epp-client > /dev/null 2>&1 &
else
echo -e "${B}To activate the client notifier ${NC}"
echo -e "${B}please go to Dash and search for Endpoint Protector Notifier!${NC}"
echo
fi

exit

