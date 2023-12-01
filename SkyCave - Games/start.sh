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
map=""
num=0 #Номер карты (int)
quant=0 #Количество карт

while true
do
{
    sleep $((RANDOM % 101))
    rm -R /home/$type/$type-$srv/* #Удаляет содержимое папки сервера

    cd /home/$type/Build/Maps #Идем в дерикторию карт
    quant=$( ls . | wc -l ) #Присваиваем переменной количество папок в директории

    num=$(( $srv % $quant )) #Определяем номер карты для сервера
    if [ $num -eq 0 ] ; then
        num=$quant
    fi

    cd /home/$type/Build/Maps/$num #Берем название карты по номеру карты
    for n in $(ls -d */);
    do
        map=${n%%/};
        break;
    done
    
    cp -R /home/$type/Build/Main/* /home/$type/$type-$srv/ #Копируем все остальное в папку сервера
    cp -R /home/$type/Build/Maps/$num/* /home/$type/$type-$srv/ #Копируем папку карты в папку сервера
    cp -R /home/$type/Build/OtherPlugins/$num/* /home/$type/$type-$srv/ 
	
    cd /home/$type/$type-$srv/
	
	sed -i -e 's/server-name=0/server-name='$type'/g' server.properties
	sed -i -e 's/server-port=0/server-port='$port'/g' server.properties
	
    java -Dfile.encoding=UTF-8 -Xmx800m -jar spigot.jar
}
done