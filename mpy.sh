#!/bin/bash
# simple bash script to turn a file into python executable

# python3 shebang line
SHEBANG="#!/usr/bin/env python3\n\n"

# check for -n -h and other options to be added
while getopts "hn:" opt; do
  case $opt in
    n)
	  if [ -f $OPTARG ]
	  then
	  	echo "$OPTARG already exists, use without -n"
	  	exit
	  fi

      echo "-n was triggered, creating new file $OPTARG"

      printf "$SHEBANG" > $OPTARG
      chmod 755 $OPTARG
      exit

      ;;
    
    h)
		echo "USAGE: pass a file as an argument to add python shebang line and mark as executable, use with -n to create new file"
		exit
		;;
    \?)
      echo "Invalid option -$OPTARG" >&2
      exit
      ;;
  esac
done





# get file name from first argument
file=$1

# check that a file is inputed, is writable and doesnt have shebang line
if [ $# -ne 0 ] && [ -f "$file" ] && [ -w "$file" ] && [ ! "$(sed -n '/^#!\/usr\/bin\/env/p;q' "$file")" ]
then
	printf "$SHEBANG" | cat - $file > temp && mv temp $file
	chmod 755 $file

# exit if file has shebang line
elif [ -f "$file" ] && [ "$(sed -n '/^#!\/usr\/bin\/env/p;q' "$file")" ]
then
	echo "$file already contains python shebang line"
	exit
# exit if file doesnt exist
else

	echo "please supply python file as argument or use -n to create new file"
	exit

fi
	
