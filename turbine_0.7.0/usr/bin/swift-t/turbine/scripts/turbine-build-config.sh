# BASH-formatted setup script processed by turbine/configure
#
# This contains variables relevant to compiling code that uses the 
# Turbine C interface

TURBINE_HOME='/usr/bin/swift-t/turbine'
TURBINE_VERSION='0.8.0'
C_UTILS_HOME='/usr/bin/swift-t/c-utils'
TCL_HOME='/usr'
TCL_VERSION='8.6'
TCL_LIB_DIR='/usr/lib/x86_64-linux-gnu'
TCL_SYSLIB_DIR='/usr/share/tcltk'
TCL_LIB_SPEC='-L/usr/lib/x86_64-linux-gnu -ltcl8.6'
# Tcl library dependencies for static build
TCL_LIB_SPEC_EXTRA='-ldl -lz  -lpthread -lieee -lm'
TCL_INCLUDE_SPEC='-I/usr/include/tcl8.6'
TCLSH='/usr/bin/tclsh8.6'
ADLB_HOME='/usr/bin/swift-t/lb'

MPI_INCLUDE='/usr/include/mpi'
# Only one of the following is used
MPI_LIB_DIR='/usr/lib'
MPI_LIB_NAME='mpi'
MPI_LIB_SPEC='-lmpi'

ENABLE_MPE='0'
MPE='0'


# TURBINE_INCLUDES has the flags for all non-system dependencies of 
# Turbine that user code may reference
TURBINE_INCLUDES="-I${TURBINE_HOME}/include -I${C_UTILS_HOME}/include \
                  -I${ADLB_HOME}/include ${TCL_INCLUDE_SPEC}"
if [ ! -z "$MPI_INCLUDE" -a "$MPI_INCLUDE" != 0 ]; then
  TURBINE_INCLUDES+=" -I$MPI_INCLUDE"
fi

# TURBINE_INCLUDES has the flags for all library dependencies of
# Turbine that user code may reference
TURBINE_LIBS="-L${TURBINE_HOME}/lib \
              -ltclturbinestatic -ltclturbine \
              -L${ADLB_HOME}/lib -ladlb \
              -L${C_UTILS_HOME}/lib -lexmcutils \
              ${TCL_LIB_SPEC} ${TCL_LIB_SPEC_EXTRA}"

# Rpath including all ExM libraries and dependencies
TURBINE_RPATH="-Wl,-rpath,${TURBINE_HOME}/lib \
               -Wl,-rpath,${ADLB_HOME}/lib \
               -Wl,-rpath,${C_UTILS_HOME}/lib"

if [ ! -z "$MPI_LIB_DIR" -a "$MPI_LIB_DIR" != 0 ]; then
  TURBINE_LIBS+=" -L$MPI_LIB_DIR"
  TURBINE_RPATH+=" -Wl,-rpath,${MPI_LIB_DIR}"
fi
TURBINE_LIBS+=" ${MPI_LIB_SPEC}"

if [ "$ENABLE_MPE" = 1 ]; then
  TURBINE_LIBS+=" -L${MPE}/lib -lmpe"
  TURBINE_INCLUDES+=" -I${MPE}/include"
  TURBINE_RPATH+=" -Wl,-rpath,${MPE}/lib"
fi

