#!/bin/bash

cmd=$1
serveur=$2

if [ $cmd = "-list" ]; then
	ls $serveur
elif  [ $cmd = "-browse" ]; then
 	echo "browse" 
	for((;;))        #boucle infini
		do
			read -p "vsh:>" cm serv
   			case $cmd in
				"exit") 
					exit 0 ;; #sortie de la boucle infini (de la commande)
				"pwd") 
					

				"ls") 
					;;
				"cd")
					;;
		esac
	done
elif [ $cmd = "-extract" ]; then
	echo "extract"
else
	echo "option inconnu utilisez \"-list\" ,\"-browse\", ou \"-extract\""
fi
