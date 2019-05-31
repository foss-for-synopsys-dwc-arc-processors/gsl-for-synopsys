ifndef EV_GSL_HOME
    $(error ERROR: EV_GSL_HOME is not defined, please set point it to your EV GSL installation directory)
endif

include config/env.mk

ifndef EVSS_CFG
    $(error ERROR: Please set EVSS_CFG from command line or environment variable before building)
endif

# Default parameters (do not change them here, use command line parameters instead)
EVSS_INSTALL_PREFIX ?= $(EVSS_RT_HOME)/install
EVSS_DBG ?= 0

# Add all libraries into build system
					
EVSS_SUBMODULES_LIB_LIST  = blas block bspline cblas cdf cheb combination complex const 
EVSS_SUBMODULES_LIB_LIST += deriv dht diff eigen err fft filter fit histogram ieee-utils  
EVSS_SUBMODULES_LIB_LIST += include integration interpolation linalg matrix min monte  
EVSS_SUBMODULES_LIB_LIST += movstat multifit multifit_nlinear multilarge multilarge_nlinear   
EVSS_SUBMODULES_LIB_LIST += multimin multiroots multiset ntuple ode-initval ode-initval2    
EVSS_SUBMODULES_LIB_LIST += permutation poly qrng randist rng roots rstat siman sort   
EVSS_SUBMODULES_LIB_LIST += spblas specfunc splinalg spmatrix  statistics sum sys test  
EVSS_SUBMODULES_LIB_LIST += utils vector wavelet

EVSS_SUBMODULES_FULL_LIST = $(EVSS_SUBMODULES_LIB_LIST)

# Add list of all libraries' tests into build system
EVSS_SUBMODULES_TEST_NAME  = block bspline cblas cdf cheb combination complex const 
EVSS_SUBMODULES_TEST_NAME += deriv dht diff eigen err fft filter fit histogram ieee-utils 
EVSS_SUBMODULES_TEST_NAME += integration interpolation linalg matrix min monte movstat   
EVSS_SUBMODULES_TEST_NAME += multifit multifit_nlinear multilarge multilarge_nlinear multimin   
EVSS_SUBMODULES_TEST_NAME += multiroots multiset ntuple ode-initval ode-initval2   
EVSS_SUBMODULES_TEST_NAME += permutation poly qrng randist rng roots rstat siman sort spblas   
EVSS_SUBMODULES_TEST_NAME += specfunc splinalg spmatrix  statistics sum sys vector wavelet

EVSS_SUBMODULES_TEST_LIST = $(addsuffix /test,$(EVSS_SUBMODULES_TEST_NAME))
EVSS_SUBMODULES_FULL_LIST += $(EVSS_SUBMODULES_TEST_LIST)

# Add list of all examples into build system

EVSS_SUBMODULES_EXAMPLE_NAME  = blas block cblas cdf cheb combination multiset const diff eigen 
EVSS_SUBMODULES_EXAMPLE_NAME += fft fftmr fftreal filt_edge fitting fitting2 fitting3 fitreg
EVSS_SUBMODULES_EXAMPLE_NAME += fitreg2 gaussfilt gaussfilt2 histogram histogram2d ieee ieeeround
EVSS_SUBMODULES_EXAMPLE_NAME += impulse integration integration2 interp interp2d intro linalglu 
EVSS_SUBMODULES_EXAMPLE_NAME += largefit matrix matrixw min monte movstat1 movstat2 movstat3 
EVSS_SUBMODULES_EXAMPLE_NAME += ntupler ntuplew ode-initval odefixed permseq permshuffle
EVSS_SUBMODULES_EXAMPLE_NAME += polyroots qrng randpoisson randwalk rng rngunif robfit rootnewt
EVSS_SUBMODULES_EXAMPLE_NAME += roots siman siman_tsp sortsmall specfun specfun_e rstat rquantile
EVSS_SUBMODULES_EXAMPLE_NAME += stat statsort sum vector vectorr vectorview vectorw dwt nlfit
EVSS_SUBMODULES_EXAMPLE_NAME += nlfit2 nlfit2b nlfit3 interpp eigen_nonsymm bspline multimin
EVSS_SUBMODULES_EXAMPLE_NAME += nmsimplex ode-initval-low-level poisson interp_compare spmatrix nlfit4


EVSS_SUBMODULES_EXAMPLE_LIST = $(addprefix doc/examples/,$(EVSS_SUBMODULES_EXAMPLE_NAME))
EVSS_SUBMODULES_FULL_LIST    += $(EVSS_SUBMODULES_EXAMPLE_LIST)


