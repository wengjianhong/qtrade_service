# ---------------------------------------------------------------------------
# qtrade_service_client: gRPC thin clients
# ---------------------------------------------------------------------------

file(GLOB_RECURSE QTRADE_SERVICE_CLIENT_SRC CONFIGURE_DEPENDS
  ${QTRADE_SERVICE_SRC_QTRADE_DIR}/client/*.cpp)

add_library(qtrade_service_client STATIC ${QTRADE_SERVICE_CLIENT_SRC})

target_include_directories(qtrade_service_client PUBLIC
  $<BUILD_INTERFACE:${QTRADE_SERVICE_SRC_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(qtrade_service_client PUBLIC
  qtrade_service_common
  qtrade_service_proto
)
