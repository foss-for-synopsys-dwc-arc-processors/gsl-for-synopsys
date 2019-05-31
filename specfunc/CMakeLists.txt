cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

include(gsl)
set(project_name "specfunc")
project("${project_name}")
set(project_version "1.0")

set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_DIR})

find_package(ev_gsl_includes 1.0 REQUIRED)
find_package(sys 1.0 REQUIRED)
find_package(poly 1.0 REQUIRED)
find_package(eigen 1.0 REQUIRED)

file(GLOB GSL_HDR_FILES "*.h")

set(GSL_SRC_FILES 
 airy.c airy_der.c airy_zero.c atanint.c bessel.c bessel_I0.c bessel_I1.c bessel_In.c bessel_Inu.c bessel_J0.c bessel_J1.c bessel_Jn.c bessel_Jnu.c bessel_K0.c bessel_K1.c bessel_Kn.c bessel_Knu.c bessel_Y0.c bessel_Y1.c bessel_Yn.c bessel_Ynu.c bessel_amp_phase.c bessel_i.c bessel_j.c bessel_k.c bessel_olver.c bessel_temme.c bessel_y.c bessel_zero.c bessel_sequence.c beta.c beta_inc.c clausen.c coulomb.c coupling.c coulomb_bound.c dawson.c debye.c dilog.c elementary.c ellint.c elljac.c erfc.c exp.c expint.c expint3.c fermi_dirac.c gamma_inc.c gegenbauer.c gamma.c hermite.c hyperg_0F1.c hyperg_2F0.c hyperg_1F1.c hyperg_2F1.c hyperg_U.c hyperg.c laguerre.c lambert.c legendre_H3d.c legendre_P.c legendre_Qn.c legendre_con.c legendre_poly.c log.c mathieu_angfunc.c mathieu_charv.c mathieu_coeff.c mathieu_radfunc.c mathieu_workspace.c poch.c pow_int.c psi.c result.c shint.c sincos_pi.c sinint.c synchrotron.c transport.c trig.c zeta.c 
)

add_library(${project_name} ${GSL_SRC_FILES})

target_link_libraries(${project_name} ev_gsl_includes::ev_gsl_includes)
target_link_libraries(${project_name} sys::sys)
target_link_libraries(${project_name} poly::poly)
target_link_libraries(${project_name} eigen::eigen)

target_extra_warnings(${project_name})
target_include_directories(${project_name}
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

install(TARGETS ${project_name}       DESTINATION lib)
install(FILES   ${GSL_HDR_FILES}      DESTINATION include/gsl)
 
export_library()
