#!/bin/bash

# this bash script takes avi files on the location from 'basedir' and extracts them into tiffs in subdirectories in 'outputdir'

clear;

basedir=${1}
outputdir=${2}
echo Input directory: $basedir;

ordir=$(pwd);
echo Working dir: $ordir;

for thedir in $( find ${basedir} -type d -name 'DDMmovies*'); do
	detailsFile=${thedir}/Sequence.log
	cd ${thedir}
	for thefile in $( find -name 'Pos*'); do
		numbers=$(echo $thefile | egrep -o [0-9]+)	
		p=$(echo ${numbers} | cut -d " " -f1);
		lookup=$(echo ${thefile} | cut -d "/" -f2);
		line=$(cat ${detailsFile} | grep ${lookup})
		time=$(echo ${line} | cut -d " " -f2);
	        time=$(echo $time | tr : -);
		out=${outputdir}Pos_${p}_time_${time};
		mkdir -p ${out}

		st=$(ls -A ${out}/image0001.tif)
	        #echo ${st}
		if [ "${st}" != "${out}/image0001.tif" ];
		then
			echo '------------------------------------------------------------------------------------------------'
			echo 	File: ${thedir}/${lookup}, Pos: $p, Time: $time Destination: ${outputdir}Pos_${p}_time_${time}
			echo '------------------------------------------------------------------------------------------------'
			echo 'Making tif files..'
			echo '------------------------------------------------------------------------------------------------'
			echo processing file: ${thedir}/${thefile}
			avconv -i ${thefile} -q:v 4 ${out}/image%04d.tif;
		else
			echo skipping ${thedir}/${lookup}
		fi
	done
done

cd $ordir;
