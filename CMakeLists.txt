cmake_minimum_required(VERSION 3.22)
project(qtrade_service VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

include(GNUInstallDirs)

# When built as the top-level project (not add_subdirectory)
if(CMAKE_SOURCE_DIR STREQUAL PROJECT_SOURCE_DIR)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
  set(QTRADE_SERVICE_STANDALONE TRUE)
else()
  message(FATAL_ERROR "qtrade_service must be configured as a top-level project; qtrade_engine must not add_subdirectory it")
endif()

# Service binaries need RUNPATH to find libqtrade_engine.so / libqtrade_service_proto.so
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE)

add_compile_options(-fPIC -Wall -Wextra -Wpedantic -O2)

find_package(Threads REQUIRED)
find_package(spdlog 1.16.0 REQUIRED)
find_package(nlohmann_json 3.11.0 REQUIRED)
find_package(cpputils 0.1.0 REQUIRED CONFIG)
find_package(qtrade_common 0.1.0 REQUIRED CONFIG)

# qtrade_engine public headers + libraries (installed package only; no reverse dependency)
find_package(qtrade_engine REQUIRED CONFIG)
set(QTRADE_INCLUDE_FROM_ROOT FALSE)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/qtrade_service_paths.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/lib/qtrade_service_proto.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/lib/qtrade_service_common.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/app/qtrade_services.cmake)

if(QTRADE_SERVICE_STANDALONE)
  include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/qtrade_service_install.cmake)
  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test/CMakeLists.txt")
    enable_testing()
    add_subdirectory(test)
  endif()
endif()