# Set of prerequisites for library tests
TEST_COMMON = include-install err-install ieee-utils-install test-install

# define to set library/test prerequisite target
# Example of of unrolling:
# from:
# $(call test_prerequisites, splinalg,           rng spmatrix   )
# to:
# splinalg/test-prerequisites:		    include-install err-install ieee-utils-install test-install splinalg-install rng-install rng-install spmatrix-install

define test_prerequisites
$(addsuffix /test-prerequisites,$(1)): $(TEST_COMMON)  $(addsuffix -install,$(2)) $(addsuffix -install,$(1)) 
endef

$(call test_prerequisites, block,                             )
$(call test_prerequisites, bspline,                           )
$(call test_prerequisites, cblas,                             )
$(call test_prerequisites, cdf,                               )
$(call test_prerequisites, cheb,                              )
$(call test_prerequisites, combination,                       )
$(call test_prerequisites, complex,                           )
$(call test_prerequisites, const,                             )
$(call test_prerequisites, deriv,                             )
$(call test_prerequisites, dht,                               )
$(call test_prerequisites, diff,                              )
$(call test_prerequisites, eigen,              rng sort       )
$(call test_prerequisites, err                                )
$(call test_prerequisites, fft,                               )
$(call test_prerequisites, filter,             randist        )
$(call test_prerequisites, fit,                               )
$(call test_prerequisites, histogram,                         )
$(call test_prerequisites, ieee-utils,                        )
$(call test_prerequisites, integration,        specfunc       )
$(call test_prerequisites, interpolation,                     )
$(call test_prerequisites, linalg,             rng            )
$(call test_prerequisites, matrix,                            )
$(call test_prerequisites, min,                               )
$(call test_prerequisites, monte,                             )
$(call test_prerequisites, movstat,            rng randist    )
$(call test_prerequisites, multifit,           rng specfunc   )
$(call test_prerequisites, multifit_nlinear,                  )
$(call test_prerequisites, multilarge,         rng            )
$(call test_prerequisites, multilarge_nlinear,                )
$(call test_prerequisites, multimin,                          )
$(call test_prerequisites, multiroots,                        )
$(call test_prerequisites, multiset,                          )
$(call test_prerequisites, ntuple,                            )
$(call test_prerequisites, ode-initval,                       )
$(call test_prerequisites, ode-initval2,                      )
$(call test_prerequisites, permutation,                       )
$(call test_prerequisites, poly,               sort           )
$(call test_prerequisites, qrng,                              )
$(call test_prerequisites, randist,            cdf integration)
$(call test_prerequisites, rng,                               )
$(call test_prerequisites, roots,                             )
$(call test_prerequisites, rstat,              rng statistics )
$(call test_prerequisites, siman,              rng            )
$(call test_prerequisites, sort,                              )
$(call test_prerequisites, spblas,             rng spmatrix   )
$(call test_prerequisites, specfunc,                          )
$(call test_prerequisites, splinalg,           rng spmatrix   )
$(call test_prerequisites, spmatrix,           rng            )
$(call test_prerequisites, statistics,         rng            )
$(call test_prerequisites, sum,                               )
$(call test_prerequisites, sys,                               )
$(call test_prerequisites, vector,                            )
$(call test_prerequisites, wavelet,                           )

# Set of prerequiesaites for libraries

# define to set library prerequisite target
# Example of of unrolling:
# from:
# $(call lib_prerequisites, wavelet, matrix)
# to:
# wavelet-prerequisites:		    include-install matrix-install

define lib_prerequisites
$(addsuffix -prerequisites,$(1)): include-install $(addsuffix -install,$(2))
endef

