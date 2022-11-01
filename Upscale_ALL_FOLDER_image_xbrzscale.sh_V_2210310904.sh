#!/bin/bash
#!/usr/bin/ffmpeg
## -----===== Start of bash =====-----
	#printf '\033[8;40;80t'		# will resize the window, if needed.
	#printf '\033[8;40;125t'	# will resize the window, if needed.
	printf '\033[8;40;150t'	# will resize the window, if needed.
	#printf '\033[8;50;200t'	# will resize the window, if needed.
	sleep 0.50
	
echo -------------------------========================-------------------------
## Software lead-in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
	red=`tput setaf 1`
	green=`tput setaf 2`
	yellow=`tput setaf 11`
	blue=`tput setaf 12`
	reset=`tput sgr0`

## Common variables, you can changes theses variables as you wish to test (0 or 1)
	autoquit=0	# autoquit anyway to script takes more than 2 min to complete
	debug=0		# test debug
	error=0		# test error
	part=0		# don't change this value
	
	echo autoquit=$autoquit debug=$debug error=$error part=$part

echo -------------------------========================-------------------------
	echo Version compiled on : Also serves as a version
	echo 2022-10-31_Monday_09:04:40
	echo
## Software name, what is this, version, informations.
	echo "Software name: Upscale image(s)"
	echo
	echo Example:
	echo xbrzscale
	echo usage: xbrzscale scale_factor input_image output_image
	echo scale_factor can be between 2 and 6
	echo
	echo Known bugs :
	echo
	echo Images bigger than 10000x10000 create errors.
	echo
	echo Informations :
	echo
	echo JPEG is also defined with the additional extensions: jpg jpe jif jfif and jfi
	echo
	echo https://jaibeermalik.wordpress.com/2012/10/18/imagemagick-mogrify-vs-convert-which-one-to-use-and-when/
	echo
	echo "By LostByteSoft, no copyright or copyleft"
	echo "https://github.com/LostByteSoft"
	echo
	echo "Don't hack paid software, free software exists and does the job better."

echo -------------------------========================-------------------------
echo "Check installed requirement !"

if command -v xbrzscale >/dev/null 2>&1
	then
		echo "xbrzscale installed continue."
		dpkg -s xbrzscale | grep Version
	else
		echo "You don't have ' xbrzscale ' installed, now exit in 10 seconds."
		echo "Add with : sudo apt-get install xbrzscale"
		echo -------------------------========================-------------------------
		sleep 10
		exit
fi

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
		#exit
	fi
	
		if [ "$debug" -eq "1" ]; then
		echo
		echo "${yellow}██████████████████████████████ DEBUG ACTIVATED ███████████████████████████${reset}"
		echo
		echo Continue in 3 seconds...
		sleep 3
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
	
echo -------------------------========================-------------------------
## The code program.

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
echo "Numbers of xbrzscale scale_factor"
	entry2=$(zenity --scale --value="2" --min-value="2" --max-value="6" --title "Numbers of xbrzscale scale_factor" --text "Numbers of xbrzscale scale_factor, 2 (lower) to 6 (bigger).\n\n\tSuggested default to 2.")

if test -z "$entry"
	then
		echo "Default value of 2 will be used. Now continue."
		entry=2
		echo "You have selected : $entry"
		#sleep 3
	else
		echo "You have selected : $entry"
fi

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	echo Delete /dev/shm/findfolder.txt
	rm "/dev/shm/findfolder.txt"

## find files
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	echo Finding files...

	## Easy way to add a file format, copy paste a new line.
	echo "Will find files in sub folders too...."
	find $file -maxdepth 1 -iname '*.png'  >> "/dev/shm/findfolder.txt"
	find $file -maxdepth 1 -iname '*.jpg'  >> "/dev/shm/findfolder.txt"
	find $file -maxdepth 1 -iname '*.jpeg'  >> "/dev/shm/findfolder.txt"
	find $file -maxdepth 1 -iname '*.bmp'  >> "/dev/shm/findfolder.txt"
	find $file -maxdepth 1 -iname '*.gif'  >> "/dev/shm/findfolder.txt"	#no animated gif UpScale
	find $file -maxdepth 1 -iname '*.tif'  >> "/dev/shm/findfolder.txt"
	find $file -maxdepth 1 -iname '*.tiff'  >> "/dev/shm/findfolder.txt"
	find $file -maxdepth 1 -iname '*.webp'  >> "/dev/shm/findfolder.txt"
	
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	echo List files...
	cat "/dev/shm/findfolder.txt"
	
part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"
	echo Finding finish, with file count :
	wc -l < "/dev/shm/findfolder.txt"

part=$((part+1))
echo "-------------------------===== Section $part =====-------------------------"

	echo Conversion started...
	echo Simple convert 1 file at a time.
	{
	input="/dev/shm/findfolder.txt"
		while IFS= read -r "line"
		do
			conv=$((conv+1))
			echo Conversion number $conv
			echo "$line"
			echo xbrzscale $entry "$line" "$line"_UpScale.webp
			xbrzscale $entry "$line" "$line"_UpScale.jpg		## jpg format
			#xbrzscale $entry "$line" "$line"_UpScale.webp		## webp format
		done < "$input"
	}
	error $?

	echo "Reconvert (Yes or No (Suggest Yes))"
	if zenity --question --text="Do you want to reconvert to save space ? (Yes or No (Suggest Yes))"
	then
		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		## convert to webp
			{
			input="/dev/shm/findfolder.txt"
			while IFS= read -r "line"
			do
				conv=$((conv+1))
				echo Conversion number $conv
				echo "$line"
				#echo convert "$line"_UpScale.webp"" -format webp -define webp:near-lossless=80 "$line"_UpScale.webp""	## webp
				#convert "$line"_UpScale.webp"" -format webp "$line"_UpScale.webp""					## webp
				echo convert "$line"_UpScale.jpg"" -format jpg -quality 95 "$line"_UpScale.jpg""
				mogrify "$line"_UpScale.jpg"" -format jpg -quality 95 "$line"_UpScale.jpg""
				done < "$input"
			}
		else

		part=$((part+1))
		echo "-------------------------===== Section $part =====-------------------------"
		echo "Not reconverted."

	fi
	error $?

	echo Conversion finish...

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
