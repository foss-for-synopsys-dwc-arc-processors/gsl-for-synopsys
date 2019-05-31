cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "sys")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})
find_package(evthreads 1.0 REQUIRED)

find_package(ev_gsl_includes 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 minmax.c prec.c hypot.c log1p.c expm1.c coerce.c invhyp.c pow_int.c infnan.c fdiv.c fcmp.c ldfrexp.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} evthreads::evthreads)

# Link math library for linux
if(DEFINED ARC)
message([DEBUG] ARC)
else()
find_library(MATH_LIB  m  ${PATH})
target_link_libraries(${project_name} ${MATH_LIB})
endif()

# Set extra define for our specific code. It should effect on both: ev_native and ARC configs
target_compile_definitions(${project_name} PUBLIC ${CNN_C_FLAGS} -DSYNOPSYS_ARC_HSEV=1)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<INSTALL_INTERFACE:${EV_GSL_INSTALL_PREFIX}/include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
