include(CMakeFindDependencyMacro)
find_dependency(ev_gsl_includes 1.0)
find_dependency(movstat 1.0 REQUIRED)
find_dependency(vector 1.0 REQUIRED)
find_dependency(poly 1.0 REQUIRED)

include("${CMAKE_CURRENT_LIST_DIR}/filterTargets.cmake")
