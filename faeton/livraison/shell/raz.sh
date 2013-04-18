if [ -z "$1" ]
then
	echo "Passer la version en argument"
	exit 1
else
	VERSION="$1"
fi

echo "Debut du raz ..."
svn delete http://10.24.88.21:8200/repos_infocentre/Script/tags/${VERSION} --username selbaz --password selbaz01 -m "test du script de livraison"
svn delete http://10.24.88.21:8200/repos_infocentre/Configuration/tags/${VERSION} --username selbaz --password selbaz01 -m "test du script de livraison"
svn delete http://10.24.88.21:8200/repos_infocentre/Data/tags/${VERSION} --username selbaz --password selbaz01 -m "test du script de livraison"
rm -rf /opt/livraison/${VERSION}
rm -rf /opt/livraison/tmp/*
echo "Fin du raz."
