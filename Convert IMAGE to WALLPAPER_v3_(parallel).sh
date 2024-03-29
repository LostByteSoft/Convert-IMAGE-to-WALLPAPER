#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	start=$SECONDS
	## "NEVER remove dual ## in front of lines. Theses are code annotations."
	## "You can test / remove single # for testing purpose."
	#printf '\033[8;50;80t'		# will resize the window, if needed.
	printf '\033[8;50;110t'		# will resize the window, if needed.
	sleep 0.50
	now=$(date +"%Y-%m-%d_%A_%H:%M:%S")
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`
	echo
echo -------------------------========================-------------------------
	## All variables 0 or 1
	autoquit=0	# autoquit anyway to script takes LESS than 2 min to complete.
	debug=0		# test debug
	error=0		# test error
	part=0		# don't change this value
	noquit=0	# No quit after all operations.
	random=$RANDOM	# Used for temp folders
	echo "Software lead-in. LostByteSoft ; https://github.com/LostByteSoft"
	echo
	echo "Current time : $now"
	echo "Common variables, you can changes theses variables as you wish to test."
	echo
	echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
echo -------------------------========================-------------------------
	echo "Color codes / Informations."
	echo
	echo  "${green}	████████████████     ALL OK / ACTIVE      ████████████████ ${reset}"
	echo   "${blue}	████████████████      INFORMATION(S)      ████████████████ ${reset}"
	echo "${yellow}	████████████████   ATTENTION / INACTIVE   ████████████████ ${reset}"
	echo    "${red}	████████████████   FATAL ERROR / OFFLINE  ████████████████ ${reset}"
	echo
echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2023-01-15_Sunday_10:39:19
	echo
## Software name, what is this, version, informations.
	echo "Software name: Wallpaper creator V3 (parallel)"
	echo "File name : Convert IMAGE to WALLPAPER_v3_(parallel).sh"
	echo What it does ?
	echo "You specify ONE directory and this convert to all"
	echo "resolution conversion in parallel."
	echo Informations :
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo
	echo Tested on : ImageMagick 6.9.11-60 Q16 x86_64
	echo
	echo sudo gedit /etc/ImageMagick-6/policy.xml
	echo convert -list resource
	echo ImgMack policy are SO LOW you need to change them to something usable
	echo ex: mem 12GiB , disk 64GiB
	echo
	echo Need GNU parallel to work.
	echo
	echo "!!! Convert IMAGE to WALLPAPER_v2.sh is the best to use. !!!"
	echo
	echo This software DOES NOT SUPPORT spaces in names ...
	echo No more black bar.
	echo "Create centered image"
	echo "Create RESOLUTION images files for wallpaper"
	echo
	echo "Bash, imagemagick and parallel are used."
	echo
	echo "Don't hack paid software, free software exists and does the job better."
echo -------------------------========================-------------------------
echo Function ${blue}█████${reset} Debug. Activate via source program debug=1.

	debug()
	if [ "$debug" -ge 1 ]; then
		echo
		echo "${blue}█████████████████████████████████ DEBUG ██████████████████████████████████${reset}"
		echo
		echo autoquit=$autoquit debug=$debug error=$error noquit=$quit count=$count part=$part random=$random
		echo
		echo cpu = $cpu defa = $defa defi = $defi defv = $defv defs = $defx defz = $defz
		echo
		echo file = $file
		echo
		echo Basedir = "$BASEDIR"
		echo 
		read -n 1 -s -r -p "Press any key to continue"
		echo
	fi
	
	if [ "$debug" -eq "1" ]; then
		echo
		echo "${blue}██████████████████████████████ DEBUG ACTIVATED ███████████████████████████${reset}"
		echo
		echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
		echo
	fi

echo Function ${red}█████${reset} Error detector. Errorlevel show error msg.

	error()
	if [ "$?" -ge 1 ]; then
		part=$((part+1))
		echo
		echo "${red}█████████████████████████████████ ERROR $part █████████████████████████████████${reset}"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!! Will probably exit !!!"
		echo
		debug=1
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
	fi

echo Function ${green}█████${reset} Auto Quit. If autoquit=1 will automaticly quit.
	if [ "$autoquit" -eq "1" ]; then
		echo
		echo "${green}████████████████████████████ AUTO QUIT ACTIVATED █████████████████████████${reset}"
		echo
	fi
	echo
echo -------------------------========================-------------------------
echo "Check installed requirements !"

if command -v imagemagick >/dev/null 2>&1
	then
		echo "You don't have ' imagemagick ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install imagemagick"
		echo -------------------------========================-------------------------
		sleep 10
		exit
	else
		echo "imagemagick installed continue."
		dpkg -s imagemagick | grep Version
fi

if command -v parallel >/dev/null 2>&1
	then
		echo "Parallel installed continue."
		dpkg -s parallel | grep Version
	else
		echo "You don't have ' parallel ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install parallel"
		echo -------------------------========================-------------------------
		sleep 10
		exit
fi

echo -------------------------========================-------------------------
echo "Enter cores to use ?"
	cpu=$(nproc)
	def=$(( cpu / 2 ))
	#entry=$(zenity --scale --value="$def" --min-value="1" --max-value="$cpu" --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have $cpu cores !\n\nDefault value is $def, it is suggested you only use real cores.\n\n(1 to whatever core you want to use)")

if test -z "$entry"
	then
		echo "Default value of $cpu / 2 will be used. Now continue in 3 seconds."
		entry=$cpu
		echo "You have selected : $entry"
		#sleep 3
	else
		echo "You have selected : $entry"
fi

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
## Variables, for program.

	rm "/dev/shm/findfiles.txt"

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo All lowercase for convert...
	cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;

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
	
	find $file -name '*.png'  >> "/dev/shm/findfiles.txt"
	find $file -name '*.jpg'  >> "/dev/shm/findfiles.txt"
	find $file -name '*.jpeg'  >> "/dev/shm/findfiles.txt"
	find $file -name '*.bmp'  >> "/dev/shm/findfiles.txt"
	find $file -name '*.webp'  >> "/dev/shm/findfiles.txt"
	find $file -name '*.tif'  >> "/dev/shm/findfiles.txt"
	find $file -name '*.tiff'  >> "/dev/shm/findfiles.txt"
	find $file -name '*.gif'  >> "/dev/shm/findfiles.txt"
	error $?
	
	cat "/dev/shm/findfiles.txt"

echo Finding finish.

debug $?

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
echo "Code start, all resolution conversion in parallel."

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "4/3 resolution"
input="/dev/shm/findfiles.txt"
	while IFS= read -r "line"
	do
	echo "$line"
	parallel -j $entry ::: "convert "$line" -resize 640x480^ -gravity center -crop 640x480+0+0 +repage "$line"-para-640x480.jpg" "convert "$line" -resize 800x600^ -gravity center -crop 800x600+0+0 +repage "$line"-para-800x600.jpg" "convert "$line" -resize 1024x768^ -gravity center -crop 1024x768+0+0 +repage "$line"-para-1024x768.jpg" "convert "$line" -resize 1600x1200^ -gravity center -crop 1600x1200+0+0 +repage "$line"-para-1600x1200.jpg"
	done < "$input"
	error $?
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "16/10 resolution"
input="/dev/shm/findfiles.txt"
	while IFS= read -r "line"
	do
	echo "$line"
	parallel -j $entry ::: "convert "$line" -resize 1280x800^ -gravity center -crop 1280x800+0+0 +repage "$line"-para-1280x800.jpg" "convert "$line" -resize 1680x1050^ -gravity center -crop 1680x1050+0+0 +repage "$line"-para-1680x1050.jpg" "convert "$line" -resize 1920x1200^ -gravity center -crop 1920x1200+0+0 +repage "$line"-para-1920x1200.jpg"
	done < "$input"
	error $?

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "16/9 resolution"
input="/dev/shm/findfiles.txt"
	while IFS= read -r "line"
	do
	echo "$line"
	parallel -j $entry ::: "convert "$line" -resize 1280x720^ -gravity center -crop 1280x720+0+0 +repage "$line"-para-1280x720.jpg" "convert "$line" -resize 1600x900^ -gravity center -crop 1600x900+0+0 +repage "$line"-para-1600x900.jpg" "convert "$line" -resize 1920x1080^ -gravity center -crop 1920x1080+0+0 +repage "$line"-para-1920x1080.jpg" "convert "$line" -resize 7680x4320^ -gravity center -crop 7680x4320+0+0 +repage "$line"-para-7680x4320.jpg"
	done < "$input"
	error $?
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo Dual screen
	input="/dev/shm/findfiles.txt"
	while IFS= read -r "line"
	do
	echo "$line"
	convert "$line" -resize 3840x1080^ -gravity center -crop 3840x1080+0+0 +repage "$line"-para-3840x1080.jpg
	done < "$input"
	error $?

echo -------------------------========================-------------------------
## Software lead out
	echo "Finish... with numbers of actions : $part"
	echo "This script take $(( SECONDS - start )) seconds to complete."
	date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
	echo "Time needed: $date"
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
echo -------------------------========================-------------------------
	echo "If a script takes MORE than 120 seconds to complete it will ask"
	echo "you to press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
	if [ "$noquit" -eq "1" ]; then
		echo
		echo "${blue}	█████████████████ NO exit activated ███████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press ENTER key to exit !"
		exit
		fi

	if [ "$autoquit" -eq "1" ]
		then
			echo
			echo "${green}	███████████████ Finish, quit in 3 seconds █████████████████${reset}"
			echo
			sleep 2
			echo
		else
		{
			if [ "$debug" -eq "1" ]; then
				echo
				echo "${blue}		█████ DEBUG WAIT | Program finish. █████${reset}"
				echo
				echo "Debug data : autoquit=$autoquit debug=$debug error=$error part=$part noquit=$noquit random=$random"
				echo
				read -n 1 -s -r -p "Press ENTER key to continue !"
				echo
			fi
		if [ $(( SECONDS - start )) -gt 120 ]
			then
				echo
				echo "Script takes more than 120 seconds to complete."
				echo
				echo "${blue}	█████████████████████ Finish ███████████████████████${reset}"
				echo
				read -n 1 -s -r -p "Press ENTER key to exit !"
				echo
			else
				echo
				echo "Script takes less than 120 seconds to complete."
				echo
				echo "${green}	█████████████████████ Finish ███████████████████████${reset}"
				echo
				echo "Auto-quit in 3 sec. (You can press X)"
				echo
				sleep 3
			fi
		}
		fi
	exit

## -----===== End of bash =====-----

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
