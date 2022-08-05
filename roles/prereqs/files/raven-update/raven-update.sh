#!/bin/bash

echo "hello from raven-update.sh"

sudo -E ansible-pull --accept-host-key --private-key="/home/vagrant/.ssh/id_rsa"  --url="git@github.com:yashendra-gupta/raven.git" local.yml

currentDirectory=$(pwd)

cd /opt/development/raven

PULL=/usr/bin/git git pull --quiet

cd $currentDirectory
