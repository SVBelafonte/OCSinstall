#===============+
# OCS Installer |
#===============+

.PHONY  :   all prep display opencpn gpsd pisnes piready

usage   :
	clear
	@echo "+=================================+"
	@echo "| OnboardComputerSystem Installer |"
	@echo "+=================================+"
	@echo ""
	@echo "usage: make [ piready | ocs ] "
	@echo "   or: make [ prep | display | opencpn | gpsd | pisnes ] for specific parts"

#===============+
#    Strings    |
#===============+

USER=capn
HOME=/home/$(USER)/
INSTALL=/home/$(USER)/install/
OCS=~/OnboardComputerSystem/

#===============+
#    Recipes    |
#===============+

ocs: prep display gpsd opencpn
	@echo "prep display gpsd opencpn"

prep:
	@echo "#===============+"
	@echo "# Setup dirs    |"
	@echo "#===============+"
	#mkdir -p $(HOME)apps $(HOME)camera $(HOME)documents $(HOME)databases $(HOME).config
	#working
	@echo "#===============+"
	@echo "# Add groups    |"
	@echo "#===============+"
	#sudo usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio,pi $(USER)
	#working
	@echo "#===============+"
	@echo "# Install rxvt  |"
	@echo "#===============+"
	#sudo apt-get install rxvt-unicode -y
	#cp $(OCS)/.Xresources $(HOME)
	#sed -i -e "s,laserwolf,$(USER),g" $(HOME).Xresources
	#working
	@echo "#===============+"
	@echo "# Install rxvt  |"
	@echo "#===============+"
	#cp $(OCS).florence.conf $(HOME)
	#sudo apt-get install florence -y
	@echo "#===============+"
	@echo "# Clone OCS     |"
	@echo "#===============+"
	#git clone https://github.com/LASER-WOLF/OnboardComputerSystem
	#cp -r $(OCS).OnboardComputerSystem .
	#cp $(OCS).bash_aliases .
	#working
	@echo "#===============+"
	@echo "# Setup JTides  |"
	@echo "#===============+"
	#sudo apt-get install oracle-java8-jdk -y
	#cp -r $(OCS)Apps/JTides apps
	#working
	@echo "#===============+"
	@echo "# Moving PiSNES |"
	@echo "#===============+"
	#cp -r $(OCS)Apps/pisnes apps
	#working
	@echo "#===============+"
	@echo "# Moving scripts|"
	@echo "#===============+"
	#cp -r $(OCS)Scripts/ scripts
	#working
	#revisit and replace laserwolfs
	@echo "#===============+"
	@echo "# Get vim       |"
	@echo "#===============+"
	#sudo apt-get install vim -y
	#working
	@echo "#===============+"
	@echo "# Get htop      |"
	@echo "#===============+"
	#sudo apt-get install htop -y
	#working
	@echo "#===============+"
	@echo "# Get python    |"
	@echo "#===============+"
	#sudo apt-get install python python-dev python-smbus python-pip -y
	#sudo pip install ephem
	#working
	@echo "#===============+"
	@echo "# Get sqlite3   |"
	@echo "#===============+"
	#sudo apt-get install sqlite3 -y
	#working
	@echo "#===============+"
	@echo "# Get tint2     |"
	@echo "#===============+"
	#cp -r $(OCS).config/tint2/ .config/
	#sudo apt-get install tint2 -y
	#working
	@echo "#===============+"
	@echo "# Get lemonbar  |"
	@echo "#===============+"
	#sudo apt-get install libxcb-xinerama0-dev libxcb-randr0-dev libxft-dev libx11-xcb-dev -y
	#git clone https://github.com/krypt-n/bar
	#cd bar && sudo make install
	#cd
	#sudo rm -rf ~/bar/
	#working
	@echo "#===============+"
	@echo "# Get conky     |"
	@echo "#===============+"
	#sudo apt-get install conky -y
	#cp OnboardComputerSystem/.conkyrc $(HOME)
	#sed -i -e "s,laserwolf,$(USER),g" $(HOME).conkyrc
	#touch .conkytext
	#working
	@echo "#===============+"
	@echo "# Install theme |"
	@echo "#===============+"
	#cp -r $(OCS).fonts .fonts
	#cp -r $(OCS).themes .themes
	#cp -r $(OCS).icons .icons
	#cp $(OCS).gtkrc-2.0 .gtkrc-2.0
	#cp -r $(OCS).config/gtk-3.0 .config/gtk-3.0
	#working
	@echo "#===============+"
	@echo "# Setup I2C     |"
	@echo "#===============+"
	#sudo apt-get install i2c-tools -y
	#sudo sh -c "echo 'i2c-bcm2708' >> /etc/modules"
	#sudo sh -c "echo 'i2c-dev' >> /etc/modules"
	#working
	@echo "#===============+"
	@echo "# Setup I2C     |"
	@echo "#===============+"
	#sudo pip install RPi.GPIO
	#git clone https://github.com/adafruit/Adafruit_Python_CharLCD.git
	#cd Adafruit_Python_CharLCD && sudo python setup.py install
	#cd
	#sudo rm -rf ~/Adafruit_Python_CharLCD/
	#working
	#crontab ???
	@echo "#=========================+"
	@echo "# Setup BMP180 Barometric |"
	@echo "#=========================+"
	#git clone https://github.com/adafruit/Adafruit_Python_BMP.git
	#cd Adafruit_Python_BMP && sudo python setup.py install
	#cd
	#sudo rm -rf ~/Adafruit_Python_BMP/
	#working
	@echo "#====================+"
	@echo "# Sync NTP with GPSd |"
	@echo "#====================+"
	#sudo sed -i -e "s,=ntp,=root,g" /etc/init.d/ntp
	#sudo sed -i -e "/server 3/aserver 127.127.28.0\nfudge 127.127.28.0 refid GPS\nserver 127.127.28.1 prefer\nfudge 127.127.28.1 refid PPS" /etc/ntp.conf
	#working
	@echo "#===============+"
	@echo "# Install kplex |"
	@echo "#===============+"
	#git clone https://github.com/stripydog/kplex
	#cd kplex && make && sudo make install
	#cd
	#rm -rf kplex/
	#working
	@echo "#===============+"
	@echo "# Get Unclutter |"
	@echo "#===============+"
	#sudo apt-get install unclutter -y
	#working
	@echo "#===============+"
	@echo "# Install scrot |"
	@echo "#===============+"
	#sudo apt-get install scrot -y
	#working
	@echo "#===============+"
	@echo "# Get fswebcam  |"
	@echo "#===============+"
	#sudo apt-get install fswebcam -y
	#working
	@echo "#===============+"
	@echo "# Install Ranger|"
	@echo "#===============+"
	#sudo apt-get install ranger -y
	#working
	@echo "#===============+"
	@echo "# Get PCmanFM   |"
	@echo "#===============+"
	#mkdir -p $(HOME).config/pcmanfm/default/
	#cp $(OCS).config/pcmanfm/default/pcmanfm.conf $(HOME).config/pcmanfm/default/pcmanfm.conf
	#cp -r $(OCS).config/libfm/ $(HOME).config/libfm/
	#sudo apt-get install pcmanfm -y
	#working
	@echo "#===============+"
	@echo "# Install slurm |"
	@echo "#===============+"
	#sudo apt-get install slurm -y
	#working
	@echo "#===============+"
	@echo "# Get Epiphany  |"
	@echo "#===============+"
	#sudo apt-get install epiphany-browser -y
	#working
	@echo "#===============+"
	@echo "# Install VNC   |"
	@echo "#===============+"
	#sudo apt-get install x11vnc -y
	#use the vnc script to start the server
	#working
	@echo "#===============+"
	@echo "# Get Okular    |"
	@echo "#===============+"
	mkdir -p $(HOME).kde/share/config
	#cp $(OCS).kde/share/config/okularrc $(HOME).kde/share/config/okularrc
	#cp $(OCS).kde/share/config/okularpartrc $(HOME).kde/share/config/okularpartrc
	#sudo apt-get install okular -y
	#working
	@echo "#===============+"
	@echo "# Reboot?       |"
	@echo "#===============+"

