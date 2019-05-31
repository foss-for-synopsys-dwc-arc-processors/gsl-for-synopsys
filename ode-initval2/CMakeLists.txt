cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "ode-initval2")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(linalg 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 modnewton1.c control.c cstd.c cscal.c evolve.c step.c rk2.c rk2imp.c rk4.c rk4imp.c rkf45.c rk8pd.c rkck.c bsimp.c rk1imp.c msadams.c msbdf.c driver.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} linalg::linalg)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
