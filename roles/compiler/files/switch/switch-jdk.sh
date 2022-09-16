#!/bin/bash

declare -r CURRENT_WORKING_DIRECTORY=$(pwd)

declare -r DOWNLOAD_URL_JDK_8="https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz"
declare -r DOWNLOAD_URL_JDK_9="https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_10="https://download.java.net/java/GA/jdk10/10.0.2/19aef61b38124481863b1413dce1855f/13/openjdk-10.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_11="https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_12="https://download.java.net/java/GA/jdk12.0.2/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/openjdk-12.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_13="https://download.java.net/java/GA/jdk13.0.2/d4173c853231432d94f001e99d882ca7/8/GPL/openjdk-13.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_14="https://download.java.net/java/GA/jdk14.0.2/205943a0976c4ed48cb16f1043c5c647/12/GPL/openjdk-14.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_15="https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_16="https://download.java.net/java/GA/jdk16.0.2/d4a915d82b4c4fbb9bde534da945d746/7/GPL/openjdk-16.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_17="https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz"
declare -r DOWNLOAD_URL_JDK_18="https://download.java.net/java/GA/jdk18.0.2/f6ad4b4450fd4d298113270ec84f30ee/9/GPL/openjdk-18.0.2_linux-x64_bin.tar.gz"

declare -r JDK_SYMLINK="/opt/development/bin/jdk"
declare -r LOCATION_PACKAGES_EXTRAS="/opt/develop/packages/extras"
declare -r LOCATION_PACKAGES_EXTRAS_RAW="/opt/develop/packages/extras/raw"

declare -r JDK_SPECIFIC_FOLDER="/jdk"

declare -r JDK_PACK_FILE_LOCATION=$LOCATION_PACKAGES_EXTRAS_RAW$JDK_SPECIFIC_FOLDER
declare -r JDK_UNPACK_FILE_LOCATION=$LOCATION_PACKAGES_EXTRAS$JDK_SPECIFIC_FOLDER

mkdir -p $JDK_PACK_FILE_LOCATION
mkdir -p $JDK_UNPACK_FILE_LOCATION

get_jdk_url () {
    # https://stackoverflow.com/questions/16553089/dynamic-variable-names-in-bash
    # https://stackoverflow.com/a/16553351
    local jdk_url_placholder="DOWNLOAD_URL_JDK_$1"
    echo "${!jdk_url_placholder}"
}

is_version_installed () {
    version=$(java -version 2>&1 | head -n 1 | cut -d\" -f 2)
    local extract_actual_jdk_version_to_switch="$(echo $1 | cut -d \- -f 2 | cut -d \_ -f 1)"

    if [[ $version == *$extract_actual_jdk_version_to_switch* ]]; then
        installed="yes"
    else
        installed="no"
    fi
    echo "$installed"
}

download_jdk () {
    wget -qcP $JDK_PACK_FILE_LOCATION $1  &
    pid=$!
    spin='.RAVEN..'
    i=0
    while kill -0 $pid 2>/dev/null
    do
      i=$(( (i+1) % ${#spin} ))
      printf "${spin:$i:1} "
      sleep .3
    done
    printf "\n"
}

unpack_jdk () {
  local jdk_package_unpack_location=$JDK_UNPACK_FILE_LOCATION\/$version_to_switch

  if [[ ! -e $jdk_package_unpack_location ]]; then
    mkdir -p $JDK_UNPACK_FILE_LOCATION\/$version_to_switch
    echo "Unpacking JDK $version_to_switch, please wait..."
    tar -xf $jdk_package_cache_location -C $jdk_package_unpack_location --strip-components=1 # https://linuxize.com/post/how-to-extract-unzip-tar-gz-file/
    echo "JDK $version_to_switch unpacked successfully !!"
  fi
}

link_jdk () {
  echo "Linking JDK $version_to_switch"

  local jdk_package_unpack_location=$JDK_UNPACK_FILE_LOCATION\/$version_to_switch

  ln -sfn $jdk_package_unpack_location $JDK_SYMLINK

  echo "JDK $version_to_switch linked successfully !!"
}

main () {
    local version_to_switch=$1

    if  [[ $version_to_switch == "d" ]]; then
      local default_jdk_version=$( find  /opt/development/ -path "/opt/development/jdk"* -type d | rev | cut -d \/ -f 1 | rev )
      ln -sfn /opt/development/$default_jdk_version $JDK_SYMLINK
      echo "JDK switched to $default_jdk_version default JDK version successfully !!... :)"
      exit
    fi

    local version_to_switch_jdk_url=$( get_jdk_url $version_to_switch )

    if  [[ $version_to_switch_jdk_url == "" ]]; then
        echo "Provide JDK version $1 is not a valid version."
        exit
    fi

    echo "version_to_switch_jdk_url = $version_to_switch_jdk_url "

    local version_to_switch_jdk_tar_file_name="$(echo $version_to_switch_jdk_url | rev | cut -d \/ -f -1 | rev)"
    echo "version_to_switch_jdk_tar_file_name = $version_to_switch_jdk_tar_file_name"

    local version_to_switch_installed=$( is_version_installed $version_to_switch_jdk_tar_file_name )

    echo "Version installed ? $version_to_switch_installed"

    if  [[ $version_to_switch_installed == "yes" ]]; then
        echo "Cannot switch as $1 is already set as the current JDK version"
        exit
    fi

    echo "Switching JDK to version $version_to_switch"

    local jdk_package_cache_location=$JDK_PACK_FILE_LOCATION\/$version_to_switch_jdk_tar_file_name

    if [[ -e $jdk_package_cache_location ]]; then
        echo "Using JDK $version_to_switch package from cache !!... :)"
    else
        echo "JDK $version_to_switch package is not present in cache... :("
        echo "Downloading JDK $version_to_switch package from $version_to_switch_jdk_url"
        echo "Please wait..."
        download_jdk $version_to_switch_jdk_url
        echo "JDK $version_to_switch successfully downloaded !!"
    fi

    unpack_jdk $jdk_package_cache_location
    link_jdk
    echo "JDK switched to version $version_to_switch successfully !!... :)"
}

main $1