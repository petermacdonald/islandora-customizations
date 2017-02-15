#!/bin/bash
# updates: description updated and file name changed serials-tiff2zips.sh (2016-12-04)
###########################
# Description
# This is best used for serials because they have many files with the same core file name
# that can be zipped together and ingested together into the same Islandora serial issue # object.
# You must put all files for an issue into the "/input" directory.
# The script writes files into the "/output" directory.
# When that directory reaches the specified maximum size, the script stops copying files
# and zips the whole directory into the "/zips" directory.
# It then creates a new directory and starts the process over again.
###########################

# Remove all files in the output folder
if [ -d "output" ]
 then
    rm -rf output
    mkdir output
 else
    mkdir output
fi

# SET THE INITIAL OUTPUT DIRECTORY NAME
FLAG=1
DIRNAME=$(printf "%04d\n" $FLAG)

# SET THE INITIAL DIRECTORY SIZE
DIRSIZE=0

for f in input/*;
do

   # GET THE CURRENT FILE NAME
	FILENAME=$(echo $f | cut -f2 -d"/")

   # GET THE CURRENT FILE SIZE
	FILESIZE=$(ls -l input/$FILENAME | awk '{print$5}')

   # ADD CURRENT FILE SIZE TO THE DIRECTORY SIZE
   DIRSIZE=$(expr "$DIRSIZE" + "$FILESIZE")

   # IF THE DIRECTORY HAS NOT YET REACHED THE MAXIMUM SIZE (optimum size: 1.6 GB)
   # TO DO: LOOP NEEDS TO STOP AND DO THE ZIP IF THE CURRENT FILESIZE IS ZERO
   # 1000000000 creates zip files of 700 MB
   # 2000000000 creates zip files of 1.25 GB
   # 2400000000 creates zip files of 1.55 GB
   # 2500000000 creates zip files of 1.61 GB
   # 2700000000 creates zip files of 1.75 GB
   # 3000000000 creates zip files of 1.9 GB
   # 4000000000 creates zip files of ?.? GB
   echo "filesze $FILESIZE"
   if [ $DIRSIZE -lt 1000000000 -o ! $FILESIZE -gt 0 ]
      then

          # CREATE A NEW DIRECTORY
          if [ ! -d "output/$DIRNAME" ]
          	then
  	             mkdir "output/$DIRNAME"
          fi

       # COPY THE CURRENT FILE TO THE OUTPUT DIRECTORY
       cp -r "$f" "output/$DIRNAME"
       echo
       echo "copying $f output/$DIRNAME"

       # IF THE DIRECTORY HAS REACHED MAXIMUM SIZE
       else

           # MAKE A ZIP FILE FOR THE DIRECTORY JUST POPULATED WITH FILES
           cd output/$DIRNAME
           for d in *
              do
                 echo 'd: = ' $d
                 zip -r ../../zips/$DIRNAME.zip $d
              done
          cd ../..

          # RESET THE DIRECTORY SIZE TO ZERO
          DIRSIZE=0

          # INCREMENT THE DIRNAME BY 1
          FLAG=$(expr $FLAG + 1)
          DIRNAME=$(printf "%04d\n" $FLAG)
          echo "=========== Creating directory: $DIRNAME =========="

          # CREATE A NEW DIRECTORY
          if ! [ -d "output/$DIRNAME" ]
             then
  	             mkdir "output/$DIRNAME"
          fi

          # COPY THE CURRENT FILE TO THE NEW OUTPUT DIRECTORY
          cp -r "$f" "output/$DIRNAME"
   fi

done


