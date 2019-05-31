cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
include(gsl)

set(project_name "sort_test")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${CNNSDK_INSTALL_DIR})
find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(gsl_test 1.0 REQUIRED)
find_package(ieee-utils 1.0 REQUIRED)
find_package(err 1.0 REQUIRED)
find_package(sort 1.0 REQUIRED)
find_package(block 1.0 REQUIRED)
find_package(vector 1.0 REQUIRED)
find_package(permutation 1.0 REQUIRED)

file(GLOB GSL_SRC_FILES "../test.c")
add_executable(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} gsl_test::gsl_test)
target_link_libraries(${project_name} ieee-utils::ieee-utils)
target_link_libraries(${project_name} err::err)
target_link_libraries(${project_name} sort::sort)
target_link_libraries(${project_name} block::block)
target_link_libraries(${project_name} vector::vector)
target_link_libraries(${project_name} permutation::permutation)

target_include_directories(${project_name}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(CODE "message(\"Nothing to do\")")
