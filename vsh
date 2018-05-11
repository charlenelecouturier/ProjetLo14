#!/bin/bash

cmd=$1
serveur=$2

if [ $cmd = "-list" ]
then
 ls $serveur
elif  [ $cmd = "-browse" ]
then
echo "browse"
for((;;))
do
 read -p "vsh:>" cm serv
done
elif [ $cmd = "-extract" ]
then
echo "extract"
else
 echo "option inconnu utilisez \"-list\" ,\"-browse\", ou \"-extract\""
fi
