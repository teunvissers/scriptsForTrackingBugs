#!/bin/bash

# run in the directory that contains subdirectories, one for each extracted (avi --> tif) movie.

# this script takes one image from each movie. The idea is that the background in all these movies should be 
# the same, while the foreground (e.g. your bacteria on the surface) are different for each movie.

j=0;

mkdir ./subtract/

for file in $(find -name 'image0325.tif'); do	# can also be image0412.tif or another one
	echo ${j};
	echo $file;
	cp $file ./subtract/bg_file_${j}.tif
	let j=j+1;
done
