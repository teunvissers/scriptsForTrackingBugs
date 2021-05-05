#!/bin/bash

basedir=$1;
outputdir=$2;
featuredir=$(pwd);

echo Launch dir: ${featuredir}
echo Input directory: $basedir;

ordir=$(pwd);
echo Working dir: $ordir;

mkdir -p ${outpudir}

cd $basedir

for thedir in $( find -type d -name 'Pos_*'); do
#for thedir in $( find -type d -name 'Pos_09*'); do
	cd ${thedir}
	currentdir=$(pwd);
	makeup=$(echo ${thedir} | cut -d "/" -f2);	

	cd ${featuredir}

	echo "TRACKINPUTFILE ${basedir}${makeup}/tracks_fixed.dat" > analyzeBugTracks2Dt.in
	echo "OUTPUTDIR ${outputdir}${makeup}/" >> analyzeBugTracks2Dt.in
	echo "DEBUG 1" >> analyzeBugTracks2Dt.in
	echo "PIXELSIZE 0.234" >> analyzeBugTracks2Dt.in
	echo "TIMESTEP 0.0333" >> analyzeBugTracks2Dt.in
	echo "MINANA 25" >> analyzeBugTracks2Dt.in
	echo "MINANB 180" >> analyzeBugTracks2Dt.in
	echo "TAULONG 120" >> analyzeBugTracks2Dt.in
	echo "TAUSHORT 12" >> analyzeBugTracks2Dt.in
	echo "LOWERBOUNDSHORTKT 0.6" >> analyzeBugTracks2Dt.in
	echo "LOWERBOUNDLONGKT 0.6" >> analyzeBugTracks2Dt.in
	echo "UPPERBOUNDSHORTKT 1.3" >> analyzeBugTracks2Dt.in
	echo "LOWERBOUNDSHORTKR 0.3" >> analyzeBugTracks2Dt.in
	echo "UPPERBOUNDSHORTKR 1.2" >> analyzeBugTracks2Dt.in
	echo SPAN 1 >> analyzeBugTracks2Dt.in
	echo WRITETRACKINFO 1 >> analyzeBugTracks2Dt.in
	
	echo ------------------------------------------------------------------------------------------------------------------------------------
	st=$(ls -A ${outputdir}${makeup}/sorts.dat)
        #echo ${st}
        if [ "${st}" != "${outputdir}${makeup}/sorts.dat" ];
        then
		ot=$(ls -A ${basedir}${makeup}/tracks_fixed.dat)		
		if [ "${ot}" == "${basedir}${makeup}/tracks_fixed.dat" ];
		then
	        	mkdir -p ${outputdir}${makeup}
        	        echo processing ${basedir}${makeup}/tracks_fixed.dat --\> ${outputdir}${makeup}/
                        cp analyzeBugTracks2Dt.in ${outputdir}${makeup}
                        zip ${outputdir}${makeup}/code.zip *.c *.h Makefile analyzeBugTracks2Dt.in readme.txt
                        echo Running filtering code!
                        echo 'Time that /analyzeBugTracks2Dt was executed on this dataset:' > ${outputdir}${makeup}/timestamp.dat
                        timestamp=$(date +%s)
                        echo ${timestamp} >> ${outputdir}${makeup}/timestamp.dat
                        ./analyzeBugTracks2Dt # running the program
                        echo 'Time that ./analyzeBugTracks2Dt finished with this dataset:' >> ${outputdir}${makeup}/timestamp.dat
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
