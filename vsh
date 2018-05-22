#!/bin/bash

cmd=$1
serveur=$2
port=$3
achive=$4
CurrentDir="/"



if [ $cmd = "-list" ]; then
	ls $serveur
elif  [ $cmd = "-browse" ]; then
 	echo "browse" 
	for((;;))        #boucle infini
		do
			read -p "vsh:>" cmd directory
   			case $cmd in
				"exit") 
					exit 0 ;; #sortie de la boucle infini (de la commande)
				"pwd") 
					
					;;

				"ls") 
					;;
				"cd")
					if [ -n "$directory"]; then #regarde si il a bien rentré un dossier
						CurrentDir+="$directory"
						while [-f $(grep ".." "$CurrentDir")s]; do 
							CurrentDir=$(sed "s/\/.*\.\.//g" CurrentDir) #si il y a ".." on supprime l'element précedent
						done #si il y en a plusieur on fait le sed plusieurs fois
					else
						echo "cd [directory]"
					fi
					;;
		esac
	done
elif [ $cmd = "-extract" ]; then
	echo "extract"
else
	echo "option inconnu utilisez \"-list\" ,\"-browse\", ou \"-extract\""
fi
