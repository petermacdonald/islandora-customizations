#!/bin/bash
#########################
# PURPOSE:
# To prepare zip files for ingest as required by the Islandora Newspaper Batch module.
# Creates the required directory structure from a directory containing the TIFF files
# for a single issue and zips the new directory structure plus the associated issue MODS
# file into a zip file that can be directly ingested into Islandora using the
# Islandora Newspaper Batch module.
#
# DEV TO DO
# Make one variable OBJECT_TYPE (for book|serial) and let that trigger configuration settings.
# You can ingest MODS with a newspaper issue ingest packet if you ingest them with the
# Islandora Newspaper Batch module.
# Otherwise you have to ingest issue MODS files manually. Issue > Manage > Datastreams > MODS > replace.
#
# For more instructions see "excel-to-mods-steps.txt

for ID in `cat ids/ids.txt`; do
	echo $ID

	# Reset index variable - for creating folders 1..n
	index=0;
	pwd

	# SET PROJECT PATH
	# The following is the directory for processing Beinecke
	# cd "/hamDigital/libSpace/drop-box/Special Collections/Beinecke folder/input/$ID"
	# cd "/hamDigital/libSpace/ingest-workspace/input/$ID"
	#cd "/hamDigital/libSpace/drop-box/Ready-for-metadata/fdi/fdi-spw/input/$ID"
	PROJECT_PATH="/hamDigital/libSpace/Peters-working-area/scripts/"
	cd "$PROJECT_PATH"

   mkdir -p "output-mods/$ID"
	pwd

# GET MODS
	MODS=mods/$ID.xml
	if [ -f $MODS ];
	   then
		# For boooks copy to MODS.xml
		cp $MODS output-mods/$ID/MODS.xml
		# For Newspaper SP batch ingest don't rename the MODS file.
		# cp $MODS output/$ID/--METADATA--.xml
		#cp $MODS output/$ID/--METADATA--.xml
	   else
	   echo -e "$MODS not found..\n"
	fi

done

echo -e "END OF PROGRAM..\n"

exit 0
