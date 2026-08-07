# ---------------------------------------------------------------------------
# qtrade_service_bridges: I*Bridge gRPC implementations (in-process injection)
# ---------------------------------------------------------------------------

file(GLOB_RECURSE QTRADE_SERVICE_BRIDGE_SRC CONFIGURE_DEPENDS
  ${QTRADE_SERVICE_SRC_QTRADE_DIR}/bridge/*.cpp)

add_library(qtrade_service_bridges STATIC ${QTRADE_SERVICE_BRIDGE_SRC})

target_include_directories(qtrade_service_bridges PUBLIC
  $<BUILD_INTERFACE:${QTRADE_SERVICE_INCLUDE_OVERLAY_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(qtrade_service_bridges PUBLIC
  qtrade_service_client
)
