# FAQ

**Q. *When running Ansible playbook, it seems like it is stuck? (Very fast time when setting up box)***

**A.**  This is expected because artifacts being downloaded in background.  It is recommended not interrupt playbook process, so go grab cup of tea and take walk till playbook completes.
Note: Just KDE/Ubuntu desktops can tak1-2hrs to complete, as their size is big.

**Q. *Is desktop screen small in size?***

**A.** This may be the case for login screen. Once you login, it will become big. In case, screen is small post login, try to minimize/maximize virtualbox window.


**Q. *Audio not working? Is audio icon show disabled and in system settings -> audio-> there is "dummy output" ?***

**A.** Check in virtual box audio settings are enabled(audio output and audio input). Post enabling also, if audio is not working then follow below steps to fix the issue -
- Open terminal and run `uname -r` to check kernel version
- Then run `sudo apt-get install linux-modules-extra-<kernel-verion>-generic`
- Then run `sudo sh -c 'echo "snd-hda-intel" >> /etc/modules'`
- And finally reboot system by running `sudo reboot`



