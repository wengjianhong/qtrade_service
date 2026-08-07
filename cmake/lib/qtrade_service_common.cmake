# ---------------------------------------------------------------------------
# qtrade_service_common: framework + dao + service-side common
#
# 仅本仓微服务私有静态库：不 install、不 export。
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
  $<BUILD_INTERFACE:${QTRADE_SERVICE_INCLUDE_OVERLAY_DIR}>
)

target_link_libraries(qtrade_service_common PUBLIC
  qtrade_engine::qtrade_engine
  Threads::Threads
  spdlog::spdlog
  qtrade_service_proto
  nlohmann_json::nlohmann_json
  cpputils::cpputils
)
