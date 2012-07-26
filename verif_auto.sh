
. /${CTX}/param/GenLoader.cfg
CURRENT_PATH=`dirname $0`
DATE_COURANTE=`date +"%Y%m%d%H%M%S"`

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from all_constraints where status <> 'ENABLED';
EOF

NB_KO=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_KO} == "0" ];
then
	echo "Nb contraints ok:"${NB_KO}"									<------- ok"
else
	echo "Nb contraints ko:"${NB_KO}"									<------- ko"
fi

# DECISION_JUDICIAIRE.particularite_retrait_point_id

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from decision_judiciaire
where particularite_retrait_point_id not in (select code_technique from domaine_val where code_nomenclature like '%PARTIC%')
and particularite_retrait_point_id is not null;
EOF

NB_KO=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_KO} == "0" ];
then
	echo "Nb DECISION_JUDICIAIRE.particularite_retrait_point_id/DOMAINE_VAL(%PARTIC%) ok:"${NB_KO}"		<------- ok"
else
	echo "Nb DECISION_JUDICIAIRE.particularite_retrait_point_id/DOMAINE_VAL(%PARTIC%) ko:"${NB_KO}"		<------- ko"
fi

# ETAT_CATEGORIE.etat_categorie_id

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from ETAT_CATEGORIE
where etat_categorie_id not in (select code_technique from domaine_val where code_nomenclature like '%ETAT_CATEG%')
and etat_categorie_id is not null;
EOF

NB_KO=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_KO} == "0" ];
then
	echo "Nb ETAT_CATEGORIE.etat_categorie_id/DOMAINE_VAL(%ETAT_CATEG%) ok:"${NB_KO}"			<------- ok"
else
	echo "Nb ETAT_CATEGORIE.etat_categorie_id/DOMAINE_VAL(%ETAT_CATEG%) ko:"${NB_KO}"			<------- ko"
fi

# ETAT_CIVIL.sexe_usager_id

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from ETAT_CIVIL
where sexe_usager_id not in (select code_technique from domaine_val where code_nomenclature like '%SEXE_USAGE%')
and sexe_usager_id is not null;
EOF

NB_KO=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_KO} == "0" ];
then
	echo "Nb ETAT_CIVIL.sexe_usager_id/DOMAINE_VAL(%SEXE_USAGE%) ok:"${NB_KO}"			<------- ok"
else
	echo "Nb ETAT_CIVIL.sexe_usager_id/DOMAINE_VAL(%SEXE_USAGE%) ko:"${NB_KO}"			<------- ko"
fi

# ETAT_DOSSIER.etat_dossier_id

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from ETAT_DOSSIER
where etat_dossier_id not in (select code_technique from domaine_val where code_nomenclature like '%ETAT_DOSSI%')
and etat_dossier_id is not null;
EOF

NB_KO=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_KO} == "0" ];
then
	echo "Nb ETAT_DOSSIER.etat_dossier_id/DOMAINE_VAL(%ETAT_DOSSI%) ok:"${NB_KO}"				<------- ok"
else
	echo "Nb ETAT_DOSSIER.etat_dossier_id/DOMAINE_VAL(%ETAT_DOSSI%) ko:"${NB_KO}"				<------- ko"
fi

# ETAT_TITRE.etat_titre_id

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from ETAT_TITRE
where etat_titre_id not in (select code_technique from domaine_val where code_nomenclature like '%ETAT_TITRE%')
and etat_titre_id is not null;
EOF

NB_KO=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_KO} == "0" ];
then
	echo "Nb ETAT_TITRE.etat_titre_id/DOMAINE_VAL(%ETAT_TITRE%) ok:"${NB_KO}"				<------- ok"
else
	echo "Nb ETAT_TITRE.etat_titre_id/DOMAINE_VAL(%ETAT_TITRE%) ko:"${NB_KO}"				<------- ko"
fi

# STATUT_TITRE.statut_titre_id

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from STATUT_TITRE
where statut_titre_id not in (select code_technique from domaine_val where code_nomenclature like '%STATUT_TIT_%')
and statut_titre_id is not null;
EOF

NB_KO=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_KO} == "0" ];
then
	echo "Nb STATUT_TITRE.statut_titre_id/DOMAINE_VAL(%STATUT_TIT_%) ok:"${NB_KO}"				<------- ok"
