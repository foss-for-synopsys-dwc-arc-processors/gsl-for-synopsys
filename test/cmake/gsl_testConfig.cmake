include(CMakeFindDependencyMacro)
find_dependency(ev_gsl_includes 1.0)
find_dependency(sys 1.0)
find_dependency(evthreads 1.0)
include("${CMAKE_CURRENT_LIST_DIR}/gsl_testTargets.cmake")
