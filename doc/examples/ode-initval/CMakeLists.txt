cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
include(gsl)

set(project_name "ode-initval_example")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${CNNSDK_INSTALL_DIR})
find_package(sys 1.0 REQUIRED)
find_package(err 1.0 REQUIRED)
find_package(matrix 1.0 REQUIRED)
find_package(ode-initval2 1.0 REQUIRED)

add_executable(${project_name} ../ode-initval.c)

target_link_libraries(${project_name} sys::sys)
target_link_libraries(${project_name} err::err)
target_link_libraries(${project_name} matrix::matrix)
target_link_libraries(${project_name} ode-initval2::ode-initval2)

target_include_directories(${project_name}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>
)

install(CODE "message(\"Nothing to do\")")
