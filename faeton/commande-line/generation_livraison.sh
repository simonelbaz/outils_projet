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

. ./generation_livraison.env

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

	if [ ! -d "${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}" ];
	then
		mkdir ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}
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
	
	done

fi


for a_line in `cat ${LISTE_JOB_TOEXPORT}`
do
	PROJECT_NAME=`echo ${a_line} | cut -f1 -d':'`
	JOB_NAME=`echo ${a_line} | cut -f2 -d':'`
	TARGET_NAME=`echo ${a_line} | cut -f3 -d':'`

	if [ "${TARGET_NAME}" == "" ];
	then
		TARGET_NAME=${JOB_NAME}
	fi

	ZONES_LISTE_PER_JOB=`echo ${a_line} | cut -f4 -d':'`

	cd ${TALEND_HOME}

	echo "Export du job: ${JOB_NAME} du projet: ${PROJECT_NAME}" >> ${L_LOG_FILE}
	./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} setUserComponentPath -up ${USER_COMPONENT_PATH} exportJob ${JOB_NAME} -dd ${OUTPUT_DIRECTORY} -jc Default -af ${JOB_NAME} >> ${L_LOG_FILE}

	echo "Listing des versions du job: ${JOB_NAME} du projet: ${PROJECT_NAME}" >> ${L_LOG_FILE}
	./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} setUserComponentPath -up ${USER_COMPONENT_PATH} listItem -m >> ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/Version_${PROJECT_NAME}_${JOB_NAME}".txt"

	echo "Increment de la version mineure de chaque projet exporte ..." >> ${L_LOG_FILE}
	./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} setUserComponentPath -up ${USER_COMPONENT_PATH} newVersion nextMinor -flv >> ${L_LOG_FILE}

	echo "Copie des exports" >> ${L_LOG_FILE}

	cd ${TEMP_DIRECTORY_LIVRAISON}
	cp ${OUTPUT_DIRECTORY}/${JOB_NAME}".zip" ${TEMP_DIRECTORY_LIVRAISON}
	rm -rf ${TEMP_DIRECTORY_LIVRAISON}/${JOB_NAME}

	echo "Dezippage de l export: ${JOB_NAME}" >> ${L_LOG_FILE}

	unzip ${JOB_NAME}".zip"

	if [ "${JOB_NAME}" != "${TARGET_NAME}" ];
	then
		mv ${JOB_NAME} ${TARGET_NAME}
	fi


	echo "Suppression des sources et items: ${JOB_NAME}" >> ${L_LOG_FILE}
	rm -rf ${TARGET_NAME}/src
	rm -rf ${TARGET_NAME}/items
	rm ${TARGET_NAME}/*.bat
	rm ${TARGET_NAME}/*.sh
	

	for a_zone in `echo  ${ZONES_LISTE_PER_JOB} | sed -e 's/,/ /g'`
	do
		if [ ! -d "${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/bin/${TARGET_NAME}" ];
		then
			mkdir -p ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/bin/${TARGET_NAME}
		fi

		cp -r ${TARGET_NAME} ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/bin/${TARGET_NAME}/
		cp -r lib ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}/bin/${TARGET_NAME}/

	done

	rm -rf lib ${TARGET_NAME}
done

for a_zone in ${LISTE_ZONES}
do
	cd ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${a_zone}
	tar cvzf ../${a_zone}"_"${TAG_TO_CREATE}".tar.gz" *
done

echo "Fin de generation de la livraison." >> ${L_LOG_FILE}
