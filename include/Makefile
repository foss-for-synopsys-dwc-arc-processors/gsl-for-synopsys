
ifndef EV_GSL_HOME
    $(error ERROR: EV_GSL_HOME is not defined, please set point it to <your EV CNN SDK installation>/software directory)
endif

# Post process and check the path variables
override EV_GSL_HOME := $(abspath $(EV_GSL_HOME))

ifeq ($(strip $(wildcard $(EV_GSL_HOME))),)
    $(error ERROR: EV_GSL_HOME variable does not point to a directory)
endif

override EVSS_CFG := ev_native
NOT_CHECK_EVSS = ON
override EVSS_DBG := 0

include $(EV_GSL_HOME)/config/env.mk

$(info EV_GSL_HOME = $(EV_GSL_HOME))
# Common rules and configuration
PREREQUISITES_COMMAND=+$(MAKE) -C "$(EV_GSL_HOME)"  include-prerequisites
include $(EV_GSL_HOME)/config/gsl_config.mk

clean-install:
	@echo "===== Clean install folder ====="
	$(call RM_DIR, "$(EV_GSL_HOME)/install")
