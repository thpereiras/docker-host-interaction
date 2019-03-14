#!/usr/bin/env bash
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
FILE="./result.txt"

clear
containers_running=$(docker ps -f "status=running" | awk '{if(NR>1) print $NF}')
containers_exited=$(docker ps -f "status=exited" | awk '{if(NR>1) print $NF}')
containers_dead=$(docker ps --filter "status=dead" | awk '{if(NR>1) print $NF}')
containers_paused=$(docker ps --filter "status=paused" | awk '{if(NR>1) print $NF}')


if [ ! -z "$containers_running" ] ; then 
    printf "\n${BOLD}Running containers:${NORMAL}\n\n";
    for container in $containers_running
    do
        printf "${GREEN}    $container${NC}\n";
    done
fi

if [ ! -z "$containers_exited" ] ; then
    printf "\n${BOLD}Exited containers:${NORMAL}\n\n";
    for container in $containers_exited
    do
        printf "${RED}    $container${NC}\n";
    done
fi

if [ ! -z "$containers_dead" ] ; then
    printf "\n${BOLD}Dead containers:${NORMAL}\n\n";
    for container in $containers_dead
    do
        printf "${RED}    $container${NC}\n";
    done
fi

if [ ! -z "$containers_paused" ] ; then
    printf "\n${BOLD}Paused containers:${NORMAL}\n\n";
    for container in $containers_paused
    do
        printf "${YELLOW}    $container${NC}\n";
    done
fi

printf "\n";