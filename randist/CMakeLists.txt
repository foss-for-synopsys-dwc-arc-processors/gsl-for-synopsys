cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "randist")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(specfunc 1.0 REQUIRED)
find_package(statistics 1.0 REQUIRED)
find_package(rng 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 bernoulli.c beta.c bigauss.c binomial.c cauchy.c chisq.c dirichlet.c discrete.c erlang.c exponential.c exppow.c fdist.c flat.c gamma.c gauss.c gausszig.c gausstail.c geometric.c gumbel.c hyperg.c laplace.c levy.c logarithmic.c logistic.c lognormal.c multinomial.c mvgauss.c nbinomial.c pareto.c pascal.c poisson.c rayleigh.c shuffle.c sphere.c tdist.c weibull.c landau.c binomial_tpe.c wishart.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} specfunc::specfunc)
target_link_libraries(${project_name} statistics::statistics)
target_link_libraries(${project_name} rng::rng)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
