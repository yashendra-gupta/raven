# raven
Raven is a full stack development environment using Ansible. It contains playbooks to setup jdk, nodejs, docker, redis, postgressql, etc with other customization.

Set up git ssh 

```shell
ssh-keygen -t rsa -b 4096 -C <email-id>
```

To see your ssh public key, open terminal and run:
```shell
cat .ssh/id_rsa.pub
```

Pull ansible and run playbook to setup your environment
```shell
sudo -E ansible-pull --accept-host-key --private-key="/home/vagrant/.ssh/id_rsa"  --url="git@github.com:yashendra-gupta/raven.git" local.yml
```


check if uid is already in use: `cat /etc/passwd | grep 900`

**Note:** 
1. On fresh installation post anisble play, somtimes machine might not start. To resolve, just do clean installation again.
2. On fresh installation post ansible play, there may be a possibility that normal GNOME/Ubuntu login screen will be shown. This may look strange provided that the installed desktop was KDE plasma desktop. So, in order to use KDE, remember to choose plasma during login. To view this option, click on login's username texbox and a icon will be shown in bottom right corner.
3. On launchin chrome, cancel 
![image](https://user-images.githubusercontent.com/40363062/182890348-a9a78549-5792-4f45-b7c6-3c808bc90ace.png)
4. On fresh installation post ansible play, desktop screen may flicker. To resolve this, just close virtual box and reopen.
5. On fresh installation post ansible play, `raven-update` could not update `raven` project and throws that no raven git project found local. This may be due to git known hosts not set issue. Note : This raven project should have been created by `raven-update-check` and supposed to be exist in the specified location so that `git fetch` can work on `raven-update`, but because known-host requires interaction from user, clone failed which resulted in cascade failure. [TODO: Check how to execute git clone in non-interactive shell]