else
	echo "Nb STATUT_TITRE.statut_titre_id/DOMAINE_VAL(%STATUT_TIT_%) ko:"${NB_KO}"				<------- ko"
fi

# Verification SANCTION
# decision administrative
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from DECISION_ADMINISTRATIVE;
EOF

NB_DECISION_ADM_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from DECISION_ADMINISTRATIVE;
EOF

NB_DECISION_ADM_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_DECISION_ADM_ABANDONNED=`cut -f35 -d'§' /$CTX/tmp/mig/out_cit/SANC.* | grep -f ${CURRENT_PATH}/liste_codes_sanc_infraction_decision_administrative_pref.txt  | wc -l`

NB_DECISION_ADM_IN=`cut -c 159-160 /$CTX/tmp/in/FE9SANC-C002.dat | grep -f ${CURRENT_PATH}/liste_codes_sanc_infraction_decision_administrative_pref.txt | wc -l`

# echo ${NB_DECISION_ADM_FAETON}
# echo ${NB_DECISION_ADM_TAMPON}
# echo ${NB_DECISION_ADM_ABANDONNED}
# echo ${NB_DECISION_ADM_IN}

VERIF_NB_DECISION_ADM=$((${NB_DECISION_ADM_IN} - ${NB_DECISION_ADM_ABANDONNED} - ${NB_DECISION_ADM_TAMPON} - ${NB_DECISION_ADM_FAETON}))

# echo ${VERIF_NB_DECISION_ADM}

if [ ${VERIF_NB_DECISION_ADM} == "0" ];
then
	echo "Nb DECISION_ADM:				<------- ok"
else
	echo "Nb DECISION_ADM:				<------- ko"
fi

# dossier
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from DOSSIER;
EOF

NB_DOSSIER_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from DOSSIER;
EOF

NB_DOSSIER_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_DOSSIER_ABANDONNED=`wc -l /$CTX/tmp/mig/out_cit/DOSC.* | tail -1 | sed -e 's/ total$//'`
NB_DOSSIER_ABANDONNED_ENTETE=`ls -1 /$CTX/tmp/mig/out_cit/DOSC.* | wc -l`

NB_DOSSIER_IN=`wc -l /$CTX/tmp/in/FE9DOSC-C002.dat | sed -e 's/ .*$//'`

# echo ${NB_DOSSIER_IN}
# echo ${NB_DOSSIER_FAETON}
# echo ${NB_DOSSIER_TAMPON}
# echo ${NB_DOSSIER_ABANDONNED}
# echo ${NB_DOSSIER_ABANDONNED_ENTETE}

VERIF_NB_DOSSIER=$((${NB_DOSSIER_IN} - (${NB_DOSSIER_ABANDONNED} - ${NB_DOSSIER_ABANDONNED_ENTETE}) - ${NB_DOSSIER_TAMPON} - ${NB_DOSSIER_FAETON} ))

# echo ${VERIF_NB_DOSSIER}

if [ ${VERIF_NB_DOSSIER} == "0" ];
then
	echo "Nb DOSSIER:				<------- ok"
else
	echo "Nb DOSSIER:				<------- ko"
fi

# titre
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from TITRE;
EOF

NB_TITRE_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from TITRE;
EOF

NB_TITRE_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_TITRE_ABANDONNED=`wc -l /$CTX/tmp/mig/out_cit/TITR.* | tail -1 | sed -e 's/ total$//'`
NB_TITRE_ABANDONNED_ENTETE=`ls -1 /$CTX/tmp/mig/out_cit/TITR.* | wc -l`

NB_TITRE_IN=`wc -l /$CTX/tmp/in/FE9TITR-C002.dat | sed -e 's/ .*$//'`

# echo ${NB_TITRE_IN}
# echo ${NB_TITRE_FAETON}
# echo ${NB_TITRE_TAMPON}
# echo ${NB_TITRE_ABANDONNED}
# echo ${NB_TITRE_ABANDONNED_ENTETE}

VERIF_NB_TITRE=$((${NB_TITRE_IN} - (${NB_TITRE_ABANDONNED} - ${NB_TITRE_ABANDONNED_ENTETE}) - ${NB_TITRE_TAMPON} - ${NB_TITRE_FAETON} ))

# echo ${VERIF_NB_TITRE}

