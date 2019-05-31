
ifndef EV_GSL_HOME
    $(error ERROR: EV_GSL_HOME is not defined, please set point it to <your GSL installation> directory)
endif

include $(EV_GSL_HOME)/config/env.mk

ARGS ?=
EXE=ieee-utils_test
LINUX_EXE = $(EXE)
WIN_EXE = $(EXE).exe
EVSS_EXE = $(EXE).out

PREREQUISITES_COMMAND=+$(MAKE) -C $(EV_GSL_HOME) ieee-utils/test-prerequisites


# Common rules and configuration
include $(EV_GSL_HOME)/config/gsl_config.mk
