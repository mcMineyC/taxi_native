@echo off
REM Choose one of the following Redistributable files to install
::vc_redist.x86.exe    REM remove leading :: to install Redistributable for x86
vc_redist.x64.exe    REM remove leading :: to install Redistributable for x64
::vc_redist.arm64.exe  REM remove leading :: to install Redistributable for ARM64
mkdir "C:\Program Files\Taxi"
copy *.exe "C:\Program Files\Taxi"
copy *.dll "C:\Program Files\Taxi"
mkdir "C:\Program Files\Taxi\data"
mkdir "C:\Program Files\Taxi\data\flutter_assets"
mkdir "C:\Program Files\Taxi\data\flutter_assets\fonts"
mkdir "C:\Program Files\Taxi\data\flutter_assets\shaders"
copy *.ttf "C:\Program Files\Taxi\data\flutter_assets\fonts"
copy *.otf "C:\Program Files\Taxi\data\flutter_assets\fonts"
copy *.frag "C:\Program Files\Taxi\data\flutter_assets\shaders"
copy AssetManifest.json "C:\Program Files\Taxi\data\flutter_assets"
copy FontManifest.json "C:\Program Files\Taxi\data\flutter_assets"
copy AssetManifest.bin "C:\Program Files\Taxi\data\flutter_assets"
copy app.so "C:\Program Files\Taxi\data"
copy icudtl.dat "C:\Program Files\Taxi\data"