$(call lib_prerequisites, blas,                err cblas matrix         )
$(call lib_prerequisites, block,               err                      )
$(call lib_prerequisites, bspline,             statistics linalg        )
$(call lib_prerequisites, cblas,                                        )
$(call lib_prerequisites, cdf,                 randist                  )
$(call lib_prerequisites, cheb,                err sys                  )
$(call lib_prerequisites, combination,         vector                   )
$(call lib_prerequisites, complex,                                      )
$(call lib_prerequisites, const,                                        )
$(call lib_prerequisites, deriv,               cblas                    )
$(call lib_prerequisites, dht,                 specfunc                 )
$(call lib_prerequisites, diff,                cblas                    )
$(call lib_prerequisites, eigen,               linalg                   )
$(call lib_prerequisites, err,                                          )
$(call lib_prerequisites, fft,                 err                      )
$(call lib_prerequisites, filter,              movstat vector poly      )
$(call lib_prerequisites, fit,                 cblas                    )
$(call lib_prerequisites, histogram,           err block                )
$(call lib_prerequisites, ieee-utils,          err                      )
$(call lib_prerequisites, integration,         err sys                  )
$(call lib_prerequisites, interpolation,       vector poly linalg       )
$(call lib_prerequisites, linalg,              blas permutation  sys    )
$(call lib_prerequisites, matrix,              vector                   )
$(call lib_prerequisites, min,                 err sys                  )
$(call lib_prerequisites, monte,               rng                      )
$(call lib_prerequisites, movstat,             statistics               )
$(call lib_prerequisites, multifit,            min linalg  statistics   )
$(call lib_prerequisites, multifit_nlinear,    linalg poly              )
$(call lib_prerequisites, multilarge,          eigen multifit           )
$(call lib_prerequisites, multilarge_nlinear,  multifit multifit_nlinear )
$(call lib_prerequisites, multimin,            blas poly matrix         )
$(call lib_prerequisites, multiroots,          linalg                   )
$(call lib_prerequisites, multiset,            vector                   )
$(call lib_prerequisites, ntuple,              histogram                )
$(call lib_prerequisites, ode-initval,         linalg                   )
$(call lib_prerequisites, ode-initval2,        linalg                   )
$(call lib_prerequisites, permutation,         matrix  complex          )
$(call lib_prerequisites, poly,                err                      )
$(call lib_prerequisites, qrng,                err                      )
$(call lib_prerequisites, randist,             specfunc  statistics rng )
$(call lib_prerequisites, rng,                 err   sys                )
$(call lib_prerequisites, roots,               err   sys                )
$(call lib_prerequisites, rstat,               randist                  )
$(call lib_prerequisites, siman,               rng                      )
$(call lib_prerequisites, sort,                permutation              )
$(call lib_prerequisites, spblas,              matrix blas              )
$(call lib_prerequisites, specfunc,            sys poly eigen           )
$(call lib_prerequisites, splinalg,            linalg                   )
$(call lib_prerequisites, spmatrix,            spblas                   )
$(call lib_prerequisites, statistics,          sort                     )
$(call lib_prerequisites, sum,                 err sys                  )
$(call lib_prerequisites, sys,                                          )
$(call lib_prerequisites, test,                sys                      )
$(call lib_prerequisites, utils,                                        )
$(call lib_prerequisites, vector,              block                    )
$(call lib_prerequisites, wavelet,             err matrix               )


# Set of prerequiesaites for examples
# Example of of unrolling:
# from:
# $(call example_prerequisites, integration2, integration specfunc   )
# to:
# doc/examples/integration2--prerequisites:		    sys-install integration-install specfunc-install

define example_prerequisites
doc/examples/$(strip $(1))-prerequisites: sys-install $(addsuffix -install,$(2)) 
endef

