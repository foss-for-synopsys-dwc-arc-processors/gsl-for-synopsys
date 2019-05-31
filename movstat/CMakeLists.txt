cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "movstat")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(statistics 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
  alloc.c apply.c fill.c funcacc.c madacc.c medacc.c mmacc.c movmad.c movmean.c movmedian.c movminmax.c movsum.c movSn.c movQn.c movqqr.c movvariance.c mvacc.c qnacc.c qqracc.c snacc.c sumacc.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} statistics::statistics)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
