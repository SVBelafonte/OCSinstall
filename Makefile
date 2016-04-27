################################################################
## Makefile for OnboardComputerSystem
################################################################
## Definitions
################################################################
.SILENT:
SHELL     := /bin/bash
.PHONY: all clean prep display opencpn gpsd cmus pisnes piready
################################################################
## Names
################################################################
USER     = capn
HOME     = /home/$(USER)/
INSTALL  = $(HOME)install/
OCS      = $(HOME)OnboardComputerSystem/
################################################################
## Colors
################################################################
NO       = \x1b[0m
OK       = \x1b[32;01m
WARN     = \x1b[33;01m
ERROR    = \x1b[31;01m
################################################################
## Help
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
## Definitions
################################################################
define app_in
  echo "";
  echo -e "$(WARN)[] $1$(NO)"
endef
define app_out
if [ $1 = 0 ] ; then \
  echo -e "$(OK)[] OK!$(NO)"; \
  echo ""; \
  else \
  echo -e "$(ERROR)[] ERROR!$(NO)"; \
  echo ""; \
  exit 0; \
  fi
endef
################################################################
## Recipes
################################################################
all: prep display gpsd zygrib opencpn

prep:
	$(call app_in,"Get OnboardComputerSystem"); \
	sudo usermod -a -G adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio,pi $(USER) > /dev/null; \
	git clone https://github.com/LASER-WOLF/OnboardComputerSystem &> /dev/null; \
	cp -r $(OCS).OnboardComputerSystem $(HOME) > /dev/null; \
	cp $(OCS).bash_aliases $(HOME) > /dev/null; \
	mkdir -p $(HOME)apps $(HOME)camera $(HOME)documents $(HOME)databases $(HOME).config > /dev/null; \
	cp -r $(OCS)Scripts/* $(HOME)scripts > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install rxvt"); \
	sudo apt-get install rxvt-unicode -y > /dev/null; \
	cp $(OCS)/.Xresources $(HOME) > /dev/null; \
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).Xresources > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install Florence"); \
	cp $(OCS).florence.conf $(HOME) > /dev/null; \
	sudo apt-get install florence -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install JTides"); \
	sudo apt-get install oracle-java8-jdk -y > /dev/null; \
	cp -r $(OCS)Apps/JTides apps > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get vim"); \
	sudo apt-get install vim -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install htop"); \
	sudo apt-get install htop -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get python"); \
	sudo apt-get install python python-dev python-smbus python-pip -y > /dev/null; \
	sudo pip install ephem > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install sqlite3"); \
	sudo apt-get install sqlite3 -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get tint2"); \
	cp -r $(OCS).config/tint2/ .config/ > /dev/null; \
	sudo apt-get install tint2 -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install lemonbar"); \
	sudo apt-get install libxcb-xinerama0-dev libxcb-randr0-dev libxft-dev libx11-xcb-dev -y > /dev/null; \
	git clone https://github.com/krypt-n/bar &> /dev/null; \
	cd bar && sudo make install > /dev/null; \
	cd; \
	sudo rm -rf ~/bar/ > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get conky"); \
	sudo apt-get install conky -y > /dev/null; \
	cp OnboardComputerSystem/.conkyrc $(HOME) > /dev/null; \
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).conkyrc > /dev/null; \
	touch $(HOME).conkytext > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Installing Fonts, Themes, Icons"); \
	cp -r $(OCS).fonts $(HOME).fonts > /dev/null; \
	cp -r $(OCS).themes $(HOME).themes > /dev/null; \
	cp -r $(OCS).icons $(HOME).icons > /dev/null; \
	cp $(OCS).gtkrc-2.0 $(HOME).gtkrc-2.0 > /dev/null; \
	cp -r $(OCS).config/gtk-3.0 $(HOME).config/gtk-3.0 > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Setup I2C"); \
	sudo apt-get install i2c-tools -y > /dev/null; \
	sudo sh -c "echo 'i2c-bcm2708' >> /etc/modules" > /dev/null; \
	sudo sh -c "echo 'i2c-dev' >> /etc/modules" > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Setup LCD"); \
	sudo pip install RPi.GPIO > /dev/null; \
	git clone https://github.com/adafruit/Adafruit_Python_CharLCD.git &> /dev/null; \
	cd Adafruit_Python_CharLCD && sudo python setup.py install &> /dev/null; \
	cd; \
	sudo rm -rf $(HOME)Adafruit_Python_CharLCD/ > /dev/null; \
	#crontab ???
	$(call app_out, $$?)
	$(call app_in,"Setup Barometer"); \
	git clone https://github.com/adafruit/Adafruit_Python_BMP.git &> /dev/null; \
	cd Adafruit_Python_BMP && sudo python setup.py install &> /dev/null; \
	cd; \
	sudo rm -rf $(HOME)Adafruit_Python_BMP/ > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Syncing NTP"); \
	sudo sed -i -e "s,=ntp,=root,g" /etc/init.d/ntp > /dev/null; \
	sudo sed -i -e "/server 3/aserver 127.127.28.0\nfudge 127.127.28.0 refid GPS\nserver 127.127.28.1 prefer\nfudge 127.127.28.1 refid PPS" /etc/ntp.conf > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install kplex"); \
	git clone https://github.com/stripydog/kplex &> /dev/null; \
	cd kplex && make && sudo make install > /dev/null; \
	cd; \
	rm -rf kplex/ > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get Unclutter"); \
	sudo apt-get install unclutter -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install scrot"); \
	sudo apt-get install scrot -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get fswebcam"); \
	sudo apt-get install fswebcam -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install Ranger"); \
	sudo apt-get install ranger -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get PCmanFM"); \
	mkdir -p $(HOME).config/pcmanfm/default/ > /dev/null; \
	cp $(OCS).config/pcmanfm/default/pcmanfm.conf $(HOME).config/pcmanfm/default/pcmanfm.conf > /dev/null; \
	cp -r $(OCS).config/libfm/ $(HOME).config/libfm/ > /dev/null; \
	sudo apt-get install pcmanfm -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install slurm"); \
	sudo apt-get install slurm -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get Epiphany"); \
	sudo apt-get install epiphany-browser -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Get VNC"); \
	sudo apt-get install x11vnc -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Install Okular"); \
	mkdir -p $(HOME).kde/share/config > /dev/null; \
	cp $(OCS).kde/share/config/okularrc $(HOME).kde/share/config/okularrc > /dev/null; \
	cp $(OCS).kde/share/config/okularpartrc $(HOME).kde/share/config/okularpartrc > /dev/null; \
	sudo apt-get install okular -y > /dev/null; \
	echo -e ""; \
	echo -e "$(OK)[] Reboot!$(NO)"

opencpn:
	$(call app_in,"Install OpenCPN"); \
	mkdir -p charts > /dev/null; \
	cp -r $(OCS).opencpn $(HOME); \
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).opencpn/plugins/watchdog/WatchdogConfiguration.xml; \
	sudo apt-get install build-essential cmake gettext git-core gpsd gpsd-clients libgps-dev wx-common libwxgtk3.0-dev libglu1-mesa-dev libgtk2.0-dev wx3.0-headers libbz2-dev libtinyxml-dev libportaudio2 portaudio19-dev libcurl4-openssl-dev libexpat1-dev libcairo2-dev -y; \
	git clone git://github.com/OpenCPN/OpenCPN.git &> /dev/null; \
	echo -e "$(WARN)| This Takes 1-2 Hours +$(NO)"; \
	echo -e "$(WARN)+======================+$(NO)"; \
	cd OpenCPN && mkdir build && cd build && cmake ../ && make && sudo make install; \
	cd; \
	rm -rf OpenCPN; \
	$(call app_out, $$?)
	$(call app_in,"OpenCPN: Watchdog"); \
	git clone git://github.com/seandepagnier/watchdog_pi.git &> /dev/null; \
	cd watchdog_pi && mkdir -p build && cd build && cmake ../ && make && sudo make install; \
	cd; \
	rm -rf watchdog_pi; \
	$(call app_out, $$?)
	$(call app_in,"OpenCPN: Climatology"); \
	git clone git://github.com/seandepagnier/climatology_pi.git &> /dev/null; \
	cd climatology_pi && mkdir -p build && cd build && cmake ../ && make && sudo make install; \
	cd; \
	rm -rf climatology_pi &> /dev/null; \
	sudo mkdir -p /usr/local/share/opencpn/plugins/climatology_pi; \
	sudo tar -C /usr/local/share/opencpn/plugins/climatology_pi -xvf OnboardComputerSystem/CL-DATA-1.0.tar.xz; \
	$(call app_out, $$?)

display:
	$(call app_in,"Setup xorg"); \
	sudo apt-get install xorg -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Setup openbox"); \
	cp -r $(OCS).config/openbox $(HOME).config/openbox > /dev/null; \
	cp $(OCS).config/user-dirs.dirs $(HOME).config > /dev/null; \
	sudo cp $(OCS)xorg.conf /etc/X11/ > /dev/null; \
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).config/openbox/autostart > /dev/null; \
	sudo apt-get install openbox -y > /dev/null; \
	$(call app_out, $$?)
	$(call app_in,"Setup LightDM"); \
	sudo apt-get install lightdm -y > /dev/null; \
	sudo cp $(INSTALL)lightdm.conf /etc/lightdm/lightdm.conf > /dev/null; \
	sudo sed -i -e "s,laserwolf,$(USER),g" /etc/lightdm/lightdm.conf > /dev/null; \
	sudo cp $(INSTALL)bootconfig.txt /boot/config.txt > /dev/null; \
	sudo systemctl enable lightdm.service > /dev/null; \
	$(call app_out, $$?)

gpsd:
	$(call app_in,"Install gpsd"); \
	sudo apt-get install gpsd gpsd-clients -y > /dev/null; \
	sudo cp $(OCS)gpsd /etc/default/gpsd > /dev/null; \
	$(call app_out, $$?)

zygrib:
	$(call app_in,"Install zyGrib"); \
	mkdir -p $(HOME)GRIB > /dev/null; \
	sudo apt-get install build-essential g++ make libqt4-dev libbz2-dev zlib1g-dev libproj-dev libnova-dev nettle-dev -y > /dev/null; \
	tar xvzf $(OCS)zyGrib-7.0.0.tgz > /dev/null; \
	cd zyGrib-7.0.0 && make && sed -i -e 's,$$(HOME),$(HOME)apps,g' $(HOME)zyGrib-7.0.0/Makefile && sudo make install > /dev/null; \
	cd; \
	rm -rf $(HOME)zyGrib-7.0.0 > /dev/null; \
	mkdir -p $(HOME).zygrib/config/ > /dev/null; \
	cp $(OCS)zygrib.ini $(HOME).zygrib/config/ > /dev/null; \
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).zygrib/config/zygrib.ini > /dev/null; \
	$(call app_out, $$?)

cmus:
	$(call app_in,"Install cmus"); \
	mkdir -p music; \
	cp -r $(OCS).cmus $(HOME).cmus; \
	cp -r $(OCS)Radio $(HOME)radio; \
	sudo apt-get install cmus autoconf libssl-dev -y > /dev/null; \
	git clone https://github.com/Arkq/cmusfm &> /dev/null; \
	cd cmusfm && autoreconf --install && mkdir -p build && cd build && ../configure && make && sudo make install > /dev/null; \
	cd; \
	rm -rf $(HOME)cmusfm; \
	cmusfm init
	$(call app_out, $$?)

pisnes:
	$(call app_in,"Install PiSNES"); \
	sudo apt-get install libsdl1.2debian joystick -y > /dev/null; \
	cp -r $(OCS)Apps/pisnes apps; \
	mkdir -p $(HOME)apps/pisnes/roms; \
	$(call app_out, $$?)

foxtrot:
	$(call app_in,"Install FoxtrotGPS"); \
	mkdir -p $(HOME).gconf/apps/foxtrotgps; \
	sudo apt-get install foxtrotgps -y > /dev/null; \
	cp $(OCS).gconf/apps/foxtrotgps/%gconf.xml $(HOME).gconf/apps/foxtrotgps/%gconf.xml; \
	sed -i -e "s,laserwolf,$(USER),g" $(HOME).gconf/apps/foxtrotgps/%gconf.xml; \
	$(call app_out, $$?)

piready:
	$(call app_in,"Getting git"); \
	sudo apt-get install build-essential git -y > /dev/null; \
	$(call app_out, $$?); \
	$(call app_in,"Update OS"); \
	sudo apt-get update -y > /dev/null; \
	$(call app_out, $$?); \
	$(call app_in,"Upgrade OS"); \
	sudo apt-get upgrade -y > /dev/null; \
	$(call app_out, $$?); \
	$(call app_in,"Get rpi-update"); \
	sudo apt-get install rpi-update -y > /dev/null; \
	$(call app_out, $$?); \
	$(call app_in,"Run rpi-update"); \
	sudo rpi-update > /dev/null; \
	$(call app_out, $$?); \
	$(call app_in,"Hide Pi Logos"); \
	sudo sed -i ' 1 s/.*/& logo.nologo/' /boot/cmdline.txt > /dev/null; \
	$(call app_out, $$?); \
	echo -e ""; \
	echo -e "$(OK)[] Reboot!$(NO)"

