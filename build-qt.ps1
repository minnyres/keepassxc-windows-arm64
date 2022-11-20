$qt_ver="5.15.7"
$qt_main_ver="5.15"
$qt_url = "https://download.qt.io/archive/qt/$qt_main_ver/$qt_ver/submodules/"
$qtbase = "qtbase-everywhere-opensource-src-$qt_ver.zip"
$qttools = "qttools-everywhere-opensource-src-$qt_ver.zip"
$qtsvg = "qtsvg-everywhere-opensource-src-$qt_ver.zip"
$qtstranslations = "qttranslations-everywhere-opensource-src-$qt_ver.zip"
$qtimageformats = "qtimageformats-everywhere-opensource-src-$qt_ver.zip"

$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest "$qt_url$qtbase" -outfile "$qtbase"
Invoke-WebRequest "$qt_url$qttools" -outfile "$qttools"
Invoke-WebRequest "$qt_url$qtsvg" -outfile "$qtsvg"
Invoke-WebRequest "$qt_url$qtstranslations" -outfile "$qtstranslations"
Invoke-WebRequest "$qt_url$qtimageformats" -outfile "$qtimageformats"

Expand-Archive -LiteralPath "$qtbase" -DestinationPath $pwd
Expand-Archive -LiteralPath "$qttools" -DestinationPath $pwd
Expand-Archive -LiteralPath "$qtsvg" -DestinationPath $pwd
Expand-Archive -LiteralPath "$qtstranslations" -DestinationPath $pwd
Expand-Archive -LiteralPath "$qtimageformats" -DestinationPath $pwd

$env:path+=";$qt_install_dir\bin;$jom_dir;$vcpkg_dir\packages\zlib_arm64-windows\bin;$vcpkg_dir\packages\icu_arm64-windows\bin;$msys2_dir\usr\bin"
$current_dir=$pwd

cd "qtbase-everywhere-src-$qt_ver"
mkdir build 
cd build
../configure -prefix $qt_install_dir -opensource -confirm-license -release -nomake examples -nomake tests -icu -system-zlib -schannel -no-openssl ICU_PREFIX="$vcpkg_dir\packages\icu_arm64-windows" ZLIB_PREFIX="$vcpkg_dir\packages\zlib_arm64-windows"
jom 
jom install

cd $current_dir
cd "qttools-everywhere-src-$qt_ver"
mkdir build 
cd build
qmake ..
jom
jom install


cd $current_dir
cd "qtimageformats-everywhere-src-$qt_ver"
mkdir build 
cd build
qmake ..
jom
jom install

cd $current_dir
cd "qtsvg-everywhere-src-$qt_ver"
mkdir build 
cd build
qmake ..
jom
jom install

cd $current_dir
cd "qtstranslations-everywhere-src-$qt_ver"
mkdir build 
cd build
qmake ..
jom
jom install