if [ ${VERIF_NB_TITRE} == "0" ];
then
	echo "Nb TITRE:				<------- ok"
else
	echo "Nb TITRE:				<------- ko"
fi

# droit
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from CATEGORIE;
EOF

NB_CATEGORIE_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from CATEGORIE;
EOF

NB_CATEGORIE_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_CATEGORIE_ABANDONNED=`wc -l /$CTX/tmp/mig/out_cit/DROI.* | tail -1 | sed -e 's/ total$//'`
NB_CATEGORIE_ABANDONNED_ENTETE=`ls -1 /$CTX/tmp/mig/out_cit/DROI.* | wc -l`

NB_CATEGORIE_IN=`wc -l /$CTX/tmp/in/FE9DROI-C002.dat | sed -e 's/ .*$//'`

# echo ${NB_CATEGORIE_IN}
# echo ${NB_CATEGORIE_FAETON}
# echo ${NB_CATEGORIE_TAMPON}
# echo ${NB_CATEGORIE_ABANDONNED}
# echo ${NB_CATEGORIE_ABANDONNED_ENTETE}

VERIF_NB_CATEGORIE=$((${NB_CATEGORIE_IN} - (${NB_CATEGORIE_ABANDONNED} - ${NB_CATEGORIE_ABANDONNED_ENTETE}) - ${NB_CATEGORIE_TAMPON} - ${NB_CATEGORIE_FAETON} ))

# echo ${VERIF_NB_CATEGORIE}

if [ ${VERIF_NB_CATEGORIE} == "0" ];
then
	echo "Nb CATEGORIE:				<------- ok"
else
	echo "Nb CATEGORIE:				<------- ko"
fi

# tetr
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from TITRE_FR_ETRANGER;
EOF

NB_TETR_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from TITRE_FR_ETRANGER;
EOF

NB_TETR_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_TETR_ABANDONNED=`wc -l /$CTX/tmp/mig/out_cit/TETR.?-? | tail -1 | sed -e 's/ total$//'`
NB_TETR_ABANDONNED_ENTETE=`ls -1 /$CTX/tmp/mig/out_cit/TETR.?-? | wc -l`

NB_TETR_IN=`wc -l /$CTX/tmp/in/FE9TETR-C002.dat | sed -e 's/ .*$//'`

# echo ${NB_TETR_IN}
# echo ${NB_TETR_FAETON}
# echo ${NB_TETR_TAMPON}
# echo ${NB_TETR_ABANDONNED}
# echo ${NB_TETR_ABANDONNED_ENTETE}

VERIF_NB_TETR=$((${NB_TETR_IN} - (${NB_TETR_ABANDONNED} - ${NB_TETR_ABANDONNED_ENTETE}) - ${NB_TETR_TAMPON} - ${NB_TETR_FAETON} ))

# echo ${VERIF_NB_TETR}

if [ ${VERIF_NB_TETR} == "0" ];
then
	echo "Nb TETR:				<------- ok"
else
	echo "Nb TETR:				<------- ko"
fi

# neph
# non verifiable automatiquement

# avim
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from AVIS_MEDICAL;
EOF

NB_AVIM_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from AVIS_MEDICAL;
EOF

NB_AVIM_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_AVIM_ABANDONNED=`wc -l /$CTX/tmp/mig/out_cit/AVIM.?-? | tail -1 | sed -e 's/ total$//'`
NB_AVIM_ABANDONNED_ENTETE=`ls -1 /$CTX/tmp/mig/out_cit/AVIM.?-? | wc -l`

NB_AVIM_IN=`wc -l /$CTX/tmp/in/FE09SL002F27PCT1.dat | sed -e 's/ .*$//'`

# echo ${NB_AVIM_IN}
# echo ${NB_AVIM_FAETON}
# echo ${NB_AVIM_TAMPON}
# echo ${NB_AVIM_ABANDONNED}
# echo ${NB_AVIM_ABANDONNED_ENTETE}

VERIF_NB_AVIM=$((${NB_AVIM_IN} - (${NB_AVIM_ABANDONNED} - ${NB_AVIM_ABANDONNED_ENTETE}) - ${NB_AVIM_TAMPON} - ${NB_AVIM_FAETON} ))

# echo ${VERIF_NB_AVIM}

if [ ${VERIF_NB_AVIM} == "0" ];
then
	echo "Nb AVIM:				<------- ok"
