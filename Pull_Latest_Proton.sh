#!/bin/bash
#Writing up a test scrpt for my monthly cron

log=/var/log/proton.log
Storage=~/Downloads/Proton/
steamtools=~/.steam/root/compatibilitytools.d

#create logfile or overwrite
printf "Log File - " > $log

#Append date to log file
date >> $log

#establish our url
url=https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest >> $log

echo $url >> $log

#curl to pull the tag name we need
tag=$(curl --silent -k ${url} | grep tag_name | cut -d \" -f 4)

echo $tag >> $log

file1=$(ls $Storage)
file2="$tag.tar.gz"

if [ "$file1" = "$file2" ]; then
	echo "No update today" >> $log
	exit
else
	echo "UPDATE!" >> $log
fi

#wget our fucking file
wget -P $Storage https://github.com/GloriousEggroll/proton-ge-custom/releases/download/$tag/$tag.tar.gz -o $log

#unzip that bitch
unzip=$(tar -xvf $Storage$tag.tar.gz -C $steamtools)

exit


