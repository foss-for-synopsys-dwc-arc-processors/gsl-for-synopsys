
# Environment setup & sanity check.
#

# Check version of Makefile utility
MAKE_REQUIRED_VERSION := 3.82
VERSION_CHECK_RESULT := $(filter $(MAKE_REQUIRED_VERSION),$(firstword $(sort $(MAKE_VERSION) $(MAKE_REQUIRED_VERSION))))

ifeq ("$(VERSION_CHECK_RESULT)", "")
    $(error ERROR: Version of Makefile utility is old. You use $(MAKE_VERSION). Required version is $(MAKE_REQUIRED_VERSION) or newer))
endif
 
ifndef EVSS_RT_HOME
    $(error ERROR: EVSS_RT_HOME is not defined, please set point it to <your EV installation>/software directory)
endif

ifndef EVSS_HOME
   EVSS_HOME=$(EVSS_RT_HOME)
endif

ifndef EV_GSL_HOME
    $(error ERROR: EV_GSL_HOME is not defined, please set point it to your GSL installation directory)
endif


# Post process and check the path variables
override EVSS_RT_HOME := $(abspath $(EVSS_RT_HOME))
override EVSS_HOME := $(abspath $(EVSS_HOME))
override EV_GSL_HOME := $(abspath $(EV_GSL_HOME))

EVSS_MAKE_DIR=$(dir $(realpath $(firstword $(MAKEFILE_LIST))))
CMAKE_DIR=$(EVSS_MAKE_DIR)

ifeq ($(strip $(wildcard $(EVSS_HOME))),)
    $(error ERROR: EVSS_HOME variable does not point to a directory)
endif

ifeq ($(strip $(wildcard $(EV_GSL_HOME))),)
    $(error ERROR: EV_GSL_HOME variable does not point to a directory)
endif

ifndef EVSS_CFG
EVSS_CFG=ev_native
    ifneq ("clean-all","$(strip $(filter clean-all, $(MAKECMDGOALS) ))")
        $(warning WARNING: EVSS_CFG not set, defaulting to $(EVSS_CFG) )
    endif
endif

EVSS_DBG?=0
ifneq (0,$(EVSS_DBG))
CMAKE_BUILD_TYPE=Debug
GSL_CFG_NAME=$(EVSS_CFG)$(EVSS_PROFILE_EXT)debug
else
CMAKE_BUILD_TYPE=Release
GSL_CFG_NAME=$(EVSS_CFG)$(EVSS_PROFILE_EXT)release
endif

# In our project there are several utils, which compile for native platform only
# to be compiled in our flow they redefine EVSS_CFG to ev_native
# NOT_CHECK_EVSS is used to avoid mismatch


ifeq ($(strip $(NOT_CHECK_EVSS)),)
ifeq ($(strip $(wildcard $(EVSS_RT_HOME)/install/$(GSL_CFG_NAME))),)
#      $(error ERROR: First build ev_runtime for your configuration EVSS_CFG=$(EVSS_CFG) EVSS_DBG=$(EVSS_DBG) !)
#	EVSS_ISNOT_BUILT=1
	GSL_CHECK_EVSS=evss_isnot_built
endif
endif

ifndef EV_GSL_INSTALL_PREFIX
EV_GSL_INSTALL_PREFIX=$(EV_GSL_HOME)/install
endif

ifndef EV_GSL_INSTALL_DIR
EV_GSL_INSTALL_DIR=$(EV_GSL_INSTALL_PREFIX)/$(GSL_CFG_NAME)
endif

ifdef DOC
CMAKE_ARGS += -DBUILD_DOC=ON
endif

$(info env.mk to cmake EV_GSL_HOME=$(EV_GSL_HOME))
CMAKE_ARGS += -DEV_GSL_HOME=$(EV_GSL_HOME)

# Add Extra path to PYTHON path with different delimeter for Win/Linux

ifeq ($(OS),Windows_NT)
   fix_path_add=$(1)    
else
   fix_path_add=$(strip $(subst ;,:$(nullstring), $(1)))
endif	

# In our project there are several utils, which compile for native platform only
# to be compiles in our flow they redefine EVSS_CFG to ev_native
# NOT_CHECK_EVSS is used to avoid mismatch

evss_isnot_built:
	$(info NOT_CHECK_EVSS=$(NOT_CHECK_EVSS))
	$(error ERROR: First build ev_runtime for your configuration EVSS_CFG=$(EVSS_CFG) EVSS_DBG=$(EVSS_DBG) !)

.DEFAULT_GOAL = help