$(call example_prerequisites, blas, blas)
$(call example_prerequisites, block, block)
$(call example_prerequisites, cblas, cblas)
$(call example_prerequisites, cdf, cdf)
$(call example_prerequisites, cheb, cheb)
$(call example_prerequisites, combination, combination)
$(call example_prerequisites, multiset, multiset)
$(call example_prerequisites, const, const)
$(call example_prerequisites, diff, deriv)
$(call example_prerequisites, eigen, eigen)
$(call example_prerequisites, fft, err fft)
$(call example_prerequisites, fftmr, err fft)
$(call example_prerequisites, fftreal, err fft fft)
$(call example_prerequisites, filt_edge, filter rng randist vector)
$(call example_prerequisites, fitting, fit)
$(call example_prerequisites, fitting2, multifit)
$(call example_prerequisites, fitting3, randist)
$(call example_prerequisites, fitreg, vector matrix rng randist multifit)
$(call example_prerequisites, fitreg2, vector matrix multifit blas)
$(call example_prerequisites, gaussfilt, filter rng randist vector)
$(call example_prerequisites, gaussfilt2, filter rng randist vector)
$(call example_prerequisites, histogram, histogram)
$(call example_prerequisites, histogram2d, rng histogram)
$(call example_prerequisites, ieee, ieee-utils)
$(call example_prerequisites, ieeeround, ieee-utils)
$(call example_prerequisites, impulse, filter rng randist vector)
$(call example_prerequisites, integration, integration)
$(call example_prerequisites, integration2, integration specfunc)
$(call example_prerequisites, interp, err interpolation)
$(call example_prerequisites, interp2d, interpolation interpolation)
$(call example_prerequisites, intro, specfunc)
$(call example_prerequisites, linalglu, linalg)
$(call example_prerequisites, largefit, vector matrix rng randist multifit multilarge blas)
$(call example_prerequisites, matrix, matrix)
$(call example_prerequisites, matrixw, matrix)
$(call example_prerequisites, min, err min)
$(call example_prerequisites, monte, monte monte monte monte)
$(call example_prerequisites, movstat1, movstat rng randist vector)
$(call example_prerequisites, movstat2, movstat rng randist vector)
$(call example_prerequisites, movstat3, movstat rng randist vector sort statistics)
$(call example_prerequisites, ntupler, ntuple histogram)
$(call example_prerequisites, ntuplew, ntuple rng randist)
$(call example_prerequisites, ode-initval, err matrix ode-initval2)
$(call example_prerequisites, odefixed, ode-initval2)
$(call example_prerequisites, permseq, permutation)
$(call example_prerequisites, permshuffle, rng randist permutation)
$(call example_prerequisites, polyroots, poly)
$(call example_prerequisites, qrng, qrng)
$(call example_prerequisites, randpoisson, rng randist)
$(call example_prerequisites, randwalk, rng randist)
$(call example_prerequisites, rng, rng)
$(call example_prerequisites, rngunif, rng)
$(call example_prerequisites, robfit, multifit randist)
$(call example_prerequisites, rootnewt, err roots)
$(call example_prerequisites, roots, err roots)
$(call example_prerequisites, siman, siman)
$(call example_prerequisites, siman_tsp, rng siman ieee-utils)
$(call example_prerequisites, sortsmall, rng sort)
$(call example_prerequisites, specfun, specfunc)
$(call example_prerequisites, specfun_e, err specfunc)
$(call example_prerequisites, rstat, rstat)
$(call example_prerequisites, rquantile, rstat statistics rng randist sort)
$(call example_prerequisites, stat, statistics)
$(call example_prerequisites, statsort, sort statistics)
$(call example_prerequisites, sum, sum)
$(call example_prerequisites, vector, vector)
$(call example_prerequisites, vectorr, vector)
$(call example_prerequisites, vectorview, matrix blas)
$(call example_prerequisites, vectorw, vector)
$(call example_prerequisites, dwt, sort wavelet)
$(call example_prerequisites, nlfit, rng randist matrix vector blas multifit_nlinear)
$(call example_prerequisites, nlfit2, vector matrix blas multifit_nlinear)
$(call example_prerequisites, nlfit2b, vector matrix blas multifit_nlinear rng randist)
$(call example_prerequisites, nlfit3, vector matrix blas multifit_nlinear)
$(call example_prerequisites, interpp, err interpolation)
$(call example_prerequisites, eigen_nonsymm, eigen)
$(call example_prerequisites, bspline, bspline multifit rng randist statistics)
$(call example_prerequisites, multimin, multimin)
$(call example_prerequisites, nmsimplex, multimin)
$(call example_prerequisites, ode-initval-low-level, ode-initval2)
$(call example_prerequisites, poisson, vector spmatrix splinalg)
$(call example_prerequisites, interp_compare, interpolation)
$(call example_prerequisites, spmatrix, spmatrix)
$(call example_prerequisites, nlfit4, vector matrix blas multilarge_nlinear spblas spmatrix)

EVSS_MAKE_DEFAULT_TARGET_FULL_LIST = $(EVSS_SUBMODULES_FULL_LIST)
EVSS_MAKE_ALL_TARGET_FULL_LIST = $(addsuffix -all,$(EVSS_SUBMODULES_FULL_LIST))
EVSS_MAKE_INSTALL_TARGET_FULL_LIST = $(addsuffix -install,$(EVSS_SUBMODULES_FULL_LIST))
EVSS_MAKE_PREREQUISITES_TARGET_FULL_LIST = $(addsuffix -prerequisites,$(EVSS_SUBMODULES_FULL_LIST))
EVSS_MAKE_CLEAN_TARGET_FULL_LIST = $(addsuffix -clean,$(EVSS_SUBMODULES_FULL_LIST))
EVSS_MAKE_CLEANALLCFG_TARGET_FULL_LIST = $(addsuffix -clean-all,$(EVSS_SUBMODULES_FULL_LIST))

