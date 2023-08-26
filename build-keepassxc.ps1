$ErrorActionPreference = "Stop"

$env:path += ";$qt_install_dir\bin;$jom_dir;$vcpkg_dir\packages\zlib_arm64-windows\bin;$msys2_dir\usr\bin"
$env:path += ";$msys2_dir\mingw32\bin"

$keepassxc_ver = "2.7.6"
$keepassxc_url = "https://github.com/keepassxreboot/keepassxc/releases/download/$keepassxc_ver/keepassxc-$keepassxc_ver-src.tar.xz"

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest "$keepassxc_url" -outfile "keepassxc-$keepassxc_ver-src.tar.xz"
Invoke-Expression "$msys2_dir\usr\bin\tar -xf keepassxc-$keepassxc_ver-src.tar.xz"

Set-Location  "keepassxc-$keepassxc_ver"
mkdir build 
Set-Location  build

Invoke-Expression "$msys2_dir\clangarm64\bin\cmake -G 'NMake Makefiles JOM' -DWITH_XC_ALL=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$keepassxc_install_dir -DCMAKE_TOOLCHAIN_FILE=$vcpkg_dir\scripts\buildsystems\vcpkg.cmake .."
jom
jom install

Set-Location  $keepassxc_install_dir
windeployqt --release KeePassXC.exe
Copy-Item $vcpkg_dir\installed\arm64-windows\bin\zlib1.dll .
Copy-Item $vcpkg_dir\installed\arm64-windows\bin\minizip.dll .
Copy-Item $vcpkg_dir\installed\arm64-windows\bin\qrencode.dll .
Copy-Item $vcpkg_dir\installed\arm64-windows\bin\argon2.dll .
Copy-Item $vcpkg_dir\installed\arm64-windows\bin\botan.dll .