# Minimal service-side tests (optional; only when building qtrade_service standalone)
find_package(GTest 1.14.0 REQUIRED)

file(GLOB_RECURSE ALL_TEST_FILES CONFIGURE_DEPENDS "test_*.cpp")
if(NOT ALL_TEST_FILES)
  return()
endif()

add_executable(qtrade_service_tests ${ALL_TEST_FILES})
target_include_directories(qtrade_service_tests PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_link_libraries(qtrade_service_tests PRIVATE
  qtrade_account_risk_service_static
  GTest::gtest
  GTest::gtest_main
)

include(GoogleTest)
gtest_discover_tests(qtrade_service_tests)
