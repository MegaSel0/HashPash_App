cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(HashPash LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Gui Qml Quick)
find_package(OpenSSL REQUIRED)


if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(HashPash src/main.cpp
    backend/SignVerify.h
    backend/SignVerify.cpp
)

qt_add_resources(HashPash "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(HashPash PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    OpenSSL::Crypto
)

if (BUILD_QDS_COMPONENTS)
include(${CMAKE_CURRENT_SOURCE_DIR}/qmlcomponents)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)

if (LINK_INSIGHT)
    include(${CMAKE_CURRENT_SOURCE_DIR}/insight)
endif ()

include(GNUInstallDirs)
install(TARGETS HashPash
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# make IDEs aware of the QML import path
set(QML_IMPORT_PATH ${PROJECT_BINARY_DIR}/qml CACHE PATH
    "Path to the custom QML components defined by the project")


# # اضافه کردن CPack
# include(CPack)

# # تنظیمات CPack
# set(CPACK_GENERATOR "DEB;RPM;TGZ") # انتخاب نوع بسته (DEB برای Debian/Ubuntu، RPM برای Red Hat/Fedora، TGZ برای فایل فشرده)
# set(CPACK_PACKAGE_NAME "Test_3App")
# set(CPACK_PACKAGE_VERSION "1.0.0")
# set(CPACK_DEBIAN_PACKAGE_MAINTAINER "your-email@example.com")
# set(CPACK_PACKAGE_DESCRIPTION "This is a description of Test_3App.")
# set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Test_3App - a brief summary.")
# set(CPACK_PACKAGE_VENDOR "Your Company")
# set(CPACK_PACKAGE_CONTACT "contact@example.com")

# # تنظیمات اضافی (اختیاری)
# set(CPACK_DEBIAN_PACKAGE_DEPENDS "libqt6core5a, libqt6gui6, libqt6quick6")
# set(CPACK_RPM_PACKAGE_REQUIRES "libqt6core5a, libqt6gui6, libqt6quick6")
