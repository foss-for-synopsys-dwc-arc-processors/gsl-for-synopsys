cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "cblas")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 hypot.c sasum.c saxpy.c scasum.c scnrm2.c scopy.c sdot.c sdsdot.c sgbmv.c sgemm.c sgemv.c sger.c snrm2.c srot.c srotg.c srotm.c srotmg.c ssbmv.c sscal.c sspmv.c sspr.c sspr2.c sswap.c ssymm.c ssymv.c ssyr.c ssyr2.c ssyr2k.c ssyrk.c stbmv.c stbsv.c stpmv.c stpsv.c strmm.c strmv.c strsm.c strsv.c dasum.c daxpy.c dcopy.c ddot.c dgbmv.c dgemm.c dgemv.c dger.c dnrm2.c drot.c drotg.c drotm.c drotmg.c dsbmv.c dscal.c dsdot.c dspmv.c dspr.c dspr2.c dswap.c dsymm.c dsymv.c dsyr.c dsyr2.c dsyr2k.c dsyrk.c dtbmv.c dtbsv.c dtpmv.c dtpsv.c dtrmm.c dtrmv.c dtrsm.c dtrsv.c dzasum.c dznrm2.c caxpy.c ccopy.c cdotc_sub.c cdotu_sub.c cgbmv.c cgemm.c cgemv.c cgerc.c cgeru.c chbmv.c chemm.c chemv.c cher.c cher2.c cher2k.c cherk.c chpmv.c chpr.c chpr2.c cscal.c csscal.c cswap.c csymm.c csyr2k.c csyrk.c ctbmv.c ctbsv.c ctpmv.c ctpsv.c ctrmm.c ctrmv.c ctrsm.c ctrsv.c zaxpy.c zcopy.c zdotc_sub.c zdotu_sub.c zdscal.c zgbmv.c zgemm.c zgemv.c zgerc.c zgeru.c zhbmv.c zhemm.c zhemv.c zher.c zher2.c zher2k.c zherk.c zhpmv.c zhpr.c zhpr2.c zscal.c zswap.c zsymm.c zsyr2k.c zsyrk.c ztbmv.c ztbsv.c ztpmv.c ztpsv.c ztrmm.c ztrmv.c ztrsm.c ztrsv.c icamax.c idamax.c isamax.c izamax.c xerbla.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
