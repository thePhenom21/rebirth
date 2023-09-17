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
rm -r target
wait
cd ..
wait
cd ..
wait
echo $PWD
cp $PWD/tauri.conf.json $PWD/builder/$appname/src-tauri/tauri.conf.json
wait
cd $PWD/builder/$appname
cd src-tauri
cargo install tauri-cli
wait
cd ..
cargo tauri build
wait
cp $PWD/src-tauri/target/release/twebpage ../..
wait
cd ../..
mv twebpage $appname




