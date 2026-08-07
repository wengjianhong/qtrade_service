# ---------------------------------------------------------------------------
# Entry point for find_package(qtrade_service CONFIG)
# ---------------------------------------------------------------------------

include(CMakeFindDependencyMacro)

find_dependency(Threads)
find_dependency(spdlog 1.16.0)
find_dependency(nlohmann_json 3.11.0)
find_dependency(cpputils 0.1.0)
find_dependency(qtrade_engine)

include("${CMAKE_CURRENT_LIST_DIR}/qtrade_serviceTargets.cmake")
