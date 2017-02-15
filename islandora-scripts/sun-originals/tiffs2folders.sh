#!/bin/bash
# updates: file name changed to tiffs2folders.sh (2016-12-04)
#######################
# You must put all files to be processed into the "/input" directory.
# The script writes related files into a single directory into the "/output" directory.
# Text from the filename is extracted up to the first underscore and is used as the directory name.
# Optional: The script zips the whole directory into the "/zips" directory.
# mkcp checks if $dstdir exists or not,
# if not, it creates it and copies $srcfile to $dstdir.
#######################

srcdir=input

mkcp() {
   test -d $srcdir/$dstdir || mkdir -p output/$dstdir
   cp -r $srcdir/$filename output/$dstdir
}

for f in ${srcdir}/*
do
   dstdir=$(echo $f | cut -f2 -d"/" | cut -f1 -d"_")
   filename=$(echo $f | cut -f2 -d"/")

   echo 'dstdir: ' $dstdir
   echo 'filename: ' $filename

   mkcp test a/b/c/d
done

# to make zip files for ingesting into existing Islandora objects
#cd output
#for d in *
#do
#   echo 'd: = ' $d
#   zip -r ../zips/$d.zip $d
#done
