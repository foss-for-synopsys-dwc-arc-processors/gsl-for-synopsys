cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "fft")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(err 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 factorize.c urand.c dft.c fft.c signals.c 
)

#c_main.c c_init.c c_pass_2.c c_pass_3.c c_pass_4.c c_pass_5.c c_pass_6.c c_pass_7.c c_pass_n.c c_radix2.c bitreverse.c factorize.c hc_init.c hc_pass_2.c hc_pass_3.c hc_pass_4.c hc_pass_5.c hc_pass_n.c hc_radix2.c hc_unpack.c real_init.c real_pass_2.c real_pass_3.c real_pass_4.c real_pass_5.c real_pass_n.c real_radix2.c real_unpack.c hc_main.c real_main.c urand.c dft.c fft.c signals.c


add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} err::err)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
