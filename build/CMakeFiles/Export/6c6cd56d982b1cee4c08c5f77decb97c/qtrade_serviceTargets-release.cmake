#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "qtrade_service::qtrade_service_proto" for configuration "Release"
set_property(TARGET qtrade_service::qtrade_service_proto APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(qtrade_service::qtrade_service_proto PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libqtrade_service_proto.a"
  )

list(APPEND _cmake_import_check_targets qtrade_service::qtrade_service_proto )
list(APPEND _cmake_import_check_files_for_qtrade_service::qtrade_service_proto "${_IMPORT_PREFIX}/lib/libqtrade_service_proto.a" )

# Import target "qtrade_service::qtrade_service_common" for configuration "Release"
set_property(TARGET qtrade_service::qtrade_service_common APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(qtrade_service::qtrade_service_common PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libqtrade_service_common.a"
  )

list(APPEND _cmake_import_check_targets qtrade_service::qtrade_service_common )
list(APPEND _cmake_import_check_files_for_qtrade_service::qtrade_service_common "${_IMPORT_PREFIX}/lib/libqtrade_service_common.a" )

# Import target "qtrade_service::qtrade_service_client" for configuration "Release"
set_property(TARGET qtrade_service::qtrade_service_client APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(qtrade_service::qtrade_service_client PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libqtrade_service_client.a"
  )

list(APPEND _cmake_import_check_targets qtrade_service::qtrade_service_client )
list(APPEND _cmake_import_check_files_for_qtrade_service::qtrade_service_client "${_IMPORT_PREFIX}/lib/libqtrade_service_client.a" )

# Import target "qtrade_service::qtrade_service_bridges" for configuration "Release"
set_property(TARGET qtrade_service::qtrade_service_bridges APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(qtrade_service::qtrade_service_bridges PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libqtrade_service_bridges.a"
  )

list(APPEND _cmake_import_check_targets qtrade_service::qtrade_service_bridges )
list(APPEND _cmake_import_check_files_for_qtrade_service::qtrade_service_bridges "${_IMPORT_PREFIX}/lib/libqtrade_service_bridges.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
