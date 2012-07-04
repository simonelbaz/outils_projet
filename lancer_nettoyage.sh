. ./lancer_nettoyage.ini

DATE_COURANTE=`date +"%Y%m%d%H%M%S"`

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} @./nettoyage_faeton.sql > ./nettoyage_faeton_${DATE_COURANTE}.log

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} @./nettoyage_tampon.sql > ./nettoyage_tampon_${DATE_COURANTE}.log


exit 0
