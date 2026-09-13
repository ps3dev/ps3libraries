#
# CMake toolchain for the PS3 PPU (powerpc64-ps3-elf).
#
# Use:
#   cmake -DCMAKE_TOOLCHAIN_FILE=$PS3DEV/share/cmake/ps3dev.toolchain.cmake ...
#

cmake_minimum_required(VERSION 3.12)

if(DEFINED ENV{PS3DEV})
  set(PS3DEV $ENV{PS3DEV})
else()
  message(FATAL_ERROR "The environment variable PS3DEV needs to be defined.")
endif()

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR powerpc64)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER powerpc64-ps3-elf-gcc)
set(CMAKE_CXX_COMPILER powerpc64-ps3-elf-g++)
set(CMAKE_ASM_COMPILER powerpc64-ps3-elf-g++)

set(PPC_INC
  ${PS3DEV}/ppu/include
  ${PS3DEV}/ppu/include/simdmath
  ${PS3DEV}/portlibs/ppu/include
)
set(PPC_LIB
  ${PS3DEV}/ppu/lib
  ${PS3DEV}/ppu/ppu/lib
  ${PS3DEV}/portlibs/ppu/lib
)

set(PPC_MACHDEP -mhard-float -fmodulo-sched -ffunction-sections -fdata-sections)
set(PPC_CFLAGS -O2 -Wall -mcpu=cell ${PPC_MACHDEP})
set(PPC_LDFLAGS -Wl,-zmax-page-size=128)
set(PPC_LIBS -lgcm_sys -lrsx -lsysutil -lio -lm -lz -lrt -llv2 -laudio)

string(JOIN " " PPC_CFLAGS_STR ${PPC_CFLAGS})
string(JOIN " " PPC_LDFLAGS_STR ${PPC_LDFLAGS})
string(JOIN " " PPC_LIBS_STR ${PPC_LIBS})
list(TRANSFORM PPC_INC PREPEND "-I" OUTPUT_VARIABLE PPC_INC_FLAGS)
string(JOIN " " PPC_INC_STR ${PPC_INC_FLAGS})
list(TRANSFORM PPC_LIB PREPEND "-L" OUTPUT_VARIABLE PPC_LIB_FLAGS)
string(JOIN " " PPC_LIB_STR ${PPC_LIB_FLAGS})

set(CMAKE_C_FLAGS_INIT "${PPC_CFLAGS_STR} ${PPC_INC_STR}")
set(CMAKE_CXX_FLAGS_INIT ${CMAKE_C_FLAGS_INIT})
set(CMAKE_EXE_LINKER_FLAGS_INIT "${PPC_LDFLAGS_STR} ${PPC_LIB_STR}")
set(CMAKE_SHARED_LINKER_FLAGS "${PPC_LIBS_STR}")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_INSTALL_PREFIX "${PS3DEV}/portlibs/ppu" CACHE PATH "" FORCE)
set(CMAKE_PREFIX_PATH "${PS3DEV}/portlibs/ppu" CACHE PATH "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS TRUE)

add_compile_definitions(PS3 __PS3__)
set(PS3 TRUE)

macro(ps3_target_setup target)
  target_compile_options(${target} PRIVATE ${PPC_CFLAGS})
  target_link_options(${target} PRIVATE ${PPC_LDFLAGS})
  target_link_directories(${target} PRIVATE ${PPC_LIB})
  target_include_directories(${target} PUBLIC ${PPC_INC})
  target_link_libraries(${target} PUBLIC ${PPC_LIBS})
endmacro()

function(ps3_build_self target)
  set(ELF_FILE $<TARGET_FILE:${target}>)
  set(STRIPPED_ELF ${ELF_FILE}.stripped.elf)
  set(SELF_FILE ${ELF_FILE}.self)
  set(FSELF_FILE ${ELF_FILE}.fake.self)

  add_custom_command(
    TARGET ${target}
    POST_BUILD
    COMMAND echo "Running PS3 post-build steps..."
    COMMAND ${PS3DEV}/bin/sprxlinker ${ELF_FILE}
    COMMAND ${PS3DEV}/ppu/bin/powerpc64-ps3-elf-strip --strip-debug ${ELF_FILE} -o ${STRIPPED_ELF}
    COMMAND ${PS3DEV}/bin/make_self ${STRIPPED_ELF} ${SELF_FILE}
    COMMAND ${PS3DEV}/bin/fself ${STRIPPED_ELF} ${FSELF_FILE}
    COMMAND echo "Done: ${SELF_FILE}"
  )
endfunction()
