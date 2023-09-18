#!/bin/bash
while getopts u:a: flag
do
    case "${flag}" in
        u) url=${OPTARG};;
        a) appname=${OPTARG};;
    esac
done

parsed_name=$"{\n\x22build\x22: {\n\x22beforeDevCommand\x22: \x22\x22,\n \x22beforeBuildCommand\x22: \x22\x22,\n\x22devPath\x22: \x22../src\x22,\n\x22distDir\x22: \x22../src\x22,\n\x22withGlobalTauri\x22: true\n},\n\x22package\x22: {\n\x22productName\x22: \x22$appname\x22,\n\x22version\x22: \x220.0.0\x22\n},\n\x22tauri\x22: {\n\x22allowlist\x22: {\n\x22all\x22: false,\n\x22shell\x22: {\n\x22all\x22: false,\n\x22open\x22: true\n}\n},\n\x22bundle\x22: {\n\x22active\x22: true,\n\x22targets\x22: \x22all\x22,\n\x22identifier\x22: \x22com.cosulabs.appname\x22,\n\x22icon\x22: [\n\x22icons/32x32.png\x22,\n\x22icons/128x128.png\x22,\n\x22icons/128x128@2x.png\x22,\n \x22icons/icon.icns\x22,\n\x22icons/icon.ico\x22\n]\n },\n\x22security\x22: {\n\x22csp\x22: null\n},\n\x22windows\x22: [\n{\n\x22fullscreen\x22: false,\n\x22resizable\x22: true,\n\x22title\x22: \x22$appname\x22,\n\x22width\x22: 1080,\n\x22height\x22: 720\n }\n]\n }\n}\n"


echo $parsed_name

mkdir builder
cd $PWD/builder
npm create tauri-app@latest -- $appname -y 
wait
cd $appname
npm install 
wait
cd src
rm -r *
echo "<meta http-equiv=\"Refresh\" content=\"0; url='$url'\" />" >> index.html
cd ..
cd src-tauri
rm tauri.conf.json
cd ..
rm -r target
wait
cd ..
wait
cd ..
wait
echo $PWD
echo -e "$parsed_name" > "$PWD/builder/$appname/src-tauri/tauri.conf.json"
wait
echo $PWD
wait
cd $PWD/builder/$appname
cd src-tauri
cargo install tauri-cli
wait
cd ..
cargo tauri build
wait
cp $PWD/src-tauri/target/release/$appname ../..
wait
cd ../..
rm -r builder
clear
echo Done!




