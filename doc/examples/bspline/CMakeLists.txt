cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
include(gsl)

set(project_name "bspline_example")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${CNNSDK_INSTALL_DIR})
find_package(sys 1.0 REQUIRED)
find_package(bspline 1.0 REQUIRED)
find_package(multifit 1.0 REQUIRED)
find_package(rng 1.0 REQUIRED)
find_package(randist 1.0 REQUIRED)
find_package(statistics 1.0 REQUIRED)

add_executable(${project_name} ../bspline.c)

target_link_libraries(${project_name} sys::sys)
target_link_libraries(${project_name} bspline::bspline)
target_link_libraries(${project_name} multifit::multifit)
target_link_libraries(${project_name} rng::rng)
target_link_libraries(${project_name} randist::randist)
target_link_libraries(${project_name} statistics::statistics)

target_include_directories(${project_name}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>
)

install(CODE "message(\"Nothing to do\")")
