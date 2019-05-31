include(CMakeFindDependencyMacro)
find_dependency(ev_gsl_includes 1.0)
find_dependency(randist 1.0)
include("${CMAKE_CURRENT_LIST_DIR}/cdfTargets.cmake")
