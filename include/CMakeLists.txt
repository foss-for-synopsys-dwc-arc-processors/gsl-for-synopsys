cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
include(gsl)

set(project_name "ev_gsl_includes")
set(project_version "1.0")

project("${project_name}")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

file(GLOB GSL_TOP_HDR           "$ENV{EV_GSL_HOME}/*.h")
file(GLOB GSL_ALL_MODULES_HDR  LIST_DIRECTORIES true "$ENV{EV_GSL_HOME}/*/*.h" )

set(TOP_INCLUDE ${EV_GSL_HOME}/install/include/gsl)

install (FILES ${GSL_TOP_HDR}            DESTINATION ${TOP_INCLUDE})
install (FILES ${GSL_ALL_MODULES_HDR}    DESTINATION ${TOP_INCLUDE})

add_library(${project_name} INTERFACE)

target_include_directories(${project_name}
    INTERFACE
        $<INSTALL_INTERFACE:include>
        $<INSTALL_INTERFACE:include/gsl>
       
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/gsl>
)
export_library_top()
