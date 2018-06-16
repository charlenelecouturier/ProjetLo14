#!/bin/bash 

function sendmsg {
nc -q 5 "localhost" $PORT  <<< "$1 $2 $ARCHIVE $3 $4"
#c'est très sale
}


function browse_vsh {
local currentPath="/"
local cmd path
while [[ $cmd != "quit" ]]; do
        read -p "vsh:>" cmd arg

case $cmd in
        "pwd")
                echo $currentPath
                ;;
        "ls")
                sendmsg $cmd $currentPath
                ;;
        "cd")
              #il faut taper par exemple cd A/ (le '/' est important, je ferais l'autre cas demain)
#sinon cd .. marche parfaitement
                newpath=$(sendmsg "$cmd $arg $currentPath")
                        if [[ $newpath =~ ^\/.* ]]; then
                oldpath=$currentPath
                currentPath=$newpath
                        else
                        echo "wrong path"
                        fi
                ;;
        "cat") #quasi bon, ne pas oublier de mettre une condition sur le lien actuel 
                sendmsg $cmd $arg $currentPath
                ;;
        "rm") #le cancer 
                ;;
esac

done
}

export SERVER=$2 #variables globales, plutot pratique 
export PORT=$3
export ARCHIVE=$4
if [[ $1 == "-list" ]]; then
#       answer=$(sendmsg $port $arg)
#       echo $answer
        sendmsg "list"
elif [[ $1 == "-browse" ]]; then
                        browse_vsh
elif [[ $1 == "-extract" ]]; then
        echo "extract" 
 #je rajoute tout ca demain matin je commence a crever
else
        echo "cette commande n'existe pas"
fi



