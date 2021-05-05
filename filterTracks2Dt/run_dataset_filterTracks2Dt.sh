#!/bin/bash

basedir=$1;
outputdir=$2;
featuredir=$(pwd);

echo Launch dir: ${featuredir}
echo Input directory: $basedir;

ordir=$(pwd);
echo Working dir: $ordir;

cd $basedir

for thedir in $( find -type d -name 'Pos*'); do
	cd ${thedir}
	currentdir=$(pwd);
	makeup=$(echo ${thedir} | cut -d "/" -f2);	

	cd ${featuredir}
	
	echo "TRACKINPUTFILE ${basedir}${makeup}/tracks.dat" > filterTracks2Dt.in
        echo "OUTPUTDIR   ${outputdir}${makeup}/" >> filterTracks2Dt.in
        echo "TT 5.0" >> filterTracks2Dt.in
	echo "DEBUG    1" >> filterTracks2Dt.in

	echo ------------------------------------------------------------------------------------------------------------------------------------
	st=$(ls -A ${outputdir}${makeup}/tracks_fixed.dat)
        if [ "${st}" != "${outputdir}${makeup}/tracks_fixed.dat" ];
        then
		ot=$(ls -A ${basedir}${makeup}/tracks.dat)		
		if [ "${ot}" == "${basedir}${makeup}/tracks.dat" ];
		then
	        	mkdir -p ${outputdir}${makeup}
			echo Input: ${basedir}${makeup}/        Output: ${outputdir}${makeup}/
			cp filterTracks2Dt.in ${outputdir}${makeup}
                	zip ${outputdir}${makeup}/code.zip *.c *.h Makefile filterTracks2Dt.in readme.txt
			echo Running filtering code!
			echo 'Time that /filterTracks2Dt was executed on this dataset:' > ${outputdir}${makeup}/timestamp.dat
			timestamp=$(date +%s)
			echo ${timestamp} >> ${outputdir}${makeup}/timestamp.dat
			./filterTracks2Dt # running the program
			echo 'Time that ./filterTracks2Dt finished with this dataset:' >> ${outputdir}${makeup}/timestamp.dat
			timestamp=$(date +%s)
			echo ${timestamp} >> ${outputdir}${makeup}/timestamp.dat
		else
			echo input not ready..
		fi
        else
                echo skipping ${outputdir}${makeup}
        fi

	cd $basedir
done

cd ${featuredir}
