About
This package provides the scripts to install/uninstall/update the epp-client (release) on Ubuntu 14.04.
It contains the pkg dependencies required to install the epp-client on Ubuntu 14.04 on both i386 and 
amd64 platforms and 2 bash scripts (install.sh and uninstall.sh) and a text file (options.ini) that 
contains the server address and port + the departament code.

Usage
	Installation:
		Make sure you have execution rights on install.sh (chmod);
		Epp-client must not be installed at the moment of running "install.sh" (see Update)
		Run: "./install.sh";
		If the user is not root, the sudo password will be required;
		If the user is root, the epp-client GUI will have to be started manually,
		but it will start automatically at restart for the current user.
		
	Update:
		If the epp-client is already installed, the user can update the "options.ini" data
		of the current installed epp-client by overwriting it with the one provided in the 
		installation folder. This is done by running "./install.sh";
		If the user is not root, the sudo password will be required;
		If the user is root, the epp-client GUI will have to be started manually after update,
		but it will start automatically at restart for the current user;
		The "./install.sh" command will try to reinstall the epp-client package if it 
		encounters errors with the current installed version of epp-client.
		
	Uninstallation:
		Make sure you have execution rights on uninstall.sh (chmod);
		If the user is not root, the sudo password will be required;
		If the epp-client is installed, running the "./uninstall.sh" will uninstall it;
		If the epp-client is not installed, running the "./uninstall.sh" will not change anything.
	