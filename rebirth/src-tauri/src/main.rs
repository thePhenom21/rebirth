// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]


use std::ffi::OsString;
use std::path::Iter;

// Learn more about Tauri commands at https://tauri.app/v1/guides/features/command
#[tauri::command]
fn create_app(appname: &str,url: &str) -> String {


    let args = ["-y"];
    let app_name = Option::from(String::from(appname));


    create_tauri_app::run(args.into_iter(),app_name);

    return String::from("Done!");
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![create_app])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
