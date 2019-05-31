#!/bin/bash
# Master setup script for EV GSL
# Required tools
# CMake 3.8 or greater
# make 3.82 or greater
# python2 2.7 or greater
# GCC 6.2.0 or greater
# MetaWare EV P-2019.06



check_tools=
err_cnt=0


for i in "$@"
do
case $i in
    -check|-check_tools|--check|--check_tools)
    check_tools=1
    shift ;;

esac
done

function version_ge() {
    test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1";
}

function check_tool() {
    if [[ "$1" == "" ]] ; then
        echo "ERROR: $3 is not found. Install $3 with version $2 or greater"
        ((err_cnt++))
    else
        if version_ge $2 $1 ; then
            echo "ERROR: $3 had old version $1. Install $3 with version $2 or greater"
            ((err_cnt++))
        else
            echo "$3 is installed. Version is $1"
        fi
    fi
}

echo "Setup EV Runtime environment..."


#
if [[ -z "${EVSS_HOME}" ]]; then
        echo " EVSS_HOME is not defined, it should point to the EV_Runtime location - please check your installation"
  exit 1
fi

export NSIM_MULTICORE=1


if [ "$check_tools" = 1 ]; then
    echo "Checking tools in EV Runtime environment..."
    CMAKE_VERSION=$(cmake --version | head -n1 | cut -d ' ' -f 3)
    CMAKE_VERSION_REF="3.8"
    check_tool "$CMAKE_VERSION" "$CMAKE_VERSION_REF" "CMAKE"
    MAKE_VERSION=$(make --version | head -n1 | cut -d ' ' -f 3)
    MAKE_VERSION_REF="3.82"
    check_tool "$MAKE_VERSION" "$MAKE_VERSION_REF" "MAKE"
    PYTHON2_VERSION=$(python2 --version 2>&1 | cut -d ' ' -f 2)
    PYTHON2_VERSION_REF="2.7"
    check_tool "$PYTHON2_VERSION" "$PYTHON2_VERSION_REF" "PYTHON2"
    GCC_VERSION=$(gcc -dumpversion)
    GCC_VERSION_REF="6.2"
    check_tool "$GCC_VERSION" "$GCC_VERSION_REF" "GCC"
    CCAC_VERSION=$(ccac -v 2>&1 | head -n1 | cut -d ' ' -f 5)
    CCAC_VERSION_REF="P-2019.06"
    check_tool "$CCAC_VERSION" "$GCC_VERSION_REF" "CCAC"

    for tool in "make cmake python2 gcc g++ ccac nsimdrv" ; do
        if [ "$(which $tool &> /dev/null)" ] ; then echo "Error: $tool tool not found!" ; ((err_cnt++)) ; fi
    done
    if [[ "$err_cnt" != "0" ]] ; then
        echo "$err_cnt tool(s) should be checked"
    else
        echo "All necessary tools were installed correctly."
    fi
    echo "DONE!"
fi

export EV_GSL_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "EV_GSL_HOME is ${EV_GSL_HOME}"
# Source MetaWareEV tools versions file
source $EV_GSL_HOME/config/version.sh

