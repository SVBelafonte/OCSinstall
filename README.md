# OCSinstall for Onboard Computer System

#### https://github.com/LASER-WOLF/OnboardComputerSystem
OCSinstall automates the Onboard Computer System installation.
### How to install

1. Put Raspbian Lite on your SD Card
2. Log in as pi:raspberry
 - **sudo raspi-config**
 - Expand filesystem
 - Change hostname to your liking
 - Fix international localisation
 - Reboot
3. Log in as pi:raspberry
 - Create your own user account
 - Add the account to sudoers
 - Log out
4. Log in with user account
 - Remove pi user from sudoers
 - Remove the pi user account
5. Are you in your user home directory? Good.
6. **git clone https://github.com/steveshannon/OCSinstall**
7. mv OCSinstall/* .
8. **ls -la**

you should see:
```sh
$ ls -la
OnboardComputerSystem
install
Makefile
README.md
```
9. **vi Makefile**
 - Find USER=capn and change capn to your user account name
 - Save and quit
10. **make piready**
 - Installs git, updates OS, upgrades OS, rpi-update, hide pi logos
 - Reboot
11. **make prep**
 - This recipe performs initial directory setup, adds necessary groups to user account, and installs: rxvt, OnboardComputerSystem, JTides, PiSNES, vim, htop, python, sqlite3, tint2, lemonbar, conky, I2C, kplex, fswebcam, unclutter, scrot, ranger, PCmanFM, slurm, Epiphany, VNC, Okular.
 - Reboot
12. **make display**
 - This recipe installs xorg, openbox, and LightDM.
 - Reboot
13. **make gpsd**
 - This recipe installs gpsd and clients
14. **make zygrib**
 - This recipe installs zyGrib and dependencies
15. **make opencpn**
 - You should install this last. Part of this install takes an hour or so!

