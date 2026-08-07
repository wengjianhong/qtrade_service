# ---------------------------------------------------------------------------
# Support microservice executables
# ---------------------------------------------------------------------------

function(qtrade_service_add_support_service executable_name service_impl_dir)
  set(static_target "${executable_name}_static")

  file(GLOB_RECURSE _svc_src CONFIGURE_DEPENDS
    "${QTRADE_SERVICE_SRC_QTRADE_DIR}/service/${service_impl_dir}/*.cpp")
  if(NOT _svc_src)
    message(FATAL_ERROR "No .cpp under service/${service_impl_dir}/")
  endif()

  add_library(${static_target} STATIC ${_svc_src})
  target_include_directories(${static_target}
    PUBLIC ${QTRADE_SERVICE_INCLUDE_OVERLAY_DIR}
    PRIVATE ${QTRADE_SERVICE_INCLUDE_DIR}
  )
  target_link_libraries(${static_target} PUBLIC qtrade_service_common)

  add_executable(${executable_name} "${QTRADE_SERVICE_APPS_DIR}/${executable_name}/main.cpp")
  target_link_libraries(${executable_name} PRIVATE ${static_target})
endfunction()

qtrade_service_add_support_service(qtrade_config_service config_service)
qtrade_service_add_support_service(qtrade_account_service account_service)
qtrade_service_add_support_service(qtrade_account_risk_service account_risk_service)

set(QTRADE_SERVICE_TARGETS
  qtrade_config_service
  qtrade_account_service
  qtrade_account_risk_service
  CACHE INTERNAL "qtrade service executables"
)
