cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "cdf")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(randist 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 beta.c betainv.c cauchy.c cauchyinv.c chisq.c chisqinv.c exponential.c exponentialinv.c exppow.c fdist.c fdistinv.c flat.c flatinv.c gamma.c gammainv.c gauss.c gaussinv.c gumbel1.c gumbel1inv.c gumbel2.c gumbel2inv.c laplace.c laplaceinv.c logistic.c logisticinv.c lognormal.c lognormalinv.c pareto.c paretoinv.c rayleigh.c rayleighinv.c tdist.c tdistinv.c weibull.c weibullinv.c binomial.c poisson.c geometric.c nbinomial.c pascal.c hypergeometric.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} randist::randist)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
