cmake_minimum_required(VERSION 3.3 FATAL_ERROR)
cmake_policy(SET CMP0057 NEW)

# If we ocationally include gsl.cmake 2 times it invokes
# to avoid it __CURRENT_GSL_FILE_VAR__ is set and check
if(__CURRENT_GSL_FILE_VAR__)
    return()
endif()
set(__CURRENT_GSL_FILE_VAR__ TRUE)


set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)
set(CMAKE_DISABLE_SOURCE_CHANGES  ON)

IF (NOT DEFINED ENV{EVSS_RT_HOME})
    message( FATAL_ERROR "EVSS_RT_HOME variable not found. Set it to <your EV installation>/software directory" )
ENDIF()

IF (NOT DEFINED ENV{EV_GSL_HOME})
    message( FATAL_ERROR "EV_GSL_HOME variable not found. Set it to gsl directory" )
ENDIF()

IF (NOT DEFINED ${EV_GSL_INSTALL_PREFIX})
    set(EV_GSL_INSTALL_PREFIX $ENV{EV_GSL_HOME}/install)
ENDIF()

set(GSL_INSTALL_PREFIX ${EV_GSL_INSTALL_PREFIX})
set(GSL_INSTALL_DIR  ${EV_GSL_INSTALL_PREFIX}/${EVSS_CFG_NAME})
set(TOP_INSTALL_INCLUDE ${EV_GSL_HOME}/install/include)
set(TOP_INSTALL_LIB     ${EV_GSL_HOME}/install/lib)
set(TOP_INSTALL_BIN     ${EV_GSL_HOME}/install/bin)

# set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_PREFIX}/${EVSS_CFG_NAME} CACHE PATH "Install prefix" FORCE)
set(CMAKE_PREFIX_PATH    ${GSL_INSTALL_PREFIX}/${EVSS_CFG_NAME}/lib/cmake ${EVSS_INSTALL_PREFIX}/${EVSS_CFG_NAME}/lib/cmake ${TOP_INSTALL_LIB}/cmake CACHE PATH "Cmake prefix" FORCE)

# This is required to ensure find_package is only redefined once, which is
# at "top" level CMakeLists.txt (directory from which cmake is called)
#
# Otherwise you get into a recursive endless loop, causing cmake to segfault
#
if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

# Redefine find_package so that it will only really try to find a package if
# it is not already in the list ${as_subproject}
macro (find_package pkgname)
    if(NOT "${pkgname}" IN_LIST as_subproject)
        _find_package(${pkgname} CONFIG ${ARGN})
    endif()
endmacro()
endif()

macro (export_library)
    install (TARGETS ${project_name}
        EXPORT ${project_name}Targets
        DESTINATION lib
    )

# Activate inline method to improve performance
    if( NOT EXPORT_LIBRARY_TOP STREQUAL ON)
        target_compile_definitions(${project_name} PUBLIC HAVE_INLINE)
    endif()

    add_library(${project_name}::${project_name} ALIAS ${project_name})

# it would be nice if we could automate adding projects to the "as_subproject" list
# by including it in this macro. Unfortunately, the order of execution is not guaranteed
# and therefore, the subprojects need to be defined before anyone tries find_package()
    #list(APPEND as_subproject ${project_name})

    install (EXPORT ${project_name}Targets
        FILE
            ${project_name}Targets.cmake
        NAMESPACE
            ${project_name}::
        DESTINATION
            lib/cmake/${project_name}
    )

    include(CMakePackageConfigHelpers)

    write_basic_package_version_file(
        ${CMAKE_CURRENT_BINARY_DIR}/${project_name}ConfigVersion.cmake
        VERSION ${project_version}
        COMPATIBILITY AnyNewerVersion
    )

    install(FILES
        ${CMAKE_CURRENT_LIST_DIR}/cmake/${project_name}Config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${project_name}ConfigVersion.cmake
        DESTINATION
            lib/cmake/${project_name}
    )
endmacro()

macro (export_library_top)
    set(CMAKE_INSTALL_PREFIX ${GSL_INSTALL_PREFIX})
# Golovkin dirty-hack to avoid checking 32/64-bit-ness 
# which could be different in ev_native/EV6x
    set(CMAKE_SIZEOF_VOID_P "")
    set(EXPORT_LIBRARY_TOP "ON")
    export_library()
endmacro()



function (checkOpenCV target_name)
if ( DEFINED EVSS_PROFILE_SMALL)
    message(WARNING "================================")
    message(WARNING "NOT SUPPORTED FOR EVSS_PROFILE=small ")
    message(WARNING "================================")
    set_property(GLOBAL PROPERTY EXCLUDE_FROM_ALL True)
    set_target_properties(${project_name} PROPERTIES EXCLUDE_FROM_ALL True)
    add_custom_target(run
        COMMAND echo "NOT SUPPORTED")
endif()
endfunction()

function (checkVDSP target_name)
if ( NOT EVSS_VDSP EQUAL 1)
    message(WARNING "================================")
    message(WARNING "NOT SUPPORTED WITHOUT VDSP")
    message(WARNING "================================")
    set_property(GLOBAL PROPERTY EXCLUDE_FROM_ALL True)
    set_target_properties(${project_name} PROPERTIES EXCLUDE_FROM_ALL True)
    add_custom_target(run
        COMMAND echo "NOT SUPPORTED")
endif()
endfunction()


# This function adds additional warnings to the compiler flags for the target
# The intention is to catch language-constructs that MSVC does not support on
# Linux. For example:
#   - void pointer arithmetic
#   - variable length arrays  We can use: -Werror=vla
#   - zero length arrays
function (target_extra_warnings target_name)
target_compile_options(${target_name}
    PRIVATE
        $<$<C_COMPILER_ID:Clang>:
            -Werror=pointer-arith
            -Werror=zero-length-array>
)
endfunction()

set(CMAKE_CXX_STANDARD 11)
set(EV_GSL_APP_INCLUDES include)

#==============================================================================
#  Doxygen support
#==============================================================================

# option(BUILD_DOC "Build documentation" OFF)

if (BUILD_DOC)
    # check if Doxygen is installed
    find_package(Doxygen)
    if (DOXYGEN_FOUND)
        # set input and output files
        set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in)
        set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

        # request to configure the file
        configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
        message("Doxygen build started")

        # note the option ALL which allows to build the docs together with the application
        add_custom_target( doc_doxygen ALL
            COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            COMMENT "Generating API documentation with Doxygen"
            VERBATIM )
    else (DOXYGEN_FOUND)
      message("Doxygen need to be installed to generate the doxygen documentation")
    endif (DOXYGEN_FOUND)
# else (BUILD_DOC)
#    message("BUILD_DOC is not enabled....")
endif (BUILD_DOC)

#==============================================================================
# This decl is to avoid cmake warnings about variables that are not
# always used.
#==============================================================================
set(EV_GSL_NAG_VARS "${EV_CNN_MODEL_EXAMPLE_DIR} ${USE_OPENCV} ${EV_CNN_NO_OPENCV} ${EV_CNN_INSTALL_DIR} ${CNN_LIB_DIR_CFG} ${EVSS_HOME} ${HAVE_SPP} ${CNN_VER} ${EVSS_PROFILE_SMALL}")
set(EV_GSL_NAG_VARS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG} ${EV_GSL_NAG_VARS}")
set(EV_GSL_NAG_VARS "${CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE} ${EV_GSL_NAG_VARS}")

