# ---------------------------------------------------------------------------
# Install rules for find_package(qtrade_service CONFIG)
#
# 对外交付：微服务二进制 + proto 库（及服务侧头）。
# gRPC 薄客户端 / Grpc*Bridge 已迁至 qtrade_client 本仓编译，不再 install。
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
  EXPORT qtrade_serviceTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/qtrade/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/qtrade
)

# 服务侧 / 下游编译仍可能需要的 common 头（不含已迁走的 strategy_config_utils）
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
