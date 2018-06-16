#! /bin/bash 

source function_server #permet de lire le fichier nommé

if [ $# -ne 1 ]; then

    echo "usage: $(basename $0) PORT"
    exit -1
fi

PORT="$1"

FIFO="/tmp/$USER-fifo-$$"

function nettoyage() { rm -f "$FIFO"; }
trap nettoyage EXIT


[ -e "$FIFO" ] || mkfifo "$FIFO"


function accept-loop() {
    while true; do
        getmsg  < "$FIFO" | netcat -l -p "$PORT" > "$FIFO"
    done
}
accept-loop


