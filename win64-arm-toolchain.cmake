include("C:/vcpkg/scripts/buildsystems/vcpkg.cmake")

macro(_add_imported_target target_name file)
    if (NOT EXISTS "${file}")
        message(FATAL_ERROR "The imported target \"${target_name}\" references the file \"${file}\" but this file does not exist.")
    endif()

    if (NOT TARGET ${target_name})
        add_executable(${target_name} IMPORTED)
        set_target_properties(${target_name} PROPERTIES IMPORTED_LOCATION ${file})
    endif()
endmacro()

# use the host versions of these executables
_add_imported_target(Qt5::moc   "C:/Qt/5.15.2/msvc2019_64/bin/moc.exe")
_add_imported_target(Qt5::rcc   "C:/Qt/5.15.2/msvc2019_64/bin/rcc.exe")
_add_imported_target(Qt5::qmake "C:/Qt/5.15.2/msvc2019_64/bin/qmake.exe")
_add_imported_target(Qt5::uic "C:/Qt/5.15.2/msvc2019_64/bin/uic.exe")
_add_imported_target(Qt5::lrelease "C:/Qt/5.15.2/msvc2019_64/bin/lrelease.exe")
