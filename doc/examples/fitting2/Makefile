
ifndef EV_GSL_HOME
    $(error ERROR: EV_GSL_HOME is not defined, please set point it to <your GSL installation> directory)
endif

include $(EV_GSL_HOME)/config/env.mk

ARGS ?= 19 < fitting2_in.txt 
PREREQUISITES_COMMAND=+$(MAKE) -C $(EV_GSL_HOME) doc/examples/fitting2-prerequisites

EXE = fitting2_example
LINUX_EXE = $(EXE)
WIN_EXE = $(EXE).exe
EVSS_EXE = $(EXE).out

# Common rules and configuration
#
include $(EV_GSL_HOME)/config/gsl_config.mk
 
