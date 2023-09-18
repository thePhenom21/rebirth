// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

use std::future::Future;
use std::io::BufRead;
use std::process::Command;
use run_script::run;
use run_script::types::ScriptOptions;

// Learn more about Tauri commands at https://tauri.app/v1/guides/features/command
async fn util(appname :&str,url : &str){

    let script = r#"
        #!/bin/bash
url=$1
appname=$2

parsed_name=$"{\n\x22build\x22: {\n\x22beforeDevCommand\x22: \x22\x22,\n \x22beforeBuildCommand\x22: \x22\x22,\n\x22devPath\x22: \x22../src\x22,\n\x22distDir\x22: \x22../src\x22,\n\x22withGlobalTauri\x22: true\n},\n\x22package\x22: {\n\x22productName\x22: \x22$appname\x22,\n\x22version\x22: \x220.0.0\x22\n},\n\x22tauri\x22: {\n\x22allowlist\x22: {\n\x22all\x22: false,\n\x22shell\x22: {\n\x22all\x22: false,\n\x22open\x22: true\n}\n},\n\x22bundle\x22: {\n\x22active\x22: true,\n\x22targets\x22: \x22all\x22,\n\x22identifier\x22: \x22com.cosulabs.appname\x22,\n\x22icon\x22: [\n\x22icons/32x32.png\x22,\n\x22icons/128x128.png\x22,\n\x22icons/128x128@2x.png\x22,\n \x22icons/icon.icns\x22,\n\x22icons/icon.ico\x22\n]\n },\n\x22security\x22: {\n\x22csp\x22: null\n},\n\x22windows\x22: [\n{\n\x22fullscreen\x22: false,\n\x22resizable\x22: true,\n\x22title\x22: \x22$appname\x22,\n\x22width\x22: 1080,\n\x22height\x22: 720\n }\n]\n }\n}\n"


mv $appname builder
cd builder
npm install
wait
rm -r src
mkdir src
cd src
echo "<meta http-equiv=\"Refresh\" content=\"0; url='$url'\" />" >> index.html
cd ..
cd src-tauri
rm tauri.conf.json
cd ..
cd ..
echo -e "$parsed_name" > builder/src-tauri/tauri.conf.json
wait
cd builder
npm run tauri build
wait
cd ..
cp builder/src-tauri/target/release/$appname .
wait
rm -r builder
echo Done!
exit 0
    "#;

    let options = ScriptOptions::new();

    let mut f = String::new();


    let _ = run_script::run_script!(
        script,
        &vec![url.to_string(), appname.to_string()],
        &options
        )
        .unwrap();
}


#[tauri::command]
async fn create_app(appname: &str,url: &str) -> Result<String,String> {


    let args = ["-y",appname];
    let app_name = Option::from(String::from(appname));




    create_tauri_app::run(args.into_iter(),app_name);



    let ret = util(appname,url).await;
    return Ok("Done!".to_string());


}

#[tokio::main]
async fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![create_app])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}