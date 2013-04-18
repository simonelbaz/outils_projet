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
. ./export_job.env

usage() {
	echo "usage: $0 [ -i <index du job a exporter | -b <branche a exporter> ]"
	echo ""
	echo ""
	echo "-i: Selectionner un job a exporter"
	echo "-b: Branche a exporter. Par defaut, trunk"
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

# si aucun parametre n'est indique en ligne de commande, getopt renvoie la chaine --
# c'est pour cela, qu'un shift est realise dans le case

JOB_INDEX="0"
TALEND_BRANCH="trunk"
#TALEND_BRANCH="branches/Optimisation"

if [ $# -gt 0 ];
then

code_retourne=0

while [ true ] 
do
	getopts "hi:b:" opt_name
	code_retourne="$?"

	if [ "${code_retourne}" == "0" ];
	then
		case "${opt_name}" in
			a) JOB_INDEX="";;
			i) JOB_INDEX=${OPTARG};;
			b) TALEND_BRANCH=${OPTARG};;
			h) usage;;
			*) usage; exit 1;;
		esac
	else
		break
	fi
done

svn up ~/repos_pluggin --username selbaz --password selbaz01

echo "JOB_INDEX:"$JOB_INDEX
echo "TALEND_BRANCH:"$TALEND_BRANCH
fi

if [ "${JOB_INDEX}" == "" ];
then
for a_line in `cat ${LISTE_JOB_TOEXPORT}`
do
	PROJECT_NAME=`echo ${a_line} | cut -f1 -d':'`
	JOB_NAME=`echo ${a_line} | cut -f2 -d':'`

	cd ${TALEND_HOME}
	echo "./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} setUserComponentPath -up ${USER_COMPONENT_PATH} exportJob ${JOB_NAME} -dd ${OUTPUT_DIRECTORY} -jc Default -af ${JOB_NAME}"
	./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} setUserComponentPath -up ${USER_COMPONENT_PATH} exportJob ${JOB_NAME} -dd ${OUTPUT_DIRECTORY} -jc Default -af ${JOB_NAME}
done
elif [ "${JOB_INDEX}" == "0" ];
then
	usage
else
	PROJECT_NAME=`sed -n -e "${JOB_INDEX}p" ${LISTE_JOB_TOEXPORT} | cut -f1 -d':'`
	JOB_NAME=`sed -n -e "${JOB_INDEX}p" ${LISTE_JOB_TOEXPORT} | cut -f2 -d':'`

	cd ${TALEND_HOME}
	echo "./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} -br ${TALEND_BRANCH} setUserComponentPath -up ${USER_COMPONENT_PATH} exportJob ${JOB_NAME} -dd ${OUTPUT_DIRECTORY} -jc Default -af ${JOB_NAME}"
	./Talend-Studio-linux-gtk-x86_64 -nosplash -application org.talend.commandline.CommandLine -consoleLog -data ${WORKSPACE_DIRECTORY} initRemote ${REMOTE_REPOSITORY_URL} logonProject -pn ${PROJECT_NAME} -ul ${USER_LOGIN} -up ${USER_PASSWORD} -br ${TALEND_BRANCH} setUserComponentPath -up ${USER_COMPONENT_PATH} exportJob ${JOB_NAME} -dd ${OUTPUT_DIRECTORY} -jc Default -af ${JOB_NAME}
	
fi
