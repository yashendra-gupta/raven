#!/bin/bash

echo "Starting Raven update..."

sudo -E ANSIBLE_COW_SELECTION=raven ansible-pull --accept-host-key --private-key="/home/vagrant/.ssh/id_rsa"  --url="git@github.com:yashendra-gupta/raven.git" --checkout=$RAVEN_UPDATE_BRANCH local.yml

printf "\033[0;32mRaven update completed !!\n"

echo "Starting post Raven update activities..."

currentDirectory=$(pwd)

cd /opt/development/raven

PULL=/usr/bin/git git pull --quiet

cd $currentDirectory

printf "\033[0;32mPost Raven update activities completed !!\n"
