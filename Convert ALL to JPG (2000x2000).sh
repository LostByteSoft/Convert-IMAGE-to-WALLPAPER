#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;30;80t'		# will resize the window, if needed.
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	printf '\033[8;40;100t'	# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.
	#sleep 0.50
	
echo -------------------------========================-------------------------
## Software lead-in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	reset=`tput sgr0`

echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2022-02-20_Sunday_12:22:54
	echo
## Software name, what is this, version, informations.
	echo "Software name: Convert ALL to JPG 2000px"
	echo "File name : Convert ALL to JPG (2000x2000).sh"
	echo
	echo "What it does ?  Convert ALL to JPG image format."
	echo "Use folder select"
	echo
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft."
	echo "https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------
echo Function Debug. Activate via source program debug=1.
	debug()
	if [ "$debug" -ge 1 ]; then
		echo
		echo "${yellow}██████████████████████████████ DEBUG SLEEP ███████████████████████████████${reset}"
		echo
		echo debug = $debug
		echo part = $part
		echo INPUT = $INPUT
		echo {INPUT##*/}  = ${INPUT##*/} 
		echo input = $input
		echo cpu = $(nproc)
		echo def = $def
		echo entry = $entry
		echo 
		read -n 1 -s -r -p "Press any key to EXIT"
		exit
	fi

echo Function Error detector. If errorlevel is 1 or greater will show error msg.
	error()
	{
	if [ "$?" -ge 1 ]; then
		echo
		echo "${red}█████████████████████████████████ ERROR █████████████████████████████████${reset}"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!! Will probably exit !!!"
		echo
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
	fi
	}

echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	#file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	file=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file" --directory)
	## --file-filter="*.jpg *.gif"

if test -z "$file"
	then
		echo "You don't have selected a file, now exit in 3 seconds."
		echo -------------------------========================-------------------------
		sleep 3
		exit
	else
		echo "You have selected :"
		echo "$file"
fi
echo -------------------------========================-------------------------
echo "Input name, directory and output name : (Debug helper)"
## Set working path.
	dir=$(pwd)
	echo "Working dir : "$dir""
	echo Input file : "$file"
	export VAR="$file"
	echo
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
	echo
## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name ext : "$name""
	name1=`echo "$(basename "${VAR}")" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name bis : "$name1""
	
echo -------------------------========================-------------------------
	part=0
	debug=0		# Change to 1 to activate debug msg.
	error=0		# Change to 1 to test error msg.
echo "Get the last Folder :"
	INPUT="$(dirname "${VAR}")"
	echo ${INPUT##*/} 
## The code program.
	rm "/dev/shm/findfiles.txt" 2> /dev/null

## find files
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Finding files...

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo All lowercase for convert...
	#cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"

	## Easy way to add a file format, copy paste a new line.
	echo "Will NOT find files in sub folders... Remove -maxdepth 1 to search subfolders."

	#find "$file" -maxdepth 1 -iname '*.AVIF'  >> "/dev/shm/findfiles.txt"		## Compatibility problems, not fully supported
	find "$file" -maxdepth 1 -iname '*.BMP'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.GIF'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.JPEG'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.JPG_LARGE'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.JPG'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.PNG'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.TIF'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.TIFF'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.WEBP'  >> "/dev/shm/findfiles.txt"
	cat "/dev/shm/findfiles.txt"
	echo	
echo Finding finish, with file count :
	wc -l < "/dev/shm/findfiles.txt"

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"

	echo Conversion started
	
	echo Simple convert 1 file at a time.
	{
	input="/dev/shm/findfiles.txt"
		while IFS= read -r "line"
		do
		echo "$line"_convert.jpg
		convert "$line" -format jpg -resize 2000x2000 "$line"_convert.jpg
		done < "$input"
	}
	error $?

echo Conversion finish...
	rm "/dev/shm/findfiles.txt" 2> /dev/null

echo -------------------------========================-------------------------
## Software lead-out.
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"

echo -------------------------========================-------------------------
## Press enter or auto-quit here.
	echo "${yellow}If a script takes MORE than 120 seconds to complete it will ask you to take action !${reset}"
	echo "Press ENTER to terminate."
	echo
	echo "${green}If a script takes LESS than 120 seconds to complete it will auto-terminate !${reset}"
	echo "Auto-terminate after 10 seconds"
	echo

echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
	debug $?
if [ $(( SECONDS - start )) -gt 120 ]
then
	echo "Script takes more than 120 seconds to complete."
	echo "Press ENTER key to exit !"
	echo
	echo "${yellow}████████████████████████████████ Finish ██████████████████████████████████${reset}"
	read name
else
	echo "Script takes less than 120 seconds to complete."
	echo "Auto-quit in 10 sec. (You can press X)"
	echo
	echo "${green}████████████████████████████████ Finish ██████████████████████████████████${reset}"
	sleep 10
fi
	exit

## -----===== End of bash =====-----

End-user license agreement (eula)
	JUST DO WHAT YOU WANT WITH THE PUBLIC LICENSE
	
	Version 3.1415926532 (January 2022)
	
	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
   	
   	Everyone is permitted to copy and distribute verbatim or modified copies of
	this license document.
	
	As is customary and in compliance with current global and interplanetary
	regulations, the author of these pages disclaims all liability for the
	consequences of the advice given here, in particular in the event of partial
	or total destruction of the material, Loss of rights to the manufacturer
	warranty, electrocution, drowning, divorce, civil war, the effects of radiation
	due to atomic fission, unexpected tax recalls or encounters with
	extraterrestrial beings elsewhere.
	
	LostByteSoft no copyright or copyleft we are in the center.
## -----===== End of file =====-----
