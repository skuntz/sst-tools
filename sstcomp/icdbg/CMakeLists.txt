#
# sst-tools/sstcomp/igrid CMake
#
# Copyright (C) 2017-2025 Tactical Computing Laboratories, LLC
# All Rights Reserved
# contact@tactcomplabs.com
# See LICENSE in the top level directory for licensing details
#

set(ICDbgSrcs
  ICDbg.cc
  ICDbg.h
)

add_library(icdbg SHARED ${ICDbgSrcs})
target_include_directories(icdbg PUBLIC ${SST_INSTALL_DIR}/include)
install(TARGETS icdbg DESTINATION ${CMAKE_CURRENT_SOURCE_DIR})
install(CODE "execute_process(COMMAND sst-register icdbg icdbg_LIBDIR=${CMAKE_CURRENT_SOURCE_DIR})")
#install(CODE "execute_process(COMMAND sst-register ICDebug icdbg_LIBDIR=${CMAKE_CURRENT_SOURCE_DIR})")
# EOF
