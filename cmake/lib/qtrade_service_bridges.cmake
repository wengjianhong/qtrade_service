# ---------------------------------------------------------------------------
# qtrade_service_bridges: I*Bridge gRPC implementations + optional plugin .so
# ---------------------------------------------------------------------------

file(GLOB_RECURSE QTRADE_SERVICE_BRIDGE_SRC CONFIGURE_DEPENDS
  ${QTRADE_SERVICE_SRC_QTRADE_DIR}/bridge/*.cpp)

# Static library used by in-process engine main (exclude plugin export TU to avoid
# duplicate symbols if both static and MODULE are linked into one binary).
set(QTRADE_SERVICE_BRIDGE_STATIC_SRC ${QTRADE_SERVICE_BRIDGE_SRC})
list(FILTER QTRADE_SERVICE_BRIDGE_STATIC_SRC EXCLUDE REGEX "grpc_bridge_plugin\\.cpp$")

add_library(qtrade_service_bridges STATIC ${QTRADE_SERVICE_BRIDGE_STATIC_SRC})

target_include_directories(qtrade_service_bridges PUBLIC
  $<BUILD_INTERFACE:${QTRADE_SERVICE_INCLUDE_OVERLAY_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(qtrade_service_bridges PUBLIC
  qtrade_service_client
)

# dlopen-able MODULE exporting bridge_plugin_abi symbols (plugin name: grpc)
add_library(qtrade_bridge_grpc MODULE
  ${QTRADE_SERVICE_SRC_QTRADE_DIR}/bridge/grpc_bridge_plugin.cpp
)
target_include_directories(qtrade_bridge_grpc PRIVATE
  ${QTRADE_SERVICE_INCLUDE_OVERLAY_DIR}
)
target_link_libraries(qtrade_bridge_grpc PRIVATE
  qtrade_service_bridges
)
set_target_properties(qtrade_bridge_grpc PROPERTIES
  OUTPUT_NAME "qtrade_bridge_grpc"
  PREFIX "lib"
  LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib/bridges
)