else
	echo "Nb AVIM:				<------- ko"
fi

# slr48
# a voir avec Marion
# sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
# select 'result=' || count(*) from AVIS_MEDICAL;
# EOF
# 
# NB_SLR48_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`
# 
# sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
# select 'result=' || count(*) from AVIS_MEDICAL;
# EOF
# 
# NB_SLR48_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`
# 
# NB_SLR48_ABANDONNED=`wc -l /$CTX/tmp/mig/out_cit/SLR48.?-? | tail -1 | sed -e 's/ total$//'`
# NB_SLR48_ABANDONNED_ENTETE=`ls -1 /$CTX/tmp/mig/out_cit/SLR48.?-? | wc -l`
# 
# NB_SLR48_IN=`wc -l /$CTX/tmp/in/FE09SL002F27PCT1.dat | sed -e 's/ .*$//'`
# 
# echo ${NB_SLR48_IN}
# echo ${NB_SLR48_FAETON}
# echo ${NB_SLR48_TAMPON}
# echo ${NB_SLR48_ABANDONNED}
# echo ${NB_SLR48_ABANDONNED_ENTETE}
# 
# VERIF_NB_SLR48=$((${NB_SLR48_IN} - (${NB_SLR48_ABANDONNED} - ${NB_SLR48_ABANDONNED_ENTETE}) - ${NB_SLR48_TAMPON} - ${NB_SLR48_FAETON} ))
# 
# echo ${VERIF_NB_SLR48}
# 
# if [ ${VERIF_NB_SLR48} == "0" ];
# then
# 	echo "Nb SLR48:				<------- ok"
# else
# 	echo "Nb SLR48:				<------- ko"
# fi

# af ou afm
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from AF_AFM;
EOF

NB_AF_AFM_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from AF_AFM;
EOF

NB_AF_AFM_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_AF_AFM_ABANDONNED=`cut -f35 -d'§' /$CTX/tmp/mig/out_cit/SANC.* | grep -f ${CURRENT_PATH}/liste_codes_sanc_infraction_af_afm.txt  | wc -l`

NB_AF_AFM_IN=`cut -c 159-160 /$CTX/tmp/in/FE9SANC-C002.dat | grep -f ${CURRENT_PATH}/liste_codes_sanc_infraction_af_afm.txt | wc -l`

# echo ${NB_AF_AFM_FAETON}
# echo ${NB_AF_AFM_TAMPON}
# echo ${NB_AF_AFM_ABANDONNED}
# echo ${NB_AF_AFM_IN}

VERIF_NB_AF_AFM=$((${NB_AF_AFM_IN} - ${NB_AF_AFM_ABANDONNED} - ${NB_AF_AFM_TAMPON} - ${NB_AF_AFM_FAETON}))

# echo ${VERIF_NB_DECISION_ADM}

if [ ${VERIF_NB_AF_AFM} == "0" ];
then
	echo "Nb AF_AFM:				<------- ok"
else
	echo "Nb AF_AFM:				<------- ko"
fi

# decision judiciaire
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from DECISION_JUDICIAIRE;
EOF

NB_DECISION_JUDICIAIRE_FAETON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

