# keepassxc-windows-arm64
[KeePassXC](https://keepassxc.org/) is a modern, secure, and open-source password manager that stores and manages your most sensitive information. This repository distributes KeePassXC binaries for Windows on ARM64 (WoA).

Please go to [releases](https://github.com/minnyres/keepassxc-windows-arm64/releases) for the downloads.

## How to build

### Cross compile on Windows x64

There is a [workflow file](https://github.com/minnyres/keepassxc-windows-arm64/blob/main/.github/workflows/ci_windows_arm64.yaml) to cross compile on Windows x64 with GitHub actions. The third-party libraries are built with vcpkg except Qt5.

### Native build on Windows 11 ARM64

#### Preparations

You need to install the following tools to build KeePassXC yourself.
+ [Visual Studio 2022 on ARM64](https://devblogs.microsoft.com/visualstudio/arm64-visual-studio-is-officially-here/)
+ Windows Terminal from Microsoft Store
+ [Jom](https://wiki.qt.io/Jom)
+ [MSYS2-64bit](https://www.msys2.org/)
+ [vcpkg](https://vcpkg.io/en/index.html)

After installing MSYS2, install packages via `pacman`
```
pacman -Syy && pacman -S gperf bison flex mingw-w64-clang-aarch64-cmake mingw-w64-i686-asciidoctor 
```

In Windows Terminal, set the "Command line" for "Developer PowerShell for VS 2022" by replacing `-host_arch=x64` with `-host_arch=arm64`.

![terminal](https://user-images.githubusercontent.com/40790553/204278525-3034871a-4afb-49b3-84de-5b2398ba9434.png)

#### Build 

Open the "Developer PowerShell for VS 2022" in Windows Terminal. Install the dependencies (except Qt) via vcpkg:
```
.\vcpkg.exe install argon2 botan minizip readline zlib libqrencode --triplet=arm64-windows
```
Set up variables
```
$vcpkg_dir="d:\git\vcpkg"
$jom_dir="d:\jom_1_1_3"
$qt_install_dir="d:\Qt\Qt_5.15.10_vs2022_arm64"
$msys2_dir="d:\msys64"
$keepassxc_install_dir="d:\keepassxc"
```
where 
+ `vcpkg_dir` is the path of vcpkg root directory
+ `jom_dir` is the path of jom root directory
+ `qt_install_dir` is the place to install Qt
+ `msys2_dir` is the path of MSYS2 root directory
+ `keepassxc_install_dir` is the place to install KeePassXC

Now run the PowerShell script to build Qt and KeePassXC
```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
.\build-qt.ps1
.\build-keepassxc.ps1
```
