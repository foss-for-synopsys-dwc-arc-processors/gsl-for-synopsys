cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "linalg")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(sys 1.0 REQUIRED)
find_package(blas 1.0 REQUIRED)
find_package(permutation 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 cod.c condest.c invtri.c multiply.c exponential.c tridiag.c lu.c luc.c hh.c qr.c qrpt.c lq.c ptlq.c svd.c householder.c householdercomplex.c hessenberg.c hesstri.c cholesky.c choleskyc.c mcholesky.c pcholesky.c symmtd.c hermtd.c bidiag.c balance.c balancemat.c inline.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} sys::sys)
target_link_libraries(${project_name} blas::blas)
target_link_libraries(${project_name} permutation::permutation)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
