#!/bin/bash
#!/usr/bin/ffmpeg
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%H:%M:%S")
	me=$(basename "$0")
	
echo -------------------------===== Start of bash ====-------------------------
	printf '\033[8;40;100t'		# will resize the window, if needed.
	#printf '\033[8;40;115t'	# will resize the window, if needed.
	#printf '\033[8;40;130t'	# will resize the window, if needed.

	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	orange=`tput setaf sgr9`
	reset=`tput sgr0`

	## General purposes variables. Watch before program to specific variables.
	## All variables must be 0 or 1
	debug=0		## test debug. (0 or 1 debug mode)
	error=0		## test error. (0 or 1 make error)
	noquit=0	## noquit option. (0 or 1)
	automatic=0	## automatic without (at least minimal) dialog box.

	## Auto-generated variables. Don't change theses variables.
	random=$(shuf -i 4096-131072 -n 1)	## Used for temp folders. A big number hard to guess for security reasons.
	part=0					## don't change this value. (0)
	random2=$RANDOM				## Normal random
	primeerror=0				## ending error detector

	echo
	echo "Software lead-in. LostByteSoft ; https://github.com/LostByteSoft"
	echo
	echo "NEVER remove dual ## in front of lines. Theses are code annotations."
	echo "You can test / remove single # for testing purpose."
	echo
	echo "Current time : $now"
	echo
	echo "Common variables, you can changes theses variables as you wish to test."
	echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 primeerror=$primeerror"
	me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
	echo
	echo "Running job file :"
	echo
	echo $(dirname "$0")/$me
	echo

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Specific softwares variables, you can change theses variables.
	echo
	echo automatic=0 , 0 or 1 , 0 deactivated , 1 activated
	automatic=0
	echo noquit=0 , 0 or 1 , 0 deactivated , 1 activated
	noquit=0
	echo
	echo Version compiled on : Also serves as a version
	echo 2024-06-14_Friday_17:06:29
echo -------------------------========================-------------------------
echo "Color codes / Informations."
	echo
	echo  "${green}	████████████████     ALL OK / ACTIVE      ████████████████ ${reset}"
	echo   "${blue}	████████████████      INFORMATION(S)      ████████████████ ${reset}"
	echo "${yellow}	████████████████   ATTENTION / INACTIVE   ████████████████ ${reset}"
	echo    "${red}	████████████████   FATAL ERROR / OFFLINE  ████████████████ ${reset}"
	echo

echo -------------------------========================-------------------------
echo "Functions codes and color"
	echo
	echo 	"Function ${blue}█████${reset} Debug. Activate via source program debug=1."

	debug() {
		echo
		echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 automatic=$automatic primeerror=$primeerror"
		echo
		}

	if [ "$debug" -eq "1" ]; then
		echo
		echo "${blue}██████████████████████████████ DEBUG ACTIVATED AT START ███████████████████████████${reset}"
		echo
		fi

	echo 	"Function ${red}█████${reset} Error detector. Errorlevel show error msg."

	error()
	if [ "$?" -ge 1 ]; then
		noquit=1
		primeerror=$((primeerror+1))
		error=1
		echo
		echo "${red}█████████████████████████████████ ERROR $part █████████████████████████████████${reset}"
		echo
		echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 automatic=$automatic primeerror=$primeerror"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!!"
		echo
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
		fi

	if [ "$automatic" -eq "1" ]; then
		echo
		echo "${green}███████████████████████████ AUTOMATIC ACTIVATED ████████████████████████${reset}"
		echo
		fi

echo
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
## Simple function small bar to wait 3 sec.
	## Version 1.03
	## Part of code came from here https://github.com/rabb1t/spinners , Created by Pavel Raykov aka 'rabbit' / 2018-11-08 (c)

	functionsmallbar()
		{
		if [ "$debug" -eq 0 ]; then
			#echo
			width=40
			perc=0
			speed="0.1" # seconds
			inc="$(echo "100/${width}" | bc -ql)"
			#echo -n "	Wake Up.. 0% "
			echo -n "	Wait... "

			while [ $width -ge 0 ]; do
				printf "\e[0;93;103m%s\e[0m %.0f%%" "0" "${perc}"
				sleep $speed
				let width--
				perc="$(echo "${perc}+${inc}" | bc -ql)"
		
				if [ ${perc%%.*} -lt 10 ]; then
					printf "\b\b\b"
				else
					printf "\b\b\b\b"
				fi
			done
			echo
		else
			echo ${blue} ████████████████████ DEBUG BYPASS ALL BARS ████████████████████${reset}
		fi
		}

