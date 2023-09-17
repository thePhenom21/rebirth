while getopts u:a: flag
do
    case "${flag}" in
        u) url=${OPTARG};;
        a) appname=${OPTARG};;
    esac
done


mkdir builder
cd $PWD/builder
cargo create-tauri-app -y $appname
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
cd ..
cd ..
cp tauri.conf.json $PWD/builder/src-tauri
cd $PWD/builder/$appname
npm run tauri build
wait



