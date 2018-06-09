#! /bin/bash
# Ce script implémente un serveur.  
# Le script doit être invoqué avec l'argument :                                                              
# PORT   le port sur lequel le serveur attend ses clients  

if [ $# -ne 1 ]; then  

    echo "usage: $(basename $0) PORT"
    exit -1
fi

PORT="$1"

# Déclaration du tube nommé

FIFO="/tmp/$USER-fifo-$$"


# Il faut détruire le tube quand le serveur termine pour éviter de
# polluer /tmp.  On utilise pour cela une instruction trap pour être sur de
# nettoyer même si le serveur est interrompu par un signal.
function nettoyage() { rm -f "$FIFO"; }
trap nettoyage EXIT

# on crée le tube nommé

[ -e "$FIFO" ] || mkfifo "$FIFO"


function accept-loop() {
    while true; do
        client  < "$FIFO" | netcat -l -p "$PORT" > "$FIFO"
    done
}

function client() {
local cmd serveur
while true; do
read cmd serveur || exit -1
if [ $cmd = "-list" ]; then
  for fichier in `ls $serveur`
   do
 Vtest=`head -n 1 $serveur/$fichier | egrep '[0-9]+:[0-9]+' `
        if [[ -n $Vtest ]]; then
         echo "$fichier"
        else
         echo "$fichier n'est pas une archive" 
        fi
   done
elif  [ $cmd = "-browse" ]
then
echo "browse"
for((;;))
do #boucle infinie
 read -p "vsh:>" cm
 case $cm in
        "exit")
                exit 0
                ;;
        "pwd")
                ;;
        "ls")
                ;;
        "cd")
                ;;
        "cat")
                ;;
        "rm")
                ;;

esac
done
elif [ $cmd = "-extract" ]
then
echo "extract"
else
 echo "option inconnu utilisez \"-list\" ,\"-browse\", ou \"-extract\""
fi
done
 }

accept-loop


