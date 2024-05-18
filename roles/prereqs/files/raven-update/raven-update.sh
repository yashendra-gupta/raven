#!/bin/bash

declare -r RAVEN_UPDATE_BRANCH="${RAVEN_UPDATE_BRANCH:="master"}"
declare -r TIME=$( date +%s )
declare -r CURRENT_WORKING_DIRECTORY=$(pwd)
# JDK 8 does not have --version option, otherwise could have used simpler way getting version
# Code: declare -r CURRENT_JDK_VERSION=$(java -version 2>&1 | head -n 1 | cut -d\" -f 2)
# Also, above JDK8, java has options -
#  -version      print product version to the error stream and exit
#  --version     print product version to the output stream and exit
declare -r CURRENT_JDK_VERSION=$(java -version 2>&1 | head -n 1 | cut -d\" -f 2)

pre_raven_update () {
  printf "\n\033[0;33mSTART: \033[0;00m PRE RAVEN UPDATE ACTIVITIES\n\n"

  if [[ $CURRENT_JDK_VERSION != " " ]]; then
    printf "JDK Version = $CURRENT_JDK_VERSION \n"
  fi

  printf "\n\033[0;33mEND: \033[0;00m PRE RAVEN UPDATE ACTIVITIES \n\n"
}

post_raven_update () {
  printf "\n\033[0;33mSTART: \033[0;00m POST RAVEN UPDATE ACTIVITIES\n\n"

  local DEFAULT_JDK_VERSION=$(java -version 2>&1 | head -n 1 | cut -d\" -f 2)

  if  [[ $CURRENT_JDK_VERSION != $DEFAULT_JDK_VERSION ]]; then
    # for jdk 8
    if [[ $CURRENT_JDK_VERSION == *"8"* ]]; then
      echo "switch-jdk-8"
      switch-jdk.sh 8
    else
      local switch_version_to=$( echo $CURRENT_JDK_VERSION | cut -d \. -f 1 )
      echo "switch-jdk-$switch_version_to"
      switch-jdk.sh $switch_version_to
    fi
  fi

  # Update raven code repository
  echo "updating Raven repository..."
  cd /opt/development/raven
  PULL=/usr/bin/git git pull --quiet
  cd $CURRENT_WORKING_DIRECTORY
  printf "\033[0;32mRaven repository update done !!\033[0;00m\n"

  printf "\n\033[0;33mEND: \033[0;00m POST RAVEN UPDATE ACTIVITIES \n\n"
}

do_raven_update () {
  printf "\n\033[0;32mSTART: \033[0;00m RAVEN UPDATE \n\n"

  sudo \
    -E ANSIBLE_FORCE_COLOR=true ANSIBLE_COW_SELECTION=raven \
    ansible-pull --accept-host-key \
    --private-key="/home/vagrant/.ssh/id_rsa" \
    --url="git@github.com:yashendra-gupta/raven.git" \
    --checkout=$RAVEN_UPDATE_BRANCH \
    local.yml

  printf "\n\033[0;32mEND: \033[0;00m RAVEN UPDATE \n\n"
}

main () {
  printf "\n\033[0;32mUpdating Raven...\n\n"

  pre_raven_update
  do_raven_update
  $RAVEN_BIN/raven-wallpaper.sh
  post_raven_update

  
  local now=$( date +%s )
  local raven_update_completion_time=$(($now-$TIME))

  printf "\n\033[0;32mRaven update completed in \033[0;34m$raven_update_completion_time\033[0;00m \033[0;32mseconds !!\033[0;00m \n\n"
}

main
