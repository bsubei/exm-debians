
# BASH-formatted setup script filtered by turbine/configure
#
# Influential environment variables include:
# TURBINE_USER_LIB - directory for user library code
# TURBINE_STATIC_EXEC - if true, try to use statically linked executable

TURBINE_HOME=/home/basheersubei/exm-install/turbine
TURBINE_VERSION=0.8.0
export C_UTILS=/home/basheersubei/exm-install/c-utils
export TCL=/usr
export TCLSH=/usr/bin/tclsh8.6
export ADLB=/home/basheersubei/exm-install/lb

export MPI_IMPL=MPICH2
# Only one of the following is used
export MPI=@USE_MPI@
export MPI_LIB=/usr/lib
export TURBINE_LAUNCHER=/usr/bin/mpiexec
export TURBINE_LINE_OUTPUT_FLAG=-l
export TURBINE_SH=${TURBINE_HOME}/bin/turbine_sh
export TURBINE_MAC=no

# If we have pkgIndex.tcl/.so package
TURBINE_PKG_AVAIL=1

TCLLIBPATH=
if [[ -n ${SWIFT_PATH:-} ]]
then
  TCLLIBPATH+="${SWIFT_PATH} "
elif [[ -n ${TURBINE_PATH:-} ]]
then
  TCLLIBPATH+="${TURBINE_PATH} "
elif [[ -n ${TURBINE_USER_LIB:-} ]]
then
  TCLLIBPATH+="${TURBINE_USER_LIB} "
fi

EXEC_SCRIPT=${EXEC_SCRIPT:-0}
TURBINE_STATIC_EXEC=${TURBINE_STATIC_EXEC:-0}
if (( EXEC_SCRIPT ))
then
  # Run script directly
  export TCLSH=""
elif (( TURBINE_STATIC_EXEC ))
then
  # Use statically linked executable with builtin Turbine package
  export TCLSH=${TURBINE_SH}
elif (( !TURBINE_PKG_AVAIL ))
then
  # Don't have dynamically loadable package - must use statically linked
  # executable
  export TCLSH=${TURBINE_SH}
else
  # Use regular tclsh plus loadable Turbine Tcl package
  if [[ ${TCLSH} == "" ]]
  then
    echo "Could not find tclsh!"
    return 1
  fi
  TCLLIBPATH+="${TURBINE_HOME}/lib"
fi

export TCLLIBPATH

export TURBINE_MACHINE=normal

export TURBINE_USE_PYTHON=0
export TURBINE_USE_R=0

return 0
