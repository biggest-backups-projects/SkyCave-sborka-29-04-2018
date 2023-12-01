#!/bin/bash
if [ -z $1 ] ; then
    echo "Укажите название скрина"
    exit
fi
screen -dmS $1 ./start.sh