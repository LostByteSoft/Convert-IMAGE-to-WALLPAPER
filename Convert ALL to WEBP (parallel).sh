#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	#printf '\033[8;40;125t'	# will resize the window, if needed.
	printf '\033[8;40;150t'		# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.
	sleep 0.50
	
echo -------------------------========================-------------------------
echo "Software lead-in."

	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`

echo -------------------------========================-------------------------
echo "Common variables, you can changes theses variables as you wish to test (0 or 1)."

	autoquit=0	# autoquit anyway to script takes more than 2 min to complete
	debug=0		# test debug
	error=0		# test error
	part=0		# don't change this value
	NOquit=0	# No quit after all operations.

	echo autoquit=$autoquit debug=$debug error=$error part=$part NOquit=$NOquit

echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2022-11-08_Tuesday_09:04:25
	echo
## Software name, what is this, version, informations.
	echo "Software name: Convert ALL images to WEBP +50 parallel"
	echo "File name : Convert ALL to WEBP +50 (parallel).sh"
	echo
	echo "What it does ?  Convert ALL to WEBP image format with gnu parallel."
	echo "Use folder select"
	echo
	echo "Read me for this file (and known bugs) :"
	echo
	echo "It's ok for image conversion to use double core value because the"
	echo "time lost between open, close and save image on disk."
	echo
	echo "Cannot add new lettering or numbers to converted file."
	echo
	echo "Informations : (EULA at the end of file, open in text.)"
	echo "By LostByteSoft, no copyright or copyleft all byte is lost."
	echo "https://github.com/LostByteSoft"
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
echo Function Debug. Activate via source program debug=1.

debug()
	if [ "$debug" -ge 1 ]; then
		echo
		echo "${yellow}█████████████████████████████████ DEBUG ██████████████████████████████████${reset}"
		echo
		echo debug = $debug 	part = $part 	autoquit = $autoquit file = $file
		echo
		echo entry = $entry	entry2 = $entry2 	
		echo
		echo file = $file
		echo
		echo cpu = $cpu
		echo defv = $defv
		echo defs = $defx
		echo defa = $defa
		echo defi = $defi
		echo defz = $defz
		echo 
		read -n 1 -s -r -p "Press any key to continue"
		echo
		#exit
	fi
	
		if [ "$debug" -eq "1" ]; then
		echo
		echo "${yellow}██████████████████████████████ DEBUG ACTIVATED ███████████████████████████${reset}"
		echo
		echo Continue in 1 seconds...
		sleep 1
	fi

echo Function Error detector. If errorlevel is 1 or greater will show error msg.
error()
	if [ "$?" -ge 1 ]; then
		part=$((part+1))
		echo
		echo "${red}█████████████████████████████████ ERROR $part █████████████████████████████████${reset}"
		echo
		echo "!!! ERROR was detected !!! Press ANY key to try to CONTINUE !!! Will probably exit !!!"
		echo
		read -n 1 -s -r -p "Press any key to CONTINUE"
		echo
	fi

echo Function Auto Quit. If autoquit=1 will automaticly quit.
	if [ "$autoquit" -eq "1" ]; then
		echo
		echo "${blue}████████████████████████████ AUTO QUIT ACTIVATED █████████████████████████${reset}"
		echo
	fi

echo -------------------------========================-------------------------
echo "Number of jobs processed concurrently at the same time ? (Refer as parallel CPU cores)"
	cpu=$(nproc)
	defx=$(( cpu / 2 ))	## for audio files
	defv=$(( cpu / 4 ))	## for video files
	defi=$(( cpu * 2 ))	## for images files
	defy=$(( cpu * 4 ))	## for images files
	defz=$(( cpu * 8 ))	## for images files

	### Put an # in front of entry to do an automatic choice.

	#entry=$(zenity --scale --value="$(nproc)" --min-value="1" --max-value="32" --title "Convert files with Multi Cores Cpu" --text "How many cores do you want to use ? You have "$cpu" total cores !\n\n\tDefault suggested value is "$defv" for video.\n\n\tDefault suggested value is "$defx" for audio.\n\n\tDefault suggested value is ("$(nproc)" xbrzscale) "$defi" for images.\n\n(1 to whatever core you want to use will work anyway !)")

if test -z "$entry"
	then
		echo "Default value of "$(nproc)" (Safe value) will be used. Now continue."
		entry=$(nproc)
		echo "You have selected : $entry"
		#sleep 3
	else
		echo "You have selected : $entry"
fi



if [ "$entry" -ge $defi ]; then
	part=$((part+1))
	echo
	echo "${yellow}█████████████████████████████████ WARNING █████████████████████████████████${reset}"
	echo
	echo "!!! You have chosen a very high parallel work value, this may slow down the calculation rather than speed it up !!!"
	echo
	read -n 1 -s -r -p "Press any key to CONTINUE"
	echo
fi

echo -------------------------========================-------------------------
echo "Select filename using dialog !"

	#file="$(zenity --file-selection --filename=$HOME/$USER --title="Select a file, all format supported")"
	file=$(zenity  --file-selection --filename=$HOME/$USER --title="Choose a directory to convert all file" --directory)
	#file="/$HOME/Downloads"
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

	count=`ls -1 "$file"/*.* 2>/dev/null | wc -l`
	echo Count : $count
	if [ $count != 0 ]
	then 
	echo Folder is NOT empty....
	else
		echo
		echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press any key to EXIT"
		exit
	fi

echo -------------------------========================-------------------------
echo "Input name, directory and output name : (Debug helper)"
## Set working path.
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
	
	echo All lowercase for convert...
	cd "$file" && find . -name '*.*' -exec sh -c ' a=$(echo "$0" | sed -r "s/([^.]*)\$/\L\1/"); [ "$a" != "$0" ] && mv "$0" "$a" ' {} \;
	debug $?
	
echo -------------------------========================-------------------------
echo Gif finder...
count=`ls -1 "$file"/*.gif 2>/dev/null | wc -l`
	echo GIF files search and count is : $count
	find $file -name '*.gif'  >> "/dev/shm/findgif.txt"
	cat "/dev/shm/findgif.txt"
	if [ $count != 0 ]
	then
	if zenity --question --text="Gif files detected, do you want to rename them to *.gif.gif ?"
		then
			echo Finding files...
			echo
			
		{
		input="/dev/shm/findgif.txt"
		while IFS= read -r "line"
		do
		echo Output : "$line".gif
		mv  "$line" "$line".gif
		done < "$input"
		}
	error $?
	fi
	fi

echo -------------------------========================-------------------------
## The code program.
echo Remove temp files...
	rm "/dev/shm/findfiles.txt" 2> /dev/null
	rm "/dev/shm/findgif.txt" 2> /dev/null

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Finding files... (NOT used to convert, just for your eyes.)"
	echo
	## Easy way to add a file format, copy paste a new line.
	echo "Will NOT find files in sub folders."
	echo
	find "$file" -maxdepth 1 -name '*.png'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.jpg'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.jpeg'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.bmp'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.gif'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.tif'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.tiff'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.webp'  >> "/dev/shm/findfiles.txt"
	find "$file" -maxdepth 1 -name '*.avif'  >> "/dev/shm/findfiles.txt"
	echo
	cat "/dev/shm/findfiles.txt"
	echo	
echo Finding finish, with file count :
	echo
	wc -l < "/dev/shm/findfiles.txt"
	echo
	count=`ls -1 "$file"/*.* 2>/dev/null | wc -l`
	#echo Count : $count
	if [ $count != 0 ]
	then 
	echo Folder is NOT empty....
	else
		echo
		echo "${yellow}█████████████████████ NO DATA TO PROCESS █████████████████████${reset}"
		echo
		read -n 1 -s -r -p "Press any key to EXIT"
		exit
	fi
	error $?

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	echo "File count !"
	echo
	#count=`ls -1 "$file"/*.* 2>/dev/null | wc -l`
	echo Total Count : $count
	count=`ls -1 "$file"/*.jpeg 2>/dev/null | wc -l`
	echo "JPEG count is : $count"
	count=`ls -1 "$file"/*.bmp 2>/dev/null | wc -l`
	echo "BMP count is : $count"
	count=`ls -1 "$file"/*.tif 2>/dev/null | wc -l`
	echo "TIF count is : $count"
	count=`ls -1 "$file"/*.tiff 2>/dev/null | wc -l`
	echo "TIFF count is : $count"
	count=`ls -1 "$file"/*.jpg 2>/dev/null | wc -l`
	echo "JPG count is : $count"
	count=`ls -1 "$file"/*.webp 2>/dev/null | wc -l`
	echo "WEBP count is : $count"
	count=`ls -1 "$file"/*.gif 2>/dev/null | wc -l`
	echo "GIF count is : $count"
	count=`ls -1 "$file"/*.png 2>/dev/null | wc -l`
	echo "PNG count is : $count"
	count=`ls -1 "$file"/*.avif 2>/dev/null | wc -l`
	echo "AVIF count is : $count"
	sleep 2

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"

	echo Conversion started
	echo Complex convert multiples file at a time.
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.webp 2>/dev/null | wc -l`
	echo WEBP conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.webp
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.jpeg 2>/dev/null | wc -l`
	echo JPEG conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.jpeg
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.bmp 2>/dev/null | wc -l`
	echo BMP conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.bmp
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.tif 2>/dev/null | wc -l`
	echo TIF conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.tif
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.tiff 2>/dev/null | wc -l`
	echo TIFF conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.tiff
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.jpg 2>/dev/null | wc -l`
	echo JPG conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.jpg
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.gif 2>/dev/null | wc -l`
	echo GIF conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.gif
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.png 2>/dev/null | wc -l`
	echo PNG conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.png
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	count=`ls -1 "$file"/*.avif 2>/dev/null | wc -l`
	echo AVIF conversion and count is : $count
	if [ $count != 0 ]
	then
	parallel -j $entry mogrify -verbose -resize 150% -define webp:lossless=true -format webp ::: "$file"/*.avif
	fi
	error $?
	part=$((part+1))
	echo "-------------------------===== Section $part =====-------------------------"
	error $?
echo Conversion finish...

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo Move files to new folder?
	
	if zenity --question --text="Do you want to move files to ""$file"/webp50" ? (Yes or No))"
	then
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		echo Create folder...
			mkdir -p ""$file"/webp50"
			echo Move files...
			echo ""$file"/'*.webp'" ""$file"/webp50"
			mv ""$file"/"*.webp"" ""$file"/webp50"
	else
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		echo "Files not moved."	
	fi
	error $?

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
	echo "If a script takes MORE than 120 seconds to complete it will ask"
	echo "you to press ENTER to terminate."
	echo
	echo "If a script takes LESS than 120 seconds to complete it will auto"
	echo "terminate after 10 seconds"
	echo

echo -------------------------========================-------------------------
## Exit, wait or auto-quit.
	echo
	echo Processing file or folder of "$name1" finish !
	echo
	debug $?

if [ "$NOquit" -eq "1" ]
	then
	echo "${green}████████████████████████████████ NO exit activated ██████████████████████████████████${reset}"
	read -n 1 -s -r -p "Press ENTER key to exit !"
	exit
	fi

if [ "$autoquit" -eq "1" ]
then
		echo "Script will auto quit in 1 seconds."
		echo
		echo "${blue}██████████████████████████████ Finish Now ████████████████████████████████${reset}"
		echo
		sleep 1
	else
	{
	if [ $(( SECONDS - start )) -gt 120 ]
		then
			echo "Script takes more than 120 seconds to complete."
			echo
			echo "${yellow}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			echo
			echo -------------------------========================-------------------------
			read -n 1 -s -r -p "Press ENTER key to exit !"
		else
			echo "Script takes less than 120 seconds to complete."
			echo
			echo "${green}████████████████████████████████ Finish ██████████████████████████████████${reset}"
			echo
			echo -------------------------========================-------------------------
			echo "Auto-quit in 10 sec. (You can press X)"
			sleep 10
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

## -----===== End of file =====-----
