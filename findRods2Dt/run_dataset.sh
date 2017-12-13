#!/bin/bash

basedir=$1;
outputdir=$2;
featuredir=$(pwd);

echo Launch dir: ${featuredir}

echo Input directory: $basedir;

ordir=$(pwd);
echo Working dir: $ordir;

cd $basedir

mkdir -p ${outputdir}

for thedir in $(find -type d -name 'Pos*'); do
	cd ${thedir}
	currentdir=$(pwd);
	makeup=$(echo ${thedir} | cut -d "/" -f2);	
        mkdir -p ${outputdir}${makeup};

	cd ${featuredir}

 	echo "FILEMASK ${basedir}${makeup}/cropped*.tif" > ./findRods2Dt.in
        echo "FILEMASKBG ${basedir}subtract_${makeup}/*.tif" >> ./findRods2Dt.in
        echo "POSITIONSFILE ${outputdir}${makeup}/positions.dat" >> ./findRods2Dt.in
        echo "OUTPUTDIR ${outputdir}${makeup}/" >> ./findRods2Dt.in
        echo "FINDRODS 1" >> ./findRods2Dt.in
        echo "MINVAL 0.20" >> ./findRods2Dt.in
        echo "DIAMETER 4.0" >> ./findRods2Dt.in
        echo "BLURDIAMETER 0.7" >> ./findRods2Dt.in
        echo "SUBBACKGROUND 0.03" >> ./findRods2Dt.in
        echo "BGTHRESHOLD 0.20" >> ./findRods2Dt.in
        echo "DEBUG 1" >> ./findRods2Dt.in
        echo "OVERLAPR 1.0" >> ./findRods2Dt.in
        echo "TOPHATDIAMETER 15" >> ./findRods2Dt.in
        echo "MININTENS 5" >> ./findRods2Dt.in
        echo "WRITEFREQ 200" >> ./findRods2Dt.in
        echo "TRACERR 2" >> ./findRods2Dt.in
        echo "WHITE 0" >> ./findRods2Dt.in
        echo "RGB 0" >> ./findRods2Dt.in
        echo "CHUNK 2000" >> ./findRods2Dt.in

	echo ----------------------------------------------------------------------------------------------------------------
 	st=$(ls -A ${outputdir}${makeup}/positions.dat)
        #echo ${st}
	if [ "${st}" != "${outputdir}${makeup}/positions.dat" ];
	then
		echo Input: ${basedir}${makeup}/        Output: ${outputdir}${makeup}/
                # copying code and files for later analysis and version control
                cp findRods2Dt.in ${outputdir}${makeup}
                zip ${outputdir}${makeup}/code.zip *.c *.h Makefile findRods2Dt.in readme.txt
                echo Running tracking code!
                echo 'Time that findRods2Dt was executed on this dataset:' > ${outputdir}${makeup}/timestamp.dat
                timestamp=$(date +%s)
                echo ${timestamp} >> ${outputdir}${makeup}/timestamp.dat
                ./findRods2Dt # running the program
                echo 'Time that findRods2Dt finished with this dataset:' >> ${outputdir}${makeup}/timestamp.dat
                timestamp=$(date +%s)
                echo ${timestamp} >> ${outputdir}${makeup}/timestamp.dat
	else
                echo skipping ${basedir}${makeup}/ --\> ${outputdir}${makeup}/
        fi

	cd $basedir
done

cd ${featuredir}
