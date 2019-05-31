cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "multifit")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(matrix 1.0 REQUIRED)
find_package(min 1.0 REQUIRED)
find_package(linalg 1.0 REQUIRED)
find_package(sort 1.0 REQUIRED)
find_package(statistics 1.0 REQUIRED)
find_package(blas 1.0 REQUIRED)
find_package(cblas 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 linear_common.c gcv.c multilinear.c multiwlinear.c work.c lmniel.c lmder.c fsolver.c fdfsolver.c fdfridge.c fdjac.c convergence.c gradient.c covar.c multirobust.c robust_wfun.c multireg.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} matrix::matrix)
target_link_libraries(${project_name} min::min)
target_link_libraries(${project_name} linalg::linalg)
target_link_libraries(${project_name} sort::sort)
target_link_libraries(${project_name} statistics::statistics)
target_link_libraries(${project_name} blas::blas)
target_link_libraries(${project_name} cblas::cblas)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
