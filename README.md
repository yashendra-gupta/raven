# raven
Raven is a full stack development environment using Ansible. It contains playbooks to setup jdk, nodejs, docker, redis, postgressql, etc with other customization. 

Set up git ssh

```shell
ssh-keygen -t rsa -b 4096 -C "yashendragupta2704@gmail.com"
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

# FAQ
- **`ava --version` or `mvn -v` , etc command not found?** 
  - Ans: This may be due to .bashrc has not picked lates changes, so try to logging off from machine and login again.
