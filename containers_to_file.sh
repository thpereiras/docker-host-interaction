#!/usr/bin/env bash
GREEN='\033[0;32m'
NC='\033[0m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
FILE="/tmp/result.txt"

containers_running=$(docker ps -f "status=running" | awk '{if(NR>1) print $NF}')
containers_exited=$(docker ps -f "status=exited" | awk '{if(NR>1) print $NF}')
containers_dead=$(docker ps --filter "status=dead" | awk '{if(NR>1) print $NF}')
containers_paused=$(docker ps --filter "status=paused" | awk '{if(NR>1) print $NF}')

[ ! -f $FILE ] || rm $FILE;

if [ ! -z "$containers_running" ] ; then
    echo "Running containers:" >> $FILE;
    for container in $containers_running
    do
        echo " - "$container >> $FILE;
    done
fi

if [ ! -z "$containers_exited" ] ; then
    echo "Exited containers:" >> $FILE;
    for container in $containers_exited
    do
        echo " - "$container >> $FILE;
    done
fi

if [ ! -z "$containers_dead" ] ; then
    echo "Dead containers:" >> $FILE;
    for container in $containers_dead
    do
        echo " - "$container >> $FILE;
    done
fi

if [ ! -z "$containers_paused" ] ; then
    echo "Paused containers:" >> $FILE;
    for container in $containers_paused
    do
        echo " - "$container >> $FILE;
    done
fi

[ ! -f $FILE ] || printf "\n${GREEN}${BOLD}Arquivo gerado com sucesso: ${FILE} ${NORMAL}${NC}\n\n";

[ ! -f $FILE ] || chown --reference=${BASH_SOURCE[0]} $FILE