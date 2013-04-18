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

timediff $1 $2
