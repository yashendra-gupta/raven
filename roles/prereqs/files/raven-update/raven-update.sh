#!/bin/bash

echo "hello from raven-update.sh"

sudo -E ansible-pull --accept-host-key --private-key="/home/vagrant/.ssh/id_rsa"  --url="git@github.com:yashendra-gupta/raven.git" local.yml

cd /opt/development/raven

FETCH=/usr/bin/git git fetch --all
