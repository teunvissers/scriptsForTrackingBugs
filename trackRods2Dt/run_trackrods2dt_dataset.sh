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
#for thedir in $( find -type d -name 'Pos_12_time_22-14-07'); do
	cd ${thedir}
	currentdir=$(pwd);
	makeup=$(echo ${thedir} | cut -d "/" -f2);	
	
        mkdir -p ${outputdir}${makeup}

	cd ${featuredir}

	echo ----------------------------------------------------------------------------------------------------
	st=$(ls -A ${outputdir}${makeup}/tracks.dat)
        if [ "${st}" != "${outputdir}${makeup}/tracks.dat" ];
        then
		echo "INPUTFILE ${basedir}${makeup}/positions.dat" > trackRods2Dt.in
		echo "OUTPUTFILE ${outputdir}${makeup}/tracks.dat" >> trackRods2Dt.in
	        echo "DEBUG    1" >> trackRods2Dt.in
		echo "STARTFRAME 100" >> trackRods2Dt.in
                echo processing dir: ${basedir}${makeup}/positions.dat --\> ${outputdir}${makeup}/tracks.dat
		./run

		echo Input: ${basedir}${makeup}/        Output: ${outputdir}${makeup}/
                # copying code and files for later analysis and version control
                cp trackRods2Dt.in ${outputdir}${makeup}
                zip ${outputdir}${makeup}/code.zip *.c *.h Makefile trackRods2Dt.in readme.txt 
                echo Running tracking code!
                echo 'Time that trackRods2Dt was executed on this dataset:' > ${outputdir}${makeup}/timestamp.dat
                timestamp=$(date +%s)
                echo ${timestamp} >> ${outputdir}${makeup}/timestamp.dat
                ./trackRods2Dt # running the program
                echo 'Time that trackRods2Dt finished with this dataset:' >> ${outputdir}${makeup}/timestamp.dat
                timestamp=$(date +%s)
                echo ${timestamp} >> ${outputdir}${makeup}/timestamp.dat
        else
                echo skipping ${outputdir}${makeup}
        fi

	cd ${basedir}
done

cd ${featuredir}