.PHONY: help all install clean clean-all $(EVSS_MAKE_DEFAULT_TARGET_FULL_LIST) $(EVSS_MAKE_ALL_TARGET_FULL_LIST) $(EVSS_MAKE_INSTALL_TARGET_FULL_LIST) $(EVSS_MAKE_PREREQUISITES_TARGET_FULL_LIST) $(EVSS_MAKE_CLEAN_TARGET_FULL_LIST) $(EVSS_MAKE_CLEANALLCFG_TARGET_FULL_LIST)


EVSS_SUBMODULES ?= $(EVSS_SUBMODULES_FULL_LIST)


all: $(addsuffix -install,$(EVSS_SUBMODULES))

install: $(addsuffix -install,$(EVSS_SUBMODULES))

clean:: $(addsuffix -clean,$(EVSS_SUBMODULES))

clean-all:: $(addsuffix -clean-all,$(EVSS_SUBMODULES))

$(EVSS_MAKE_DEFAULT_TARGET_FULL_LIST): %: %-install

$(EVSS_MAKE_ALL_TARGET_FULL_LIST): %-all: %-install

$(EVSS_MAKE_INSTALL_TARGET_FULL_LIST): %-install: %-prerequisites
	@echo ""
	@echo "===== Starting '$*-install' (build and install) ====="
	@echo ""
	$(MAKE) install -C $* PREREQUISITES_ARE_DONE=1
	@echo ""
	@echo "===== '$*-install' - Finished ====="
	@echo ""

$(EVSS_MAKE_PREREQUISITES_TARGET_FULL_LIST): %-prerequisites: ;

clean-all-submodules: $(EVSS_MAKE_CLEAN_TARGET_FULL_LIST)

$(EVSS_MAKE_CLEAN_TARGET_FULL_LIST): %-clean:
	@echo ""
	@echo "===== Starting '$*-clean' (clean current configuration) ====="
	@echo ""
	$(MAKE) clean -C $*
	@echo ""
	@echo "===== '$*-clean' - Finished ====="
	@echo ""

$(EVSS_MAKE_CLEANALLCFG_TARGET_FULL_LIST): %-clean-all:
	@echo ""
	@echo "===== Starting '$*-clean-all' (clean all configurations) ====="
	@echo ""
	$(MAKE) clean-all -C $*
	@echo ""
	@echo "===== '$*-clean-all' - Finished ====="
	@echo ""

# This is special target which removes install folder from the project
clean-install:
	$(MAKE) clean-install -C include



help::
	$(info $(HS))
	$(info ===== GSL software top-level Makefile =====)
	$(info $(HS))
	$(info Usage:)
	$(info $(HS) make [ help|install|all|clean|clean-all [...] ] [ EVSS_CFG=<evss_cfg> ] [ EVSS_DBG={0|1} ] [ EVSS_SUBMODULES=<submodules_to_be_built> ])
	$(info $(HS))
	$(info Make targets:)
	$(info $(HS) help - print this message. It's default target)
	$(info $(HS) install - build and install this subproject only (without dependencies for selected configuration (EVSS_CFG, EVSS_DBG)))
	$(info $(HS) all - the same as install)
	$(info $(HS) clean - delete this subproject build artifacts for selected configuration (EVSS_CFG, EVSS_DBG))
	$(info $(HS) clean-all - try delete this subproject build artifacts for ALL configurations.)
	$(info $(HS) Attention: It is potentially dangerous. 'build_*' name template used for deletion)
	$(info $(HS))
	$(info Possible parameter values:)
	$(info $(HS) EVSS_CFG = folder with configuration files, default = ev_native)
	$(info $(HS) EVSS_DBG = 0 or 1, where 0 - Release build mode, 1 - Debug build mode, default = 0)
	$(info $(HS) EVSS_SUBMODULES = "<submodules_to_be_built>", space-separated list, default value is project-specific)
	$(info $(HS))
	$(info $(HS) Current call values)
	$(info $(HS) EVSS_CFG = $(EVSS_CFG))
	$(info $(HS) EVSS_DBG = $(EVSS_DBG))
	$(info $(HS) EVSS_SUBMODULES = $(EVSS_SUBMODULES))
	$(info $(HS))
	$(info ===== end for top-level help =====)
	$(info $(HS))