## -------------------------========================-------------------------
	echo Check installed requirements !
	echo
if command -v imagemagick >/dev/null 2>&1
	then
		echo "You don't have ' imagemagick ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install imagemagick"
		echo
		echo "${red}████████████████ Dependency error ████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to continue anyway (NOT a good idea) !"
		echo
	else
		echo "imagemagick installed continue."
		dpkg -s imagemagick | grep Version
		echo "${green} ████████████████ OK ████████████████ ${reset}"
		echo
	fi

if command -v parallel >/dev/null 2>&1
	then
		echo "Parallel installed continue."
		dpkg -s parallel | grep Version
		echo "${green} ████████████████ OK ████████████████ ${reset}"
		echo
	else
		echo "You don't have ' parallel ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install parallel"
		echo
		echo "${red}████████████████ Dependency error ████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to continue anyway (NOT a good idea) !"
		echo
	fi

echo -------------------------========================-------------------------
echo "All lowercase for convert... (NOT activated, remove both # to activate)"
	echo
	## This line put all lowercase FROM selected folder to the files names.
	#echo "cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;"
	#cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;

echo -------------------------========================-------------------------
echo "Names not supported / Informations."
	echo
	echo "${blue}	████████████████████████████████████████████████████████████████${reset}"
	echo "		!!! NAMES starting with symbols are NOT SUPPORTED !!!"
	echo "${blue}	████████████████████████████████████████████████████████████████${reset}"
	echo

echo -------------------------========================-------------------------
echo "Select folder or filename using dialog !"
	echo

	#file="$(zenity --file-selection --filename=$HOME/ --title="Select a file, all format supported")"			## File select.
	file=$(zenity --file-selection --filename=$HOME/ --title="Choose a directory to convert all file" --directory)	## Directory select.
	## file="/$HOME/Pictures/"
	## file="/$HOME/Downloads/"
	## --file-filter="*.jpg *.gif"
	## --file-filter='*[WwEeBbPp] | *[JjPpGg]' 

	count=`ls -1 "$file" 2>/dev/null | wc -l`
	echo Count : $count
	echo "You have selected :"
	echo "$file"
	echo

### file or folder
	if test -z "$file"	## for cancel on zenity
		then
			echo "You click CANCEL !"
			echo
			echo -------------------------========================-------------------------
			echo
			echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
			echo
			read -n 1 -s -r -p "Press any key to EXIT"
			echo
			exit
		fi

	if [ "$count" -eq 0 ]	## for n files in directory
		then
			echo "You don't have selected a folder including files !"
			echo
			echo -------------------------========================-------------------------
			echo
			echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
			echo
			read -n 1 -s -r -p "Press any key to EXIT"
			echo
			exit
		fi

echo -------------------------========================-------------------------
echo "Number of jobs processed concurrently at the same time ? (Refer as parallel CPU cores)"
	echo

	cpu=$(nproc)
	defx=$(( cpu / 2 ))	## for audio files
	defv=$(( cpu / 4 ))	## for video files
	defi=$(( cpu * 2 ))	## for images files
	defy=$(( cpu * 4 ))	## for images files
	defz=$(( cpu * 8 ))	## for testing

	## Put an # in front of "entry" to do an automatic choice.
	
	automatic=1