opencpn:
	@echo "#=================+"
	@echo "# Install OpenCPN |"
	@echo "#=================+"
	#mkdir -p charts
	#cp -r $(OCS).opencpn .
	#sed -i -e "s,laserwolf,$(USER),g" $(HOME).opencpn/plugins/watchdog/WatchdogConfiguration.xml
	#sudo apt-get install build-essential cmake gettext git-core gpsd gpsd-clients libgps-dev wx-common libwxgtk3.0-dev libglu1-mesa-dev libgtk2.0-dev wx3.0-headers libbz2-dev libtinyxml-dev libportaudio2 portaudio19-dev libcurl4-openssl-dev libexpat1-dev libcairo2-dev -y
	#git clone git://github.com/OpenCPN/OpenCPN.git
	#cd OpenCPN && mkdir build && cd build && cmake ../ && make && sudo make install
	#This is gonna take a while...
	#cd
	#rm -rf ~/OpenCPN/
	#working
	@echo "#===================+"
	@echo "# OpenCPN: Watchdog |"
	@echo "#===================+"
	git clone git://github.com/seandepagnier/watchdog_pi.git
	cd watchdog_pi && mkdir build && cd build && cmake ../ && make && sudo make install
	cd
	rm -rf ~/watchdog_pi/
	@echo "#======================+"
	@echo "# OpenCPN: Climatology |"
	@echo "#======================+"
	git clone git://github.com/seandepagnier/climatology_pi.git
	cd climatology_pi && mkdir build && cd build && cmake ../ && make && sudo make install
	cd
	rm -rf ~/climatology_pi/
	sudo mkdir /usr/local/share/opencpn/plugins/climatology_pi
	sudo tar -C /usr/local/share/opencpn/plugins/climatology_pi -xvf OnboardComputerSystem/CL-DATA-1.0.tar.xz

