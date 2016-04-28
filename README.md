# OCSinstall for Onboard Computer System

#### https://github.com/LASER-WOLF/OnboardComputerSystem

OCSinstall automates the Onboard Computer System installation.

### How to install

Put Raspbian Lite on your SD Card

Log in as pi:raspberry
 - **sudo raspi-config**
 - Expand filesystem
 - Change hostname to your liking
 - Fix international localisation
 - Reboot

Log in as pi:raspberry
 - Create your own user account
 - Add the account to sudoers
 - Log out

Log in with user account
 - Remove pi user from sudoers
 - Remove the pi user account
 - sudo apt-get update && sudo apt-get upgrade
 - sudo apt-get install build-essential git

**git clone https://github.com/steveshannon/OCSinstall**

ln -s ~/OCSinstall/Makefile Makefile && ln -s ~/OCSinstall/install install

**vi Makefile**
 - Find USER=capn and change capn to your user account name
 - Save and quit

**make piready**
 - Updates and upgrades OS, rpi-update, hides Pi logo
 - Reboot

**make prep**
 - This recipe performs initial directory setup, adds necessary groups to user account, and installs: rxvt, OnboardComputerSystem, JTides, PiSNES, vim, htop, python, sqlite3, tint2, lemonbar, conky, I2C, kplex, fswebcam, unclutter, scrot, ranger, PCmanFM, slurm, Epiphany, VNC, Okular.
 - Reboot

**make display**
 - This recipe installs xorg, openbox, and LightDM.
 - Reboot

**make gpsd**
 - This recipe installs gpsd and clients

**make zygrib**
 - This recipe installs zyGrib and dependencies

**make opencpn**
 - You should install this last. Part of this install takes an hour or so!

