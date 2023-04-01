LostByteSoft ; Convert : Images Wallpaper jpg webp gif

-Convert all to jpg/webp.

-Convert to 2000x2000 jpg/webp.

-Slowdown a gif.

-Determine if folder contain animated webp.

-Convert images for wallpaper for different resolutions.


Features:
---------------------------------------------

Convert IMAGE to WALLPAPER_v2 the V 2 is the version to use.

	Tested on : ImageMagick 6.9.11-60 Q16 x86_64
	
	Convert IMAGE to WALLPAPER_v3_(parallel).sh Need GNU parallel to work.
	
	!!! Convert IMAGE to WALLPAPER_v2.sh is the best to use. !!!
	
	Create centered image, create RESOLUTION images files for wallpaper.
	
	Bash, imagemagick and parallel are used.
	
	NO MORE BLACK BARS in your wallpaper.
	
	Don't hack paid software, free software exists and does the job better.


How to ?
---------------------------------------------

-Make it executable.

-Double click on it, select your file and press enter.

-Files names are pretty revellant to what a files does.

	
Convert image to wallpaper:
---------------------------------------------

	Convert IMAGE to WALLPAPER_v1.sh
		-You select one file and convert to common screen resolutions.
		
	THE BEST TO USE
	Convert IMAGE to WALLPAPER_v2.sh
		-You select one file and convert to multiples resolutions.
		-Convert only to your screen resolution.
		-Convert to any resolution to fill (or remove) all the black bars.
	
	NEED GNU_PARALLEL	
	Convert IMAGE to WALLPAPER_v3 (parallel).sh
		-Convert the selected folder AND sub folder.
		-Use parallel to faster convert.


Convert ALL files:
---------------------------------------------

	Convert ALL to JPG (2000x2000).sh
		Convert images files in folder to JPG format + 1500px.

	Convert ALL to PNG.sh
		Convert images files in folder to PNG format.
		
	Convert ALL to WEBP.sh
		Convert images files in folder to WEBP format.
	
	Convert ALL to WEBP (2000x2000).sh
		Convert images files in folder to WEBP format + 1500px.

	Convert ALL to WEBP (parallel).sh
		Convert images files in folder to WEBP format.

		
Convert ONE files:
---------------------------------------------
		
	Convert to JPG.sh
		Convert one images file to JPG format.
		
	Convert to WEBP.sh
		Convert one images file to WEBP format.

Music and movies tool.
---------------------------------------------

	Creator CoverFolderName.sh
		Create files for music cover album or movie poster folder
		Convert ONE image file to 1000 x 1000 px, poster.jpg
		Convert ONE image file to 750 x 750 px, nameofthefolder.jpg
		Convert ONE image file to 500 x 500 px, cover.jpg

	Creator playlist all music select.sh
		Create an m3u for folder and subfolders

Others files:
---------------------------------------------

	Rename gif to 000_oldname
		Rename a file with 000_ in front
	
	SlowDown_OneFile_Gif_V202303301808
		Slow down the gif you specified

---------------------------------------------

Convert IMAGE to WALLPAPER_v2.sh and select image.
![Screenshot](v2.jpg)

Convert IMAGE to WALLPAPER_v3_(parallel).sh and multiple conversions.
![Screenshot](v3.jpg)

Convert ALL to WEBP (parallel).sh and multiple core conversions.
![Screenshot](v4.webp)

	Policy to change to the file :
	sudo gedit /etc/ImageMagick-6/policy.xml

![Screenshot](policy.jpg)

	Tested on : ImageMagick 6.9.11-60 Q16 x86_64
	
	sudo gedit /etc/ImageMagick-6/policy.xml
	
	convert -list resource
	
	ImgMack policy are SO LOW you need to change them to something usable
	ex: mem 12GiB , disk 64GiB


---------------------------------------------

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

--------------------------------------------------------------------
# --- End of file ---

