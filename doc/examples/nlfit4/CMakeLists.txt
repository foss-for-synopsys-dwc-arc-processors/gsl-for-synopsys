cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
include(gsl)

set(project_name "nlfit4_example")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${CNNSDK_INSTALL_DIR})
find_package(sys 1.0 REQUIRED)
find_package(vector 1.0 REQUIRED)
find_package(matrix 1.0 REQUIRED)
find_package(blas 1.0 REQUIRED)
find_package(multilarge_nlinear 1.0 REQUIRED)
find_package(spblas 1.0 REQUIRED)
find_package(spmatrix 1.0 REQUIRED)

add_executable(${project_name} ../nlfit4.c)

target_link_libraries(${project_name} sys::sys)
target_link_libraries(${project_name} vector::vector)
target_link_libraries(${project_name} matrix::matrix)
target_link_libraries(${project_name} blas::blas)
target_link_libraries(${project_name} multilarge_nlinear::multilarge_nlinear)
target_link_libraries(${project_name} spblas::spblas)
target_link_libraries(${project_name} spmatrix::spmatrix)

target_include_directories(${project_name}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>
)

install(CODE "message(\"Nothing to do\")")