if [ $automatic -eq 0 ]; then
	entry=$(zenity --scale --value="$defx" --min-value="1" --max-value="$defy" --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have "$cpu" total cores !\n\n\tDefault suggested value is "$defv" for video.\n\n\tDefault suggested value is "$defx" for audio.\n\n\tDefault suggested value is "$defi" for images.\n\n(1 to whatever core you want to use will work anyway !)")
	else
	entry=$defx
	fi

if test -z "$entry"
	then
		echo "Default value of "$defx" (Safe value) will be used. Now continue."
		entry=$cpu
		echo "You have selected : $entry"
		#sleep 3
	else
		echo "You have selected : $entry"
	fi
	
	echo

if [ "$entry" -ge $defi ]; then
	echo
	echo "${yellow}█████████████████████████ WARNING █████████████████████████${reset}"
	echo
	echo "!!! You have chosen a very high parallel work value, this may slow down the calculation rather than speed it up !!!"
	echo
	read -n 1 -s -r -p "Press any key to CONTINUE"
	echo
	fi

echo -------------------------========================-------------------------
## Input_Directory_Output
	echo "Input name, directory and output name : (Debug helper)"
	echo

## Set working path.
	BASEDIR=$(dirname "$0")
	echo Basedir : "$BASEDIR"
	dir=$(pwd)

## file or folder selected
	echo "Working dir : "$dir""
	echo Input file : "$file"
	export VAR="$file"
	echo

## directory section
	INPUT="$(dirname "${VAR}")"	
	echo "Get the last Folder : ${INPUT##*/}"
	echo Base directory : "$(dirname "${VAR}")"
	echo Base name: "$(basename "${VAR}")"
	echo

## Output file name
	name=`echo "$file" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name ext : "$name""
	name1=`echo "$(basename "${VAR}")" | rev | cut -f 2- -d '.' | rev` ## remove extension
	echo "Output name bis : "$name1""
	echo

## Debug data
	echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
	echo

echo -------------------------========================-------------------------
echo "The core/code program."
	echo
	
	rm "/dev/shm/findfiles.txt" 2> /dev/null

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	
	## Working examples
	#convert "$line" -resize 640x480^ -gravity center -crop 640x480+0+0 +repage "$line"-para-640x480.jpg
	#convert "$line" -resize 800x600^ -gravity center -crop 800x600+0+0 +repage "$line"-para-800x600.jpg
	#convert "$line" -resize 1024x768^ -gravity center -crop 1024x768+0+0 +repage "$line"-para-1024x768.jpg
	#convert "$line" -resize 1600x1200^ -gravity center -crop 1600x1200+0+0 +repage "$line"-para-1600x1200.jpg

	# 3840x2160 4k
	# 7680x4320 8k
	# 15360x8640 16k

## find files
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo Finding files...
	
	## Easy way to add a file format, copy paste a new line.
	echo "Will NOT find files in sub folders... Remove -maxdepth 1 to search subfolders."	
	
	#find "$file" -maxdepth 1 -iname '*.AVIF'  >> "/dev/shm/gen/find.txt"		## Compatibility problems, not fully supported
	find "$file" -maxdepth 1 -iname '*.BMP'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.GIF'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.JPEG'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.JPG_MEDIUM'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.JPG_LARGE'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.JPG'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.PNG'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.TIF'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.TIFF'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -iname '*.WEBP'  >> "/dev/shm/findfiles.txt"	

	error $?
	
	cat "/dev/shm/findfiles.txt"

	if [ $logs -eq 1 ]; then
		cat "/dev/shm/findfiles.txt" >> /dev/shm/$random2.txt
		echo "	" >> /dev/shm/$random2.txt
		fi

echo Finding finish.

debug $?

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
echo "Code start, all resolution conversion in parallel."

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "4/3 resolution"
input="/dev/shm/findfiles.txt"
	while IFS= read -r line
	do
	echo "$line"
	parallel -j $entry ::: "convert "$line" -resize 174x174^ -gravity center -crop 174x174+0+0 +repage "$line"-para-174x174.jpg" "convert "$line" -resize 640x480^ -gravity center -crop 640x480+0+0 +repage "$line"-para-640x480.jpg" "convert "$line" -resize 800x600^ -gravity center -crop 800x600+0+0 +repage "$line"-para-800x600.jpg" "convert "$line" -resize 1024x768^ -gravity center -crop 1024x768+0+0 +repage "$line"-para-1024x768.jpg" "convert "$line" -resize 1600x1200^ -gravity center -crop 1600x1200+0+0 +repage "$line"-para-1600x1200.jpg"
	done < "$input"
	error $?
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "16/10 resolution"
input="/dev/shm/findfiles.txt"
	while IFS= read -r line
	do
	echo "$line"
	parallel -j $entry ::: "convert "$line" -resize 1280x800^ -gravity center -crop 1280x800+0+0 +repage "$line"-para-1280x800.jpg" "convert "$line" -resize 1680x1050^ -gravity center -crop 1680x1050+0+0 +repage "$line"-para-1680x1050.jpg" "convert "$line" -resize 1920x1200^ -gravity center -crop 1920x1200+0+0 +repage "$line"-para-1920x1200.jpg"
	done < "$input"
	error $?

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "16/9 resolution"
input="/dev/shm/findfiles.txt"
	while IFS= read -r line
	do
	echo "$line"
	parallel -j $entry ::: "convert "$line" -resize 1280x720^ -gravity center -crop 1280x720+0+0 +repage "$line"-para-1280x720.jpg" "convert "$line" -resize 1600x900^ -gravity center -crop 1600x900+0+0 +repage "$line"-para-1600x900.jpg" "convert "$line" -resize 1920x1080^ -gravity center -crop 1920x1080+0+0 +repage "$line"-para-1920x1080.jpg" "convert "$line" -resize 7680x4320^ -gravity center -crop 7680x4320+0+0 +repage "$line"-para-7680x4320.jpg"
	done < "$input"
	error $?
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Dual screen (2 x 1080p)"
input="/dev/shm/findfiles.txt"
	while IFS= read -r line
	do
	echo "$line"
	convert "$line" -resize 3840x1080^ -gravity center -crop 3840x1080+0+0 +repage "$line"-para-3840x1080.jpg
	done < "$input"
	error $?
	debug $?

echo -------------------------========================-------------------------
echo "Software lead out."
	echo
	echo "Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 primeerror=$primeerror"
	echo
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
	echo "$date $now $me" >>/dev/shm/logs.txt
	echo "	Debug data : debug=$debug error=$error part=$part noquit=$noquit random=$random random2=$random2 automatic=$automatic primeerror=$primeerror" >>/dev/shm/logs.txt
	echo "	File (If present) : $file" >>/dev/shm/logs.txt
	echo " " >>/dev/shm/logs.txt

echo -------------------------===== End of Bash ======-------------------------
## Exit, wait or auto-quit.

	if [ "$primeerror" -ge "1" ]; then
		echo
		echo "	${red}████████████████████████████████████████████${reset}"
		echo "	${red}██                                        ██${reset}"
		echo "	${red}██           ERROR ERROR ERROR            ██${reset}"
		echo "	${red}██                                        ██${reset}"
		echo "	${red}████████████████████████████████████████████${reset}"
		echo
		echo "Numbers of error(s) : $primeerror"
		echo
		functionsmallbar
		echo
		read -n 1 -s -r -p "Press ENTER key to Continue !"
		echo
	else
		echo
		echo "	${green}████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo "	${green}██                                    ██${reset}	${blue}██                                    ██${reset}"
		echo "	${green}██         NO errors detected.        ██${reset}	${blue}██       Time needed : $date       ██${reset}"
		echo "	${green}██                                    ██${reset}	${blue}██                                    ██${reset}"
		echo "	${green}████████████████████████████████████████${reset}	${blue}████████████████████████████████████████${reset}"
		echo
	fi

	if [ "$noquit" -eq "1" ]; then
		echo
		echo "${blue}	█████████████████ NO exit activated ███████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to exit !"
		echo
		exit
		fi

	if [ "$debug" -eq "1" ]; then
		debug
		echo "${blue}		█████ DEBUG WAIT | Program finish. █████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to continue !"
		echo
		fi

	echo
	echo "${green}	███████████████ Finish, quit in 3 seconds █████████████████${reset}"
	sleep 0.5
	echo
	functionsmallbar
	echo
	sleep 1
	exit

## -----===== Start of eula =====-----

	End-user license agreement (eula)

 	JUST DO WHAT THE F*** YOU WANT WITH THE PUBLIC LICENSE
 	
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
 	
 	YOU MUST ACCEPT THESES TERMS OR NOTHING WILL HAPPEN.
 	
 	LostByteSoft no copyright or copyleft we are in the center.
 	
 	You can send your request and your Christmas wishes to this address:
 	
 		Père Noël
 		Pôle Nord, Canada
 		H0H 0H0

## -----===== End of file =====-----
