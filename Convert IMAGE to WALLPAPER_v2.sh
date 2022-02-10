#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;30;80t'		# will resize the window, if needed.
	printf '\033[8;40;80t'		# will resize the window, if needed.
	#printf '\033[8;40;125t'	# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.

## Function Error detector. If errorlevel is 1 or greater will show this.

error()
	{
	if [ "$?" -ge 1 ]; then
		echo
		echo "!!! ERROR was detected !!! Press ENTER key to terminate !!!"
		echo
		echo "This script take $(( SECONDS - start )) seconds to complete."
		date=$(date -d@$(( SECONDS - start )) -u +%H:%M:%S)
		echo "Time needed: $date"
		echo
		echo "${red}ERROR █████████████████████████████ ERROR █████████████████████████████ ERROR ${reset}"
		read name
		exit
	fi
	}
	
echo -------------------------========================-------------------------
## Software lead-in
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 3`
	reset=`tput sgr0`
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	echo
	echo Version compiled on : Also serves as a version
	echo 2022-02-07_Monday_06:11:48
echo -------------------------========================-------------------------
## Software name, what is this, version, informations.
	echo "Software name: Wallpaper creator V2"
	echo "File name : Convert IMAGE to WALLPAPER_v2.sh"
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
	echo No more black bar.
	echo
	echo "!!! Convert IMAGE to WALLPAPER_v2.sh is the best to use. !!!"
	echo
	echo "Create centered image"
	echo "Create RESOLUTION images files for wallpaper"
	echo
	echo "Bash, imagemagick and parallel are used."
	echo
	echo "Don't hack paid software, free software exists and does the job better."
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
fi
echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	#file=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file" --directory)
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
	part=0
	
	if zenity --question --text="Convert only your screen resulution ?"
	then
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	res=$(xdpyinfo | awk '/dimensions/{print $2}')
	echo "$res resolution"
	convert "$file" -resize $res^ -gravity center -crop $res+0+0 +repage "$name"-$res.jpg
		error $?
	else

echo "Code start"

	# 3840x2160 4k
	# 7680x4320 8k
	# 15360×8640 16k
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"	
	echo "4/3 resolution"
	#convert "$file" -resize 800x600^ -gravity center -crop 800x600+0+0 +repage "$name"-800x600.jpg
	#convert "$file" -resize 1024x768^ -gravity center -crop 1024x768+0+0 +repage "$name"-1024x768.jpg
	#convert "$file" -resize 1600x1200^ -gravity center -crop 1600x1200+0+0 +repage "$name"-1600x1200.jpg
		error $?
	
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "16/10 resolution"
	#convert "$file" -resize 1280x800^ -gravity center -crop 1280x800+0+0 +repage "$name"-1280x800.jpg
	#convert "$file" -resize 1680x1050^ -gravity center -crop 1680x1050+0+0 +repage "$name"-1680x1050.jpg
		error $?

	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "16/9 resolution"
	convert "$file" -resize 1600x900^ -gravity center -crop 1600x900+0+0 +repage "$name"-1600x900.jpg
	convert "$file" -resize 1920x1080^ -gravity center -crop 1920x1080+0+0 +repage "$name"-1920x1080.jpg		# 1080p
	convert "$file" -resize 3840x2160^ -gravity center -crop 3840x2160+0+0 +repage "$name"-3840x2160.jpg		# 4k
	#convert "$file" -resize 7680x4320^ -gravity center -crop 7680x4320+0+0 +repage "$name"-7680x4320.jpg		# 8k
	#convert "$file" -resize 15360×8640^ -gravity center -crop 15360×8640+0+0 +repage "$name"-15360×8640.jpg	# 16k
		error $?
		
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	echo "Special resolution, dual screen"
	#convert "$file" -resize 3840x1080^ -gravity center -crop 3840x1080+0+0 +repage "$name"-3840x1080.jpg
		error $?

	fi

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
	echo "If a script takes MORE than 120 seconds to complete it will ask you to"
	echo "press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
	echo

## Exit, wait or auto-quit.
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
