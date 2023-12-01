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

if [ -z $4 ] ; then
    echo "Укажите 5 цифр порта"
    exit
fi

chmod +x start.sh #Даем права на запуск SH-ника (На всякий случай)

srv=0
port=0

for ((i=$1;i<=$2;i++));
do
    if screen -list | grep -q $3-$i ; 
    then
        echo "Сервер $3-$i уже запущен"
        continue;
    fi
    mkdir -p /home/Sky/$3/$3-$i/ #Создает папку сервера, если таковой нет
    port=$(( $4 + $i )) #Расчет порта из первых 3-х цифр и ID сервера
    screen -dmS $3-$i -h 102400 ./start.sh $3 $i $port #Передаем: Тип сервера, номер сервера, 5 цифр порта
    echo "Сервер $3-$i запущен на порту $port"
    let srv++
done
echo "=[$3]=============================================="
echo "Запущено $srv серверов со скринами от $3-$1 по $3-$2"