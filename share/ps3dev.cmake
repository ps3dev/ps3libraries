#
# CMake platform file for PS3 PPC processor
#

cmake_minimum_required(VERSION 3.0...3.12)

if(DEFINED ENV{PS3DEV})
    set(PS3DEV $ENV{PS3DEV})
else()
    message(FATAL_ERROR "The environment variable PS3DEV needs to be defined.")
endif()

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR powerpc64)

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
set(PPC_LDFLAGS  -Wl,-zmax-page-size=128)
set(PPC_LIBS -lgcm_sys -lrsx -lsysutil -lio -lm -lz -lrt -llv2 -laudio)

set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS TRUE)

add_compile_definitions(PS3 __PS3__)
set(PS3 1)

macro(ps3_target_setup target)
    target_compile_options(${target} PRIVATE
       ${PPC_CFLAGS}
    )
    target_link_options(${target} PRIVATE
       ${PPC_LDFLAGS}
    )
	target_link_directories(${target} PRIVATE
       ${PPC_LIB}
	)
    target_include_directories(${target} PUBLIC
       ${PPC_INC}
    )
    target_link_libraries(${target} PUBLIC
       ${PPC_LIBS}
    )
endmacro()

include("${PS3DEV}/share/createSELF.cmake")
include("${PS3DEV}/share/createPKG.cmake")

