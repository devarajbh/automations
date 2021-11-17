#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

log() {
  printf "\n${GREEN}"
  echo "------------------------------------"
  printf "$(date '+%A %X') -> ${NC} $1 \n${GREEN}"
  echo "------------------------------------" 
  printf "\n${NC}"
}

install_python(){
  log "Installing python from source code"
  sudo apt update

  #Install pre-requisites for python
  sudo apt install wget software-properties-common
  sudo apt install build-essential checkinstall
  sudo apt install libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

  #Download required python package
  cd /opt
  sudo wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz
  tar xzf Python-3.9.6.tgz
  cd Python-3.9.6
  sudo ./configure --enable-optimizations
  sudo make altinstall

  #Remove .tgz file after installation
  sudo rm -f /opt/Python-3.9.6.tgz

  log "Installing pip"
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3.9 get-pip.py && rm get-pip.py
  log "Done.."
}

install_python

