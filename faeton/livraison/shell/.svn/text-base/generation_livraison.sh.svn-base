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

#!/bin/bash
function timediff() {
        START_H=${1:8:2}
	START_M=${1:10:2}
        START_S=${1:12:2}
        END_H=${2:8:2}
        END_M=${2:10:2}
        END_S=${2:12:2}
        #echo $START_H":"$START_M":"$START_S
        #echo $END_H":"$END_M":"$END_S

        START=$(( $START_H * 3600 + $START_M * 60 + $START_S ))
        END=$(( $END_H * 3600 + $END_M * 60 + $END_S ))
        DIFF=$(( $END - $START ))
        #echo $DIFF
        DIFF_HOUR=$(( $DIFF / 3600 ))
        DIFF_MIN=$(( ($DIFF - ($DIFF_HOUR * 3600)) / 60 ))
        DIFF_SEC=$(( $DIFF - (($DIFF_HOUR * 3600) + ($DIFF_MIN * 60)) ))
        echo $DIFF_HOUR"(H):"$DIFF_MIN"(M):"$DIFF_SEC"(S)"
}


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

cd ${L_CURRENT_DIR}
# L_IFO_HOME=`pwd`
# L_PARAM_DIR="${L_IFO_HOME}/param"
# L_LOG_DIR="${L_IFO_HOME}/log/tech"
# L_LOG_FILE=${L_LOG_DIR}"/"${L_CURRENT_PROG}"_"${L_CURRENT_DATE}".log"
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

echo "Update du repertoire des pluggins ..." >> ${L_LOG_FILE}
cd ${USER_COMPONENT_PATH}
svn up --username selbaz --password selbaz01

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

	echo "Creation du tag: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
	svn mkdir ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE} -m "Creation du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

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
		nom_zone=`echo ${a_zone} | cut -d':' -f1`
		branche_zone=`echo ${a_zone} | cut -d':' -f2`

		echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/${branche_zone}/${nom_zone} vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
		svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/${branche_zone}/${nom_zone} ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}/ -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi

		echo "Suppression du repertoire shell de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
		svn del ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}/${nom_zone}/plc/shell -m "Suppression du repertoire shell du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi

		echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/${branche_zone}/${nom_zone} vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
		svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/${branche_zone}/${nom_zone} ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}/ -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi
	
		echo "Copie de: ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/${branche_zone}/${nom_zone} vers ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE}" >> ${L_LOG_FILE}
		svn copy ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/${branche_zone}/${nom_zone} ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE}/${nom_zone} -m "Copie du tag: ${TAG_TO_CREATE}" --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi

	
		echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}/${nom_zone}" >> ${L_LOG_FILE}
		svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Configuration/tags/${TAG_TO_CREATE}/${nom_zone} ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${nom_zone} --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi
	
		echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}/${nom_zone}" >> ${L_LOG_FILE}
		svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Script/tags/${TAG_TO_CREATE}/${nom_zone}/plc ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${nom_zone}/plc --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi
	
		echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE}/${nom_zone}" >> ${L_LOG_FILE}
		svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE}/${nom_zone}/bin ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${nom_zone}/bin --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi
	
		echo "Export de ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE}/${nom_zone}" >> ${L_LOG_FILE}
		svn export ${REMOTE_REPOSITORY_URL_INFOCENTRE}/Data/tags/${TAG_TO_CREATE}/${nom_zone}/in ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${nom_zone}/in --username ${SVN_USER} --password ${SVN_PWD}

		if [ "$?" != "0" ];
		then
			echo "Sortie du script en erreur" >> ${L_LOG_FILE}
		fi
	
	done

fi

# Listing des projets
PROJECT_LIST=""
for a_line in `cut -d':' -f1 ${LISTE_JOB_TOEXPORT} | sort -u`
do
	PROJECT_LIST="${PROJECT_LIST} `echo ${a_line} | cut -f1 -d':'`"
done

for a_project in ${PROJECT_LIST}
do
	EXPORT_JOB=`sed -e "/^${a_project}/!d" -e "s/^\(${a_project}\):\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\)/\2/" ${LISTE_JOB_TOEXPORT}`
	EXPORT_JOB_COMMAND=""
	for a_job_name in ${EXPORT_JOB}
	do
		EXPORT_JOB_COMMAND=${EXPORT_JOB_COMMAND}`echo "exportJob ${a_job_name} -dd ${OUTPUT_DIRECTORY} -jc Default -af ${a_job_name}\\\; "`
		echo "Suppression de l'archive: ${OUTPUT_DIRECTORY}/${a_job_name}.zip" >> ${L_LOG_FILE}
		rm ${OUTPUT_DIRECTORY}/${a_job_name}".zip"
	done
	BRANCHE_TRAVAIL=`sed -n -e "s/^\(${a_project}\):\([^:]*\):\([^:]*\):\([^:]*\):\([^:]*\)/\5/p" ${LISTE_JOB_TOEXPORT} | sort -u`

	cd ${TALEND_HOME}

	L_START_DATE=`date +%Y%m%d%H%M%S`
	echo "${L_START_DATE}: Export du projet: ${a_project}" >> ${L_LOG_FILE}
	./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${a_project} -ul ${USER_LOGIN} -up ${USER_PASSWORD} -br ${BRANCHE_TRAVAIL} setUserComponentPath -up ${USER_COMPONENT_PATH} ${EXPORT_JOB_COMMAND} listItem -m >> ${L_LOG_FILE}

	L_END_DATE=`date +%Y%m%d%H%M%S`
	echo "${L_END_DATE}: Fin export du projet: ${a_project} (Durée : " $(timediff ${L_START_DATE} ${L_END_DATE}) ")" >> ${L_LOG_FILE}

	echo "Listing des versions du projet: ${a_project}" >> ${L_LOG_FILE}
	# ./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${a_project} -ul ${USER_LOGIN} -up ${USER_PASSWORD} -br ${BRANCHE_TRAVAIL} setUserComponentPath -up ${USER_COMPONENT_PATH} listItem -m >> ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/Version_${a_project}_${JOB_NAME}".txt"
	grep "\[" ${L_LOG_FILE} >> ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/Version_${a_project}_${JOB_NAME}".txt"
