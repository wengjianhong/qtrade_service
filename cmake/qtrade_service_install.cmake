# ---------------------------------------------------------------------------
# Install rules for find_package(qtrade_service CONFIG)
# ---------------------------------------------------------------------------

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/qtrade_service-config-version.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

install(TARGETS
  qtrade_service_proto
  qtrade_service_common
  qtrade_service_client
  qtrade_service_bridges
  EXPORT qtrade_serviceTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(TARGETS qtrade_bridge_grpc
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/bridges
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/qtrade/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade
)

# Bridge / client / 下游编译所需的 service 侧头文件（不覆盖 qtrade 的 common/boot 等）
install(DIRECTORY ${QTRADE_SERVICE_SRC_QTRADE_DIR}/bridge/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade/bridge
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)
install(DIRECTORY ${QTRADE_SERVICE_SRC_QTRADE_DIR}/client/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade/client
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)
install(DIRECTORY ${QTRADE_SERVICE_SRC_QTRADE_DIR}/common/proto/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade/common/proto
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)
install(DIRECTORY ${QTRADE_SERVICE_SRC_QTRADE_DIR}/common/converter/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade/common/converter
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)
install(DIRECTORY ${QTRADE_SERVICE_SRC_QTRADE_DIR}/common/config/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade/common/config
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)
install(DIRECTORY ${QTRADE_SERVICE_SRC_QTRADE_DIR}/common/boot/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade/common/boot
  FILES_MATCHING PATTERN "*.hpp" PATTERN "*.h"
)

if(QTRADE_SERVICE_PROTO_FILES)
  install(DIRECTORY ${QTRADE_SERVICE_PROTO_PUBLIC_INCLUDE_DIR}/qtrade/proto/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade/proto
  )
endif()

install(TARGETS ${QTRADE_SERVICE_TARGETS}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/config/
  DESTINATION config
  FILES_MATCHING PATTERN "*.json"
)

install(EXPORT qtrade_serviceTargets
  FILE qtrade_serviceTargets.cmake
  NAMESPACE qtrade_service::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/qtrade_service
)

configure_file(
  ${CMAKE_CURRENT_LIST_DIR}/qtrade_service-config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/qtrade_service-config.cmake
  @ONLY
)

install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/qtrade_service-config.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/qtrade_service-config-version.cmake
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/qtrade_service
)
