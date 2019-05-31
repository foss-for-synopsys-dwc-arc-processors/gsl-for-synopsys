cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "integration")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(err 1.0 REQUIRED)
find_package(sys 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
  err.c cquad_const.c qk15.c qk21.c qk31.c qk41.c qk51.c qk61.c qk.c qng.c qag.c qags.c qagp.c workspace.c qcheb.c qawc.c qmomo.c qaws.c qmomof.c qawo.c qawf.c glfixed.c cquad.c fixed.c chebyshev.c chebyshev2.c legendre.c hermite.c laguerre.c gegenbauer.c jacobi.c exponential.c rational.c romberg.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} err::err)
target_link_libraries(${project_name} sys::sys)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
