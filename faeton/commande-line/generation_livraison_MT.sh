#!/bin/sh
#***********************************************************************
#
# DESCRIPTION :
#   Projet Faeton
#
# REMARQUE :
#
#
# PARAMETRES : 
#
#***********************************************************************

# set -x

L_CLASSPATH=""
L_CURRENT_DIR=`dirname $0`
L_CURRENT_PROG=`basename $0 .sh`
L_CURRENT_DATE=`date +%Y%m%d%H%M%S`

usage() {
	echo "usage: $0 [ -i <index du job a exporter> | -a | -t <tag_a_creer> ]"
	echo ""
	echo ""
	echo "-a: Exporter tous les jobs"
	echo "-t <tag_a_creer>:  Copie de la version trunk de Configuration et de Script de chaque projet."
	echo "			 Incremente la version mineure de chaque projet Talend exporte."
	echo "-i: Selectionner un job a exporter"
	echo "-h: Help"	
	echo ""
	echo "Liste des jobs pouvant etre exportes"
	echo ""

a_index=1
for a_line in `cat ${LISTE_JOB_TOEXPORT}`
do
	echo ${a_index}")"${a_line}
	a_index=$(($a_index+1));
done

exit 1;
}

#cd ${L_CURRENT_DIR}/../../
#L_IFO_HOME=`pwd`
#L_PARAM_DIR="${L_IFO_HOME}/param"
#L_LOG_DIR="${L_IFO_HOME}/log/tech"
#L_LOG_FILE=${L_LOG_DIR}"/"${L_CURRENT_PROG}"_"${L_CURRENT_DATE}".log"
L_LOG_FILE=/opt/livraison/${L_CURRENT_PROG}"_"${L_CURRENT_DATE}".log"

. ./generation_livraison_MT.env

# si aucun parametre n'est indique en ligne de commande, getopt renvoie la chaine --
# c'est pour cela, qu'un shift est realise dans le case

JOB_INDEX="0"
TAG_TO_CREATE=""

code_retourne=0

while [ "${code_retourne}" == "0" ] 
do
	getopts "hi:at:" opt_name
	code_retourne=$?
	
	if [ "${code_retourne}" == "0" ];
	then
		case "${opt_name}" in
			a) JOB_INDEX="";;
			i) JOB_INDEX=${OPTARG};;
			t) TAG_TO_CREATE=${OPTARG};;
			h) usage;;
			*) usage; exit 1;;
		esac
	fi
done

echo "JOB_INDEX:"$JOB_INDEX
echo "TAG_TO_CREATE:"$TAG_TO_CREATE

if [ "${TAG_TO_CREATE}" != "" ];
then
	echo "Creation du tag: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
	svn mkdir ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE} -m "Creation du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

	if [ "$?" != "0" ];
	then
		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
	fi

	echo "Creation du tag: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
	svn mkdir ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE} -m "Creation du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

	if [ "$?" != "0" ];
	then
		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
	fi

	echo "Creation du tag: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
	svn mkdir ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/tags/${TAG_TO_CREATE} -m "Creation du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

	if [ "$?" != "0" ];
	then
		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
	fi

#	echo "Creation du tag: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
#	svn mkdir ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/tags/${TAG_TO_CREATE} -m "Creation du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}
#
#	if [ "$?" != "0" ];
#	then
#		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
#	fi

#	echo "Creation du tag: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
#	svn mkdir ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/tags/${TAG_TO_CREATE} -m "Creation du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}
#
#	if [ "$?" != "0" ];
#	then
#		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
#	fi

	if [ ! -d "${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}" ];
	then
		mkdir ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}
	fi

	echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/trunk/kettle_home vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
	svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/trunk/kettle_home ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/tags/${TAG_TO_CREATE}/ -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

	if [ "$?" != "0" ];
	then
		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
	fi

	echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/trunk/ vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
	svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/trunk ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/tags/${TAG_TO_CREATE}/ -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

	if [ "$?" != "0" ];
	then
		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
	fi

	echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/trunk/ vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
	svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/trunk ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/tags/${TAG_TO_CREATE}/ -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

	if [ "$?" != "0" ];
	then
		echo "Sortie du script en erreur" >> ${L_LOG_FILE}
	fi
	
	for a_zone in ${LISTE_ZONES}
	do
		echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/trunk/${a_zone} vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
		svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/trunk/${a_zone} ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}/ -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi

		echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/trunk/${a_zone} vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
		svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/trunk/${a_zone} ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}/ -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi

		echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}/${a_zone}" >> ${L_LOG_FILE}
		svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}/${a_zone} ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone} --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi
	
		echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}/${a_zone}" >> ${L_LOG_FILE}
		svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}/${a_zone}/plc ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/plc --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi
	
		if [ "${a_zone}" == "MT-InfocentreACT" ];
		then
			echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/tags/${TAG_TO_CREATE}/" >> ${L_LOG_FILE}
			svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PentahoDataIntegration/tags/${TAG_TO_CREATE}/kettle_home ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/kettle_home --username ${SVN_USER} --password ${SVN_PWD}

			if [ "$?" != "0" ];
			then
				echo "Sortie du script en erreur" >> ${L_LOG_FILE}
			fi
		
			echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/tags/${TAG_TO_CREATE}/" >> ${L_LOG_FILE}
			svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Restitution/tags/${TAG_TO_CREATE}/ ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/Rapport/ --username ${SVN_USER} --password ${SVN_PWD}

			if [ "$?" != "0" ];
			then
				echo "Sortie du script en erreur" >> ${L_LOG_FILE}
			fi
		
			echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/tags/${TAG_TO_CREATE}/" >> ${L_LOG_FILE}
			svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/PDI-Job/tags/${TAG_TO_CREATE}/ ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/Jobs/ --username ${SVN_USER} --password ${SVN_PWD}

			if [ "$?" != "0" ];
			then
				echo "Sortie du script en erreur" >> ${L_LOG_FILE}
			fi
		fi
	
	done
fi

for a_zone in ${LISTE_ZONES}
do
	cd ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}
	tar cvzf ../${a_zone}"_"${TAG_TO_CREATE}".tar.gz" *
done

echo "Fin de generation de la livraison." >> ${L_LOG_FILE}
