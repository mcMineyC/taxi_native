# NOTE: Web is no longer supported

# Building

**Linux**
```sh
flutter build linux --release
```

**MacOS**
```sh
flutter build macos --release
```

**Windows**
First set up flutter, then run
```bat
flutter build windows --release
```
To build an installer, cd to Installers and run
```powershell
& 'C:\Program Files (x86)\Inno Setup 6\ISCC.exe' /O+ innoSetupScript.iss
```