if [[ -z "${CTX}" ]];
then
	echo "La variable CTX n'est pas positionnee."
	exit 1;
fi

find ${CTX}/tmp/ -path ${CTX}/tmp/mig/livraisons -prune -o -path ${CTX}/tmp/in -prune -o -type f -exec rm -f {} \;
cd ${CTX}/
tar xvzf tmp.tgz

