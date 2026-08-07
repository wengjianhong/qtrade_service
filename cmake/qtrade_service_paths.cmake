# ---------------------------------------------------------------------------
# qtrade_service project paths
#
# Physical layout: src/qtrade_service/
# Public #include path stays qtrade/ (see include overlay below).
# ---------------------------------------------------------------------------

set(QTRADE_SERVICE_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include)
set(QTRADE_SERVICE_SRC_DIR ${PROJECT_SOURCE_DIR}/src)
set(QTRADE_SERVICE_SRC_QTRADE_DIR ${QTRADE_SERVICE_SRC_DIR}/qtrade_service)
set(QTRADE_SERVICE_APPS_DIR ${QTRADE_SERVICE_SRC_QTRADE_DIR}/apps)
set(QTRADE_SERVICE_FRAMEWORK_DIR ${QTRADE_SERVICE_SRC_QTRADE_DIR}/framework)

# Map src/qtrade_service -> build/include_overlay/qtrade so #include <qtrade/...>
# keeps working while the physical directory matches the project name.
set(QTRADE_SERVICE_INCLUDE_OVERLAY_DIR ${CMAKE_BINARY_DIR}/include_overlay)
file(MAKE_DIRECTORY ${QTRADE_SERVICE_INCLUDE_OVERLAY_DIR})
set(_qtrade_service_overlay_link "${QTRADE_SERVICE_INCLUDE_OVERLAY_DIR}/qtrade")
if(EXISTS "${_qtrade_service_overlay_link}")
  file(REMOVE "${_qtrade_service_overlay_link}")
endif()
file(CREATE_LINK
  "${QTRADE_SERVICE_SRC_QTRADE_DIR}"
  "${_qtrade_service_overlay_link}"
  SYMBOLIC
)
unset(_qtrade_service_overlay_link)
