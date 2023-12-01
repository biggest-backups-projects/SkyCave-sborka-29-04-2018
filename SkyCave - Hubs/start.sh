#!/bin/bash
if [ -z $1 ] ; then
    echo "Укажите тип сервера"
    exit
fi

if [ -z $2 ] ; then
    echo "Укажите номер сервера"
    exit
fi

if [ -z $3 ] ; then
    echo "Укажите порт"
    exit
fi

type=$1
srv=$2
port=$3

while true
do
{
    rm -R /home/Sky/$type/$type-$srv/* #Удаляет содержимое папки сервера
    
    cp -R /home/Sky/$type/Build/Main/* /home/Sky/$type/$type-$srv/ #Копируем все остальное в папку сервера
	
    cd /home/Sky/$type/$type-$srv/
	
	sed -i -e 's/server-name=0/server-name='$type-$srv'/g' server.properties
	sed -i -e 's/server-port=0/server-port='$port'/g' server.properties
	
    java -Dfile.encoding=UTF-8 -Xmx3g -jar spigot.jar
}
done