done


for a_line in `cat ${LISTE_JOB_TOEXPORT}`
do
	echo "Copie des exports" >> ${L_LOG_FILE}
	PROJECT_NAME=`echo ${a_line} | cut -f1 -d':'`
	JOB_NAME=`echo ${a_line} | cut -f2 -d':'`
	TARGET_NAME=`echo ${a_line} | cut -f3 -d':'`

	if [ "${TARGET_NAME}" == "" ];
	then
		TARGET_NAME=${JOB_NAME}
	fi

	ZONES_LISTE_PER_JOB=`echo ${a_line} | cut -f4 -d':'`
	BRANCHE_TRAVAIL=`echo ${a_line} | cut -f5 -d':'`

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

for a_project_name in `cat ${LISTE_JOB_TOEXPORT} | cut -d':' -f1 | sort -u`
do
#	PROJECT_NAME=`echo ${a_line} | cut -f1 -d':'`
#	JOB_NAME=`echo ${a_line} | cut -f2 -d':'`
#	TARGET_NAME=`echo ${a_line} | cut -f3 -d':'`
#
#	if [ "${TARGET_NAME}" == "" ];
#	then
#		TARGET_NAME=${JOB_NAME}
#	fi
#
#	BRANCHE_TRAVAIL=`echo ${a_line} | cut -f5 -d':'`
#
#	cd ${TALEND_HOME}

#	echo "Increment de la version mineure de chaque projet exporte ..." >> ${L_LOG_FILE}
#	./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} -br ${BRANCHE_TRAVAIL} setUserComponentPath -up ${USER_COMPONENT_PATH} changeVersion nextMinor -flv -d >> ${L_LOG_FILE}
	echo "Creation de la branches ${TAG_TO_CREATE} pour le projet ${a_project_name}..." >> ${L_LOG_FILE}
	svn copy http://10.24.88.21:8200/repos/${a_project_name}/trunk http://10.24.88.21:8200/repos/${a_project_name}/branches/${TAG_TO_CREATE} -m "Creation du tag ${TAG_TO_CREATE}" --username svn_user --password svn_mikh
done

# Suppression du jar xmlparserv2.jar
mv ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ODS_ANONYMISATION/lib/xmlparserv2.jar \
${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ODS_ANONYMISATION/lib/xmlparserv2.jar.backup

mv ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ACT_EXTRACTION/lib/ojdbc6-11g.jar \
${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ACT_EXTRACTION/lib/ojdbc6-11g.jar.backup

mv ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ODS_CHARGEMENT/lib/ojdbc6-11g.jar \
${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ODS_CHARGEMENT/lib/ojdbc6-11g.jar.backup

cp ~/ojdbc6.jar ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ACT_EXTRACTION/lib/ojdbc6-11g.jar
cp ~/ojdbc6.jar ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/MTB-ODS/bin/ODS_CHARGEMENT/lib/ojdbc6-11g.jar

# Verification du nombre de zip (20)
NB_ZIP=`cut -d':' -f2 ${LISTE_JOB_TOEXPORT} | sed -e "s%^%${OUTPUT_DIRECTORY}\/%" -e "s/$/\.zip/" | xargs ls -1 2> /dev/null | wc -l`
NB_ZIP_CIBLE=`wc -l ${LISTE_JOB_TOEXPORT} | cut -f1 -d ' '`

if [ "${NB_ZIP}" !=  "${NB_ZIP_CIBLE}" ];
then
	echo "Le nombre de zip dans ${OUTPUT_DIRECTORY} n'est pas egales a ${NB_ZIP_CIBLE}. Il vaut: (${NB_ZIP})" >> ${L_LOG_FILE}
	echo "Par securite, les archives ne sont pas generees." >> ${L_LOG_FILE}
	exit 1;
fi

for a_zone in ${LISTE_ZONES}
do
	nom_zone=`echo ${a_zone} | cut -d':' -f1`
	cd ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${nom_zone}
	tar cvzf ../${nom_zone}"_"${TAG_TO_CREATE}".tar.gz" *
	rm -rf ${OUTPUT_DIRECTORY_LIVRAISON}/${TAG_TO_CREATE}/${nom_zone}
done

echo "Fin de generation de la livraison." >> ${L_LOG_FILE}
