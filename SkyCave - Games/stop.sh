#!/bin/bash
if [ -z $1 ] ; then
    echo "Укажите начальный сервер"
    exit
fi

if [ -z $2 ] ; then
    echo "Укажите конечный сервер"
    exit
fi

if [ -z $3 ] ; then
    echo "Укажите тип сервера"
    exit
fi

for ((i=$1;i<=$2;i++));
do
    screen -list | grep $3-$i[^0-9] | awk '{print $1}' | cut -d '.' -f 1 | awk '{print $0}' | xargs -I{} screen -S {} -X quit
    rm -rf $3/$3-$i
    echo "Сервер $3-$i убит"
done