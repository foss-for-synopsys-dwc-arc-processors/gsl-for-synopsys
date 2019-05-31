#==============================================================================
# Wrapper to use EVRT config.mk, but CNN SDK cnnsdk.cmake
#==============================================================================
include $(EVSS_RT_HOME)/config/config.mk
CMAKE_ARGS += -DCMAKE_MODULE_PATH=$(EV_GSL_HOME)/config/cmake/Modules