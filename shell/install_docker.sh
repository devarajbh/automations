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

install docker(){
  log "Installing Docker" 
  sudo apt -y update
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

  #Add gpg key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
  sudo apt -y update

  #Policy will show the package status (installed or available package for installation)
  apt-cache policy docker-ce
  sudo apt install -y docker-ce

  #Create a docker group and add current user
  sudo groupadd docker
  sudo usermod -aG docker $USER

  log "Installing docker-compose"
  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
  log "Done.."
}

install_docker

