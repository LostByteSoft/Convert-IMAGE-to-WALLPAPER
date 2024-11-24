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
	echo 2024-06-24_Monday_14:11:38
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
echo "The code program. Playlist creator."
	echo Delete temp files...
	rm "/dev/shm/m3u.tmp" 2> /dev/null
	rm "/dev/shm/m3u.tm2" 2> /dev/null

	debug=0

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Finding files..."
	echo file = "$file"
	echo "basename = $(basename "${VAR}")"
	echo

	if zenity --question --no-wrap --text="Do you want to find file with path ?\n\nDefault YES (Yes for no path)"; then

		## finding files WITHOUT path	
		cd "$name" && find . -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.aac' -o -name '*.wav' \) -printf '%f\n'  >> "/dev/shm/m3u.tmp"
		error $?
	
	else

		## finding files WITH path
		cd "$name" && find "$file" -maxdepth 1 -iname '*.AAC'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.AC3'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.AIFF'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.AVI'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.DTS'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.FLAC'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.MKA'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.MKV'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.MP3'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.MP4'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -maxdepth 1 -iname '*.WAV'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.AAC'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.AC3'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.AIFF'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.AVI'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.DTS'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.FLAC'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.MKA'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.MKV'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.MP3'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.MP4'  >> "/dev/shm/m3u.tmp"
		cd "$name" && find "$file" -iname '*.WAV'  >> "/dev/shm/m3u.tmp"
		error $?

	fi
	
	if [ "$debug" -ge 1 ]; then
		debug
		echo
		echo "${blue}█████████████████████████████████ DEBUG 20240624120542 ██████████████████████████████████${reset}"
		echo
		echo file = "$file"
		echo
		echo "basename = "$(basename "${VAR}")""
		echo
		echo Listing finded files NOT in order : m3u.tmp
		echo
		cat "/dev/shm/m3u.tmp"
		echo
		read -n 1 -s -r -p "End debug 1 Press any key to continue"
		echo
		fi

	if [ "$debug" -eq 0 ]; then
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		echo "Listing..."
		echo
		cat "/dev/shm/m3u.tmp"
		echo
		fi
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	#echo "Name sort (Yes or No (Suggest Yes))"
	#if zenity --question --no-wrap --text="Do you want to sort by file name ? (Yes or No (Suggest Yes))"
	#then
		#part=$((part+1))
		#echo "-------------------------===== Section $part =====-------------------------"
		
		echo "Sorting files alphabetically..."
		sort -u "/dev/shm/m3u.tmp" > "/dev/shm/m3u.tm2" 		## -u remove duplicate lines
		echo "Sorting end."

		##cp "/dev/shm/m3u.srt" "$file"/"$(basename "${VAR}")".m3u
		cp "/dev/shm/m3u.tm2" "$file"/"$(basename "${VAR}")".m3u	## copy file to

		echo
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		echo "Files are sorted and m3u is in $file"
		echo
	#else
	#	part=$((part+1))
	#	echo "-------------------------===== Section $part =====-------------------------"
	#	awk -i inplace '!seen[$0]++' "/dev/shm/m3u.tmp"		## remove duplicate lines
	#	cp "/dev/shm/m3u.tmp" "$file"/"$(basename "${VAR}")".m3u
	#	cat "$file"/"$(basename "${VAR}")".m3u
	#	echo
	#	part=$((part+1))
	#	echo "-------------------------===== Section $part =====-------------------------"
	#	echo "Files are NOT sorted and m3u is in $file"
	#fi
	
	if [ "$debug" -ge 1 ]; then
		debug
		echo
		echo "${blue}█████████████████████████████████ DEBUG 20240624131516 ██████████████████████████████████${reset}"
		echo
		echo Listing finded files : m3u.tmp
		echo
		cat "/dev/shm/m3u.tmp"
		echo
		echo Listing sorted and duplicate removed files : m3u.tm2
		echo
		cat "/dev/shm/m3u.tm2"
		echo
		echo "Files are sorted and m3u is in $file"
		echo
		read -n 1 -s -r -p "End debug 2 Press any key to continue"
		echo
		fi

	echo Delete temp files...
	rm "/dev/shm/m3u.tmp" 2> /dev/null
	rm "/dev/shm/m3u.tm2" 2> /dev/null

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
