################################################################
## Makefile for OCSinstall
################################################################
## Definitions
################################################################
.SILENT:
SHELL     := /bin/bash
.PHONY: all clean prep display opencpn gpsd pisnes piready
################################################################
## Name list
################################################################
USER     = capn
HOME     = /home/$(USER)/
INSTALL  = $(HOME)install/
OCS      = $(HOME)OnboardComputerSystem/
################################################################
## Colordefinition
################################################################
NO       = \x1b[0m
OK       = \x1b[32;01m
WARN     = \x1b[33;01m
ERROR    = \x1b[31;01m
################################################################
## make help
################################################################
help:
	@echo
	@echo -e "$(WARN)The following definitions provided by this Makefile"
	@echo -e "$(OK)\tmake piready\t\t--\tready your pi"
	@echo -e "\tmake prep\t\t--\tOCS prep"
	@echo -e "\tmake display\t\t--\tOCS display"
	@echo -e "\tmake opencpn\t\t--\tOCS OpenCPN"
	@echo -e "\tmake gpsd\t\t--\tOCS gpsd"
	@echo -e "\tmake zygrib\t\t--\tOCS zyGrib"
	@echo -e "\tmake all\t\t--\tprep display gpsd zyGrib OpenCPN"
	@echo
################################################################
## recipes
################################################################
all: prep display gpsd zygrib opencpn

prep:
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Setup dirs      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	mkdir -p $(HOME)apps $(HOME)camera $(HOME)documents $(HOME)databases $(HOME).config > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Add groups      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio,pi $(USER) > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Install rxvt     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install rxvt-unicode -y > /dev/null ;\
	cp $(OCS)/.Xresources $(HOME) > /dev/null ;\
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).Xresources > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|   Install Florence   +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	cp $(OCS).florence.conf $(HOME) > /dev/null ;\
	sudo apt-get install florence -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Install OCS      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	git clone https://github.com/LASER-WOLF/OnboardComputerSystem &> /dev/null ;\
	cp -r $(OCS).OnboardComputerSystem $(HOME) > /dev/null ;\
	cp $(OCS).bash_aliases $(HOME) > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Setup JTides     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install oracle-java8-jdk -y > /dev/null ;\
	cp -r $(OCS)Apps/JTides apps > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|  Moving OCS Scripts  +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	cp -r $(OCS)Scripts/* $(HOME)scripts > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|       Get vim        +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install vim -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|       Get htop       +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install htop -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Get python      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install python python-dev python-smbus python-pip -y > /dev/null ;\
	sudo pip install ephem > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Get sqlite3     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install sqlite3 -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Get tint2       +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	cp -r $(OCS).config/tint2/ .config/ > /dev/null ;\
	sudo apt-get install tint2 -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Get lemonbar     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install libxcb-xinerama0-dev libxcb-randr0-dev libxft-dev libx11-xcb-dev -y > /dev/null ;\
	git clone https://github.com/krypt-n/bar &> /dev/null ;\
	cd bar && sudo make install > /dev/null ;\
	cd > /dev/null ;\
	sudo rm -rf ~/bar/ > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Get conky       +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install conky -y > /dev/null ;\
	cp OnboardComputerSystem/.conkyrc $(HOME) > /dev/null ;\
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).conkyrc > /dev/null ;\
	touch $(HOME).conkytext > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|    Install Theme     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	cp -r $(OCS).fonts $(HOME).fonts > /dev/null ;\
	cp -r $(OCS).themes $(HOME).themes > /dev/null ;\
	cp -r $(OCS).icons $(HOME).icons > /dev/null ;\
	cp $(OCS).gtkrc-2.0 $(HOME).gtkrc-2.0 > /dev/null ;\
	cp -r $(OCS).config/gtk-3.0 $(HOME).config/gtk-3.0 > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Setup I2C       +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install i2c-tools -y > /dev/null ;\
	sudo sh -c "echo 'i2c-bcm2708' >> /etc/modules" > /dev/null ;\
	sudo sh -c "echo 'i2c-dev' >> /etc/modules" > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Setup LCD       +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo pip install RPi.GPIO > /dev/null ;\
	git clone https://github.com/adafruit/Adafruit_Python_CharLCD.git &> /dev/null ;\
	cd Adafruit_Python_CharLCD && sudo python setup.py install &> /dev/null ;\
	cd > /dev/null ;\
	sudo rm -rf ~/Adafruit_Python_CharLCD/ > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	#crontab ???
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|   Setup Barometer    +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	git clone https://github.com/adafruit/Adafruit_Python_BMP.git &> /dev/null ;\
	cd Adafruit_Python_BMP && sudo python setup.py install &> /dev/null ;\
	cd > /dev/null ;\
	sudo rm -rf ~/Adafruit_Python_BMP/ > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Syncing NTP      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo sed -i -e "s,=ntp,=root,g" /etc/init.d/ntp > /dev/null ;\
	sudo sed -i -e "/server 3/aserver 127.127.28.0\nfudge 127.127.28.0 refid GPS\nserver 127.127.28.1 prefer\nfudge 127.127.28.1 refid PPS" /etc/ntp.conf > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|    Install kplex     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	git clone https://github.com/stripydog/kplex &> /dev/null ;\
	cd kplex && make && sudo make install > /dev/null ;\
	cd > /dev/null ;\
	rm -rf kplex/ > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|    Get Unclutter     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install unclutter -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|    Install scrot     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install scrot -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Get fswebcam     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install fswebcam -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|    Install Ranger    +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install ranger -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Get PCmanFM      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	mkdir -p $(HOME).config/pcmanfm/default/ > /dev/null ;\
	cp $(OCS).config/pcmanfm/default/pcmanfm.conf $(HOME).config/pcmanfm/default/pcmanfm.conf > /dev/null ;\
	cp -r $(OCS).config/libfm/ $(HOME).config/libfm/ > /dev/null ;\
	sudo apt-get install pcmanfm -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|    Install slurm     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install slurm -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Get Epiphany     +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install epiphany-browser -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|     Install VNC      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	sudo apt-get install x11vnc -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|      Get Okular      +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	mkdir -p $(HOME).kde/share/config > /dev/null ;\
	cp $(OCS).kde/share/config/okularrc $(HOME).kde/share/config/okularrc > /dev/null ;\
	cp $(OCS).kde/share/config/okularpartrc $(HOME).kde/share/config/okularpartrc > /dev/null ;\
	sudo apt-get install okular -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        Reboot        +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo "" ;\

opencpn:
	echo -e "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|   Install OpenCPN    +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	mkdir -p charts > /dev/null ;\
	cp -r $(OCS).opencpn $(HOME) > /dev/null ;\
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).opencpn/plugins/watchdog/WatchdogConfiguration.xml > /dev/null ;\
	sudo apt-get install build-essential cmake gettext git-core gpsd gpsd-clients libgps-dev wx-common libwxgtk3.0-dev libglu1-mesa-dev libgtk2.0-dev wx3.0-headers libbz2-dev libtinyxml-dev libportaudio2 portaudio19-dev libcurl4-openssl-dev libexpat1-dev libcairo2-dev -y > /dev/null ;\
	git clone git://github.com/OpenCPN/OpenCPN.git &> /dev/null ;\
	echo -e "$(WARN)| This Takes 1-2 Hours +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	cd OpenCPN && mkdir build && cd build && cmake ../ && make && sudo make install > /dev/null ;\
	cd > /dev/null ;\
	rm -rf ~/OpenCPN/ > /dev/null ;\
	working
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|  OpenCPN: Watchdog   +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	git clone git://github.com/seandepagnier/watchdog_pi.git &> /dev/null ;\
	cd watchdog_pi && mkdir build && cd build && cmake ../ && make && sudo make install > /dev/null ;\
	cd > /dev/null ;\
	rm -rf ~/watchdog_pi/ > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)| OpenCPN: Climatology +$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	git clone git://github.com/seandepagnier/climatology_pi.git &> /dev/null ;\
	cd climatology_pi && mkdir build && cd build && cmake ../ && make && sudo make install > /dev/null ;\
	cd > /dev/null ;\
	rm -rf ~/climatology_pi/ > /dev/null ;\
	sudo mkdir /usr/local/share/opencpn/plugins/climatology_pi > /dev/null ;\
	sudo tar -C /usr/local/share/opencpn/plugins/climatology_pi -xvf OnboardComputerSystem/CL-DATA-1.0.tar.xz > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|         $(OK)OK!          $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	else \
	echo -e "$(WARN)+======================+$(NO)" ;\
	echo -e "$(WARN)|        $(ERROR)ERROR!        $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+======================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\

display:
	echo -e "" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)| Installing xorg +$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	sudo apt-get install xorg -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|       $(OK)OK!       $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	else \
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)|      $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)|  Setup openbox  +$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	cp -r $(OCS).config/openbox $(HOME).config/openbox > /dev/null ;\
	cp $(OCS).config/user-dirs.dirs $(HOME).config > /dev/null ;\
	sudo cp $(OCS)xorg.conf /etc/X11/ > /dev/null ;\
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).config/openbox/autostart > /dev/null ;\
	sudo apt-get install openbox -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|       $(OK)OK!       $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	else \
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)|      $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)|  Setup LightDM  +$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	sudo apt-get install lightdm -y > /dev/null ;\
	sudo cp $(INSTALL)lightdm.conf /etc/lightdm/lightdm.conf > /dev/null ;\
	sudo sed -i -e "s,laserwolf,$(USER),g" /etc/lightdm/lightdm.conf > /dev/null ;\
	sudo cp $(INSTALL)bootconfig.txt /boot/config.txt > /dev/null ;\
	sudo systemctl enable lightdm.service > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|       $(OK)OK!       $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	else \
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)|      $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\

gpsd:
	echo -e "" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)| Installing gpsd +$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	sudo apt-get install gpsd gpsd-clients -y > /dev/null ;\
	sudo cp $(OCS)gpsd /etc/default/gpsd > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|       $(OK)OK!       $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	else \
	echo -e "$(WARN)+=================+$(NO)" ;\
	echo -e "$(WARN)|      $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+=================+$(NO)" ;\
	exit 0;\
	fi ;\
	echo "" ;\

zygrib:
	echo -e "" ;\
	echo -e "$(WARN)+===================+$(NO)" ;\
	echo -e "$(WARN)| Installing zyGrib +$(NO)" ;\
	echo -e "$(WARN)+===================+$(NO)" ;\
	mkdir -p $(HOME)GRIB > /dev/null ;\
	sudo apt-get install build-essential g++ make libqt4-dev libbz2-dev zlib1g-dev libproj-dev libnova-dev nettle-dev -y > /dev/null ;\
	tar xvzf $(OCS)zyGrib-7.0.0.tgz > /dev/null ;\
	cd zyGrib-7.0.0 && make && sed -i -e 's,$$(HOME),$(HOME)apps,g' $(HOME)zyGrib-7.0.0/Makefile && sudo make install > /dev/null ;\
	cd > /dev/null ;\
	rm -rf $(HOME)zyGrib-7.0.0 > /dev/null ;\
	mkdir -p $(HOME).zygrib/config/ > /dev/null ;\
	cp $(OCS)zygrib.ini $(HOME).zygrib/config/ > /dev/null ;\
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).zygrib/config/zygrib.ini > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)Install zyGrib $(OK)[OK]$(NO)" ;\
	else \
	echo -e "$(WARN)Install zyGrib $(ERROR)[ERROR]$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\

pisnes:
	sudo apt-get install libsdl1.2debian joystick -y
	cp -r $(OCS)Apps/pisnes apps
	mkdir $(HOME)apps/pisnes/roms

piready:
	echo -e "" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|  Getting git  +$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	sudo apt-get install build-essential git -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|      $(OK)OK!      $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	else \
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|    $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)| Updating OS   +$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	sudo apt-get update -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|      $(OK)OK!      $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	else \
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|    $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)| Upgrading OS  +$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	sudo apt-get upgrade -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|      $(OK)OK!      $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	else \
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|    $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|  rpi-update   +$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	sudo apt-get install rpi-update -y > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|      $(OK)OK!      $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	else \
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|    $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|  rpi-update   +$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	sudo rpi-update > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|      $(OK)OK!      $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	else \
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|    $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)| Hide Pi Logos +$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	sudo sed -i ' 1 s/.*/& logo.nologo/' /boot/cmdline.txt > /dev/null ;\
	if [ $$? = 0 ] ; then \
	echo -e "$(WARN)|      $(OK)OK!      $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	else \
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|    $(ERROR)ERROR!     $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	exit 0;\
	fi ;\
	echo -e "" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "$(WARN)|    $(OK)Reboot!    $(WARN)+$(NO)" ;\
	echo -e "$(WARN)+===============+$(NO)" ;\
	echo -e "" ;\

