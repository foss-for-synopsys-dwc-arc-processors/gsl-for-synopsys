cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
include(gsl)

set(project_name "roots_example")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${CNNSDK_INSTALL_DIR})
find_package(sys 1.0 REQUIRED)
find_package(err 1.0 REQUIRED)
find_package(roots 1.0 REQUIRED)

add_executable(${project_name} ../roots.c)

target_link_libraries(${project_name} sys::sys)
target_link_libraries(${project_name} err::err)
target_link_libraries(${project_name} roots::roots)

target_include_directories(${project_name}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>
)

install(CODE "message(\"Nothing to do\")")
