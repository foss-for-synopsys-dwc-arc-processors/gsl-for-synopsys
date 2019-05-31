cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "rng")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(err 1.0 REQUIRED)
find_package(sys 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 schrage.c borosh13.c cmrg.c coveyou.c default.c file.c fishman18.c fishman20.c fishman2x.c gfsr4.c knuthran2.c knuthran.c knuthran2002.c lecuyer21.c minstd.c mrg.c mt.c r250.c ran0.c ran1.c ran2.c ran3.c rand48.c rand.c random.c randu.c ranf.c ranlux.c ranlxd.c ranlxs.c ranmar.c rng.c slatec.c taus.c taus113.c transputer.c tt.c types.c uni32.c uni.c vax.c waterman14.c zuf.c inline.c 
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
