# ---------------------------------------------------------------------------
# qtrade_service_common: framework + dao + service-side common
# ---------------------------------------------------------------------------

file(GLOB_RECURSE QTRADE_SERVICE_FRAMEWORK_SRC CONFIGURE_DEPENDS
  ${QTRADE_SERVICE_FRAMEWORK_DIR}/*.cpp)
file(GLOB_RECURSE QTRADE_SERVICE_PRODUCT_COMMON_SRC CONFIGURE_DEPENDS
  ${QTRADE_SERVICE_SRC_QTRADE_DIR}/common/*/*.cpp)
file(GLOB_RECURSE QTRADE_SERVICE_DAO_SRC CONFIGURE_DEPENDS
  ${QTRADE_SERVICE_SRC_QTRADE_DIR}/dao/*.cpp)

add_library(qtrade_service_common STATIC
  ${QTRADE_SERVICE_FRAMEWORK_SRC}
  ${QTRADE_SERVICE_PRODUCT_COMMON_SRC}
  ${QTRADE_SERVICE_DAO_SRC}
)

target_include_directories(qtrade_service_common PUBLIC
  $<BUILD_INTERFACE:${QTRADE_SERVICE_INCLUDE_DIR}>
  $<BUILD_INTERFACE:${QTRADE_SERVICE_SRC_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(qtrade_service_common PUBLIC
  qtrade::qtrade_common
  Threads::Threads
  spdlog::spdlog
  qtrade_service_proto
  nlohmann_json::nlohmann_json
  cpputils::cpputils
)