display:
	@echo "#===============+"
	@echo "# Install xorg  |"
	@echo "#===============+"
	sudo apt-get install xorg -y
	cp -r $(OCS).config/openbox $(HOME).config/openbox
	cp $(OCS).config/user-dirs.dirs $(HOME).config
	sudo cp $(OCS)xorg.conf /etc/X11/
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).config/openbox/autostart
	@echo "#=================+"
	@echo "# Install openbox |"
	@echo "#=================+"
	sudo apt-get install openbox -y
	@echo "#=================+"
	@echo "# Install LightDM |"
	@echo "#=================+"
	sudo apt-get install lightdm -y
	sudo cp $(INSTALL)lightdm.conf /etc/lightdm/lightdm.conf
	sudo sed -i -e "s,laserwolf,$(USER),g" /etc/lightdm/lightdm.conf
	sudo cp $(INSTALL)bootconfig.txt /boot/config.txt
	sudo systemctl enable lightdm.service
	@echo "#===============+"
	@echo "# Reboot?       |"
	@echo "#===============+"

gpsd:
	sudo apt-get install gpsd gpsd-clients -y
	sudo cp $(OCS)gpsd /etc/default/gpsd
	@echo "#===============+"
	@echo "# Reboot?       |"
	@echo "#===============+"

zygrib:
	@echo "#===============+"
	@echo "# Get zyGrib    |"
	@echo "#===============+"
	mkdir $(HOME)GRIB
	sudo apt-get install build-essential g++ make libqt4-dev libbz2-dev zlib1g-dev libproj-dev libnova-dev nettle-dev -y
	tar xvzf $(OCS)zyGrib-7.0.0.tgz
	cd zyGrib-7.0.0 && make
#Edit Makefile:
#vim Makefile
#Find the line:
#INSTALLDIR=$(HOME)/zyGrib
#Replace it with (change laserwolf with your username):
#INSTALLDIR=/home/laserwolf/Apps/zyGrib
#Save the file and exit
#sudo make install
#cd
#rm -rf ~/zyGrib-7.0.0/
#mkdir -p ~/.zygrib/config/
#cp OnboardComputerSystem/zygrib.ini .zygrib/config/zygrib.ini
#Edit zygrib.ini:
#vim .zygrib/config/zygrib.ini
#Find the line:
#gribFilePath=/home/laserwolf/GRIB
#Replace laserwolf with your username
#Save the file and exit
#Press the GRIB button on the top menu to test zyGrib

pisnes:
	sudo apt-get install libsdl1.2debian joystick -y
	mkdir $(HOME)apps/pisnes/roms

piready:
	@echo "#===============+"
	@echo "# Install git   |"
	@echo "#===============+"
	sudo apt-get install build-essential git -y
	@echo "#===============+"
	@echo "# Updating OS   |"
	@echo "#===============+"
	sudo apt-get update
	@echo "#===============+"
	@echo "# Upagrading OS |"
	@echo "#===============+"
	sudo apt-get upgrade
	@echo "#===============+"
	@echo "# Pi Update...  |"
	@echo "#===============+"
	sudo apt-get install rpi-update -y
	@echo "#===============+"
	@echo "# Updating Pi   |"
	@echo "#===============+"
	sudo rpi-update
	@echo "#===============+"
	@echo "# Hide Pi Logos |"
	@echo "#===============+"
	sudo sed -i ' 1 s/.*/& logo.nologo/' /boot/cmdline.txt
	@echo ""
	@echo "#===============+"
	@echo "# Please Reboot |"
	@echo "#===============+"

