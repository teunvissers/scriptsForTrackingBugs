#!/bin/bash

basedir=$1;
outputdir=$2;

featuredir=$(pwd);

echo Launch dir: ${featuredir}
echo Input directory: $basedir;

ordir=$(pwd);
echo Working dir: $ordir;

mkdir -p ${outputdir}

cd $basedir

for thedir in $( find -type d -name 'Pos*'); do
	cd ${thedir}
	currentdir=$(pwd);
	makeup=$(echo ${thedir} | cut -d "/" -f2);	

	cd ${featuredir}

	pos=$(echo ${makeup} | cut -d "_" -f2);
	time=$(echo ${makeup} | cut -d "_" -f4);
	
	echo Pos: ${pos}
		
	hour=$(echo ${time} | cut -d "-" -f1);
	min=$(echo ${time} | cut -d "-" -f2);
	sec=$(echo ${time} | cut -d "-" -f3);

	echo Processing ${basedir}${makeup}
	octave --silent --eval "calcF_model('${basedir}${makeup}/', '${pos}', '${hour}', '${min}', '${sec}', '${outputdir}')";
	cd ${basedir}
done

cd ${featuredir}

for file in $(ls ${outputdir}*.dat); do
	sort -n ${file}	> temp.dat
	octave --silent --eval "sortF('temp.dat')";
	cp temp.dat ${file}
	rm temp.dat
done

cd ${featuredir}