sqlplus ${TAMPON_DB_LOGIN}/${TAMPON_DB_PASSWORD}@${TAMPON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from DECISION_JUDICIAIRE;
EOF

NB_DECISION_JUDICIAIRE_TAMPON=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

NB_DECISION_JUDICIAIRE_ABANDONNED=`cut -f35 -d'§' /$CTX/tmp/mig/out_cit/SANC.* | grep -f ${CURRENT_PATH}/liste_codes_sanc_infraction_decision_judiciaire.txt  | wc -l`

NB_DECISION_JUDICIAIRE_IN=`cut -c 159-160 /$CTX/tmp/in/FE9SANC-C002.dat | grep -f ${CURRENT_PATH}/liste_codes_sanc_infraction_decision_judiciaire.txt | wc -l`

#echo ${NB_DECISION_JUDICIAIRE_FAETON}
#echo ${NB_DECISION_JUDICIAIRE_TAMPON}
#echo ${NB_DECISION_JUDICIAIRE_ABANDONNED}
#echo ${NB_DECISION_JUDICIAIRE_IN}

VERIF_NB_DECISION_JUDICIAIRE=$((${NB_DECISION_JUDICIAIRE_IN} - ${NB_DECISION_JUDICIAIRE_ABANDONNED} - ${NB_DECISION_JUDICIAIRE_TAMPON} - ${NB_DECISION_JUDICIAIRE_FAETON}))

# echo ${VERIF_NB_DECISION_ADM}

if [ ${VERIF_NB_DECISION_JUDICIAIRE} == "0" ];
then
	echo "Nb DECISION_JUDICIAIRE:				<------- ok"
else
	echo "Nb DECISION_JUDICIAIRE:				<------- ko"
fi

# domaine_val
##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from TITRE where nature_titre_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "TITRE.nature_titre_id:				<------- ok"
else
	echo "TITRE.nature_titre_id:				<------- ko"
fi

##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from MOUVEMENT_POINT where type_mouvement_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "MOUVEMENT_POINT.type_mouvement_id:				<------- ok"
else
	echo "MOUVEMENT_POINT.type_mouvement_id:				<------- ko"
fi

##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from PERTE_VOL_TITRE where motif_declaration_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "PERTE_VOL_TITRE.motif_declaration_id:				<------- ok"
else
	echo "PERTE_VOL_TITRE.motif_declaration_id:				<------- ko"
fi

##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from CATEGORIE where mode_obtention_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "CATEGORIE.mode_obtention_id:				<------- ok"
else
	echo "CATEGORIE.mode_obtention_id:				<------- ko"
fi

##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from DECISION_JUDICIAIRE where particularite_retrait_point_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "DECISION_JUDICIAIRE.particularite_retrait_point_id:				<------- ok"
else
	echo "DECISION_JUDICIAIRE.particularite_retrait_point_id:				<------- ko"
fi

##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from EQUIVALENCE_CBM_VDP_EPE where type_equivalence_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "EQUIVALENCE_CBM_VDP_EPE.type_equivalence_id:				<------- ok"
else
	echo "EQUIVALENCE_CBM_VDP_EPE.type_equivalence_id:				<------- ko"
fi

##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from AF_AFM where r_decision_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "AF_AFM.r_decision_id:				<------- ok"
else
	echo "AF_AFM.r_decision_id:				<------- ko"
fi

##
sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from ETAT_DOSSIER where etat_dossier_id='99999';
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == "0" ];
then
	echo "ETAT_DOSSIER.etat_dossier_id:				<------- ok"
else
	echo "ETAT_DOSSIER.etat_dossier_id:				<------- ko"
fi

# Verification du referentiel

for a_tab in R_ASSOCIATION R_AUTORITE_ADMINISTRATIVE R_AUTORITE_JUDICIAIRE R_AUTORITE_RETRAIT R_CATEGORIE R_DECISION R_DEPARTEMENT R_ECHANGE_PAYS R_EECA R_EXPLOITANT R_FONCTION R_NATINF R_NUM_CATEGORIE R_OPERATION R_PAYS R_PROFIL R_PROROGATION R_RESTRICTION R_TERRITOIRE 
do
NB_LIGNES_IN=`wc -l /$CTX/tmp/in/${a_tab}".csv" | sed -e 's/ .*$//'`
NB_LIGNES_SANS_ENTETE=$((${NB_LIGNES_IN} - 1))

sqlplus ${FAETON_DB_LOGIN}/${FAETON_DB_PASSWORD}@${FAETON_ORACLE_SID} <<EOF > /$CTX/log/tech/mig/result_${DATE_COURANTE}.log
select 'result=' || count(*) from ${a_tab};
EOF

NB_LIGNES_REMONTEES=`grep 'result=' /$CTX/log/tech/mig/result_${DATE_COURANTE}.log | cut -f2 -d'='`

if [ ${NB_LIGNES_REMONTEES} == ${NB_LIGNES_SANS_ENTETE} ];
then
	echo "${a_tab}:(${NB_LIGNES_REMONTEES} / ${NB_LIGNES_SANS_ENTETE}) 				<------- ok"
else
	echo "${a_tab}:(${NB_LIGNES_REMONTEES} / ${NB_LIGNES_SANS_ENTETE})				<------- ko"
fi

done

# Verifier qu'il existe un etat associe au dossier
# select count(*) from dossier where id not in (select dossier_id from etat_dossier);

# Verifier qu'il existe un etat categorie a la categorie

