#! /usr/bin/env bash

# check and parse command line arguments
if [ $# -ne 1 ]
then
  echo "Usage: unzip_data.sh <output dir>"
  exit
fi

sd=$(find $PWD -type f | grep -E "[^0-9]+[0-9]{4}.tar.gz") # detect seq data file

if [ ! $sd ] # check if file was detected
then
  echo "No tar.gz files found"
  exit
else
  echo "Extracting $sd"
fi

if [ ! -d $1 ] # make filder "fastq" if it does not exist
then
  mkdir $1
fi

mkdir tmp32985 # create temporary folder for content of archive
tar -xvf $sd -C ./tmp32985 # extract sequencing data

# copy files
echo "Moving files"
find tmp32985/ | grep ".fastq.gz$" | xargs -I % mv % ./$1

echo "Deleting temporary files"
rm -r tmp32985/
echo "Deleting undetermined samples"
rm $1/Undetermined_*

echo "Done"
