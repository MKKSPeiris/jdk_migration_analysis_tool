#!/bin/bash
echo " _   _ _                              _  __  __ ";
echo "| | | (_)                            (_)/ _|/ _|";
echo "| |_| |_ _ __  _ __   ___   __ _ _ __ _| |_| |_ ";
echo "|  _  | | '_ \| '_ \ / _ \ / _\` | '__| |  _|  _|";
echo "| | | | | |_) | |_) | (_) | (_| | |  | | | | |  ";
echo "\_| |_/_| .__/| .__/ \___/ \__, |_|  |_|_| |_|  ";
echo "        | |   | |           __/ |               ";
echo "        |_|   |_|          |___/                ";
echo "JDK 11 Migration Analysis Tool V 1.0"

read -p "Enter project dir : " projectDir

if [ ! -d $projectDir"/target/docker" ]; then
  echo -e "\e[91mCould not find generated project binaries.\e[0m"
  echo -e "\e[91mPlease make sure you have build the docker image for this project before scanning\e[0m"
  exit
fi

#Run tattletale
echo -e "\e[32mGenerating dependency report\e[0m"

java -jar 'tattletale-1.1.2.Final/tattletale.jar' $projectDir'/target' $projectDir'/report' & PID=$!

while kill -0 $PID 2> /dev/null;
do for X in '-' '/' '|' '\'; do echo -en "\b$X"; sleep 0.1; done; done 

#Analyze generated classdependson  using the python script
./analysis.py $projectDir"/report/classdependson/index.html"

echo "Done"



