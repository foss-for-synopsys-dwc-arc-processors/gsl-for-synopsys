cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "multimin")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(sys 1.0 REQUIRED)
find_package(blas 1.0 REQUIRED)
find_package(poly 1.0 REQUIRED)
find_package(matrix 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
  linear_minimize.c fdfminimizer.c steepest_descent.c conjugate_fr.c conjugate_pr.c convergence.c diff.c vector_bfgs.c vector_bfgs2.c fminimizer.c simplex.c simplex2.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} sys::sys)
target_link_libraries(${project_name} blas::blas)
target_link_libraries(${project_name} poly::poly)
target_link_libraries(${project_name} matrix::matrix)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
