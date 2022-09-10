# FAQs

**Q. *When running Ansible playbook, it seems like it is stuck?*** (Very first time when setting up box)

**A.**  This is expected because artifacts being downloaded in background.  It is recommended not interrupt playbook process, so go grab cup of tea and take walk till playbook completes.
Note: Just KDE/Ubuntu desktops can tak1-2hrs to complete, as their size is big.

**Q. *Is desktop screen small in size?*** (Very first time when setting up box)

**A.** This may be the case for login screen. Once you login, it will become big. In case, screen is small post login, try to minimize/maximize virtualbox window.

**Q. *`java --version` or `mvn -v` , etc command not found?*** (Very first time when setting up box)

**A.** This may be due to .bashrc has not picked lates changes, so try to logging off from machine and login again.

**Q. *Audio not working? Is audio icon show disabled and in system settings -> audio-> there is "dummy output" ?*** (Very first time when setting up box) 
> Issue has been raised for this https://github.com/yashendra-gupta/raven/issues/2

Virtual Box settings: ![image](https://user-images.githubusercontent.com/40363062/182923068-9e55096a-e21e-4d74-95cc-05b77ecfef52.png)

CAUTION: This fix depends on hardware.

**A.** Check in virtual box audio settings are enabled(audio output and audio input). Post enabling also, if audio is not working then follow below steps to fix the issue -
- Open terminal and run `uname -r` to check kernel version
- Then run `sudo apt-get install linux-modules-extra-<kernel-verion>`
- Then run `sudo sh -c 'echo "snd-hda-intel" >> /etc/modules'`
- And finally reboot system by running `sudo reboot`

References : [#1](https://askubuntu.com/questions/759174/how-to-load-snd-hda-intel-at-startup) and [#2](https://askubuntu.com/questions/296095/how-can-i-ensure-the-snd-hda-intel-module-is-loaded-on-startup/1118822#1118822)





