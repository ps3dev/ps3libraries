cmake_minimum_required(VERSION 3.10)

# ---------------------------------------------------------------------------
# ps3_create_self_file
#
# Runs the PSL1GHT post-build steps needed to turn a plain PPU ELF target
# into a signed SELF (and optionally a fake SELF for use with PS3 loaders),
# equivalent to:
#
#   sprxlinker $<TARGET_FILE>
#   powerpc64-ps3-elf-strip --strip-debug $<TARGET_FILE> -o <stripped.elf>
#   make_self  <stripped.elf> <target>.self
#   fself      <stripped.elf> <target>.fake.self
#
# Usage:
#
#   add_executable(mygame main.c)
#   ps3_create_self_file(TARGET mygame)
#
# Optional arguments let you skip steps or change output locations:
#
#   ps3_create_self_file(
#     TARGET       mygame
#     OUTPUT_DIR   "${CMAKE_BINARY_DIR}/pkg/USRDIR"
#     OUTPUT_NAME  EBOOT
#     NO_SPRXLINK           # skip the sprxlinker OPD-fixup step
#     NO_STRIP              # skip stripping, package the raw ELF instead
#     NO_FSELF              # don't build the fake SELF
#   )
# ---------------------------------------------------------------------------

if(NOT DEFINED PS3DEV)
  set(PS3DEV "$ENV{PS3DEV}")
endif()

find_program(SPRXLINKER_EXECUTABLE   NAMES sprxlinker   PATHS "${PS3DEV}/bin")
find_program(MAKE_SELF_EXECUTABLE    NAMES make_self     PATHS "${PS3DEV}/bin")
find_program(FSELF_EXECUTABLE        NAMES fself          PATHS "${PS3DEV}/bin")
find_program(PPU_STRIP_EXECUTABLE    NAMES powerpc64-ps3-elf-strip PATHS "${PS3DEV}/ppu/bin")

macro(ps3_create_self_file)

  set(oneValueArgs
    TARGET        # required, defined by add_executable() before calling create_self_file
    OUTPUT_DIR    # optional, directory the .self/.fake.self are written to (default: target's own output dir)
    OUTPUT_NAME   # optional, base filename, without extension (default: target name)
    STRIP_FLAGS   # optional, flags passed to the PPU strip tool (default: --strip-debug)
  )
  set(multiValueArgs)

  cmake_parse_arguments(ARG "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT DEFINED ARG_TARGET)
    message(FATAL_ERROR "ps3_create_self_file: TARGET must be defined")
  endif()

  if(NOT TARGET ${ARG_TARGET})
    message(FATAL_ERROR "ps3_create_self_file: '${ARG_TARGET}' is not a defined CMake target (call add_executable() first)")
  endif()

  if(NOT DEFINED ARG_OUTPUT_NAME)
    set(ARG_OUTPUT_NAME "${ARG_TARGET}")
  endif()

  if(NOT DEFINED ARG_STRIP_FLAGS)
    set(ARG_STRIP_FLAGS "--strip-debug")
  endif()

  if(NOT ARG_NO_SPRXLINK AND NOT SPRXLINKER_EXECUTABLE)
    message(FATAL_ERROR "ps3_create_self_file: sprxlinker not found, is PS3DEV set and in PATH?")
  endif()
  if(NOT ARG_NO_STRIP AND NOT PPU_STRIP_EXECUTABLE)
    message(FATAL_ERROR "ps3_create_self_file: powerpc64-ps3-elf-strip not found, is PS3DEV set and in PATH?")
  endif()
  if(NOT MAKE_SELF_EXECUTABLE)
    message(FATAL_ERROR "ps3_create_self_file: make_self not found, is PS3DEV set and in PATH?")
  endif()
  if(NOT ARG_NO_FSELF AND NOT FSELF_EXECUTABLE)
    message(FATAL_ERROR "ps3_create_self_file: fself not found, is PS3DEV set and in PATH?")
  endif()

  if(DEFINED ARG_OUTPUT_DIR)
    set(PS3_SELF_OUT_DIR "${ARG_OUTPUT_DIR}")
  else()
    set(PS3_SELF_OUT_DIR "$<TARGET_FILE_DIR:${ARG_TARGET}>")
  endif()

  set(PS3_SELF_WORK_ELF "${PS3_SELF_OUT_DIR}/${ARG_OUTPUT_NAME}")

  if(ARG_NO_STRIP)
    set(PS3_SELF_PACKAGE_ELF "${PS3_SELF_WORK_ELF}")
  else()
    set(PS3_SELF_PACKAGE_ELF "${PS3_SELF_OUT_DIR}/${ARG_OUTPUT_NAME}.stripped.elf")
  endif()

  set(PS3_SELF_FILE  "${PS3_SELF_OUT_DIR}/${ARG_OUTPUT_NAME}.self")
  set(PS3_FSELF_FILE "${PS3_SELF_OUT_DIR}/${ARG_OUTPUT_NAME}.fake.self")

  add_custom_command(
      TARGET ${ARG_TARGET}
      POST_BUILD
      COMMAND echo "Running PS3 post-build steps..."

      # 1. Fix OPD relocations FIRST, before anything else
      COMMAND ${SPRXLINKER_EXECUTABLE} ${PS3_SELF_WORK_ELF}

      # 2. Strip AFTER sprxlinker, preserve OPD with -R flag
      COMMAND ${PPU_STRIP_EXECUTABLE}
          --strip-debug
          ${PS3_SELF_WORK_ELF}
          -o ${PS3_SELF_PACKAGE_ELF}

      # 3. Package the STRIPPED elf into SELF
      COMMAND ${MAKE_SELF_EXECUTABLE} ${PS3_SELF_PACKAGE_ELF} ${PS3_SELF_FILE}
      COMMAND ${FSELF_EXECUTABLE} ${PS3_SELF_PACKAGE_ELF} ${PS3_FSELF_FILE}

      COMMAND echo "Done: ${PS3_SELF_FILE}"
  )

  unset(PS3_SELF_OUT_DIR)
  unset(PS3_SELF_WORK_ELF)
  unset(PS3_SELF_PACKAGE_ELF)
  unset(PS3_SELF_FILE)
  unset(PS3_FSELF_FILE)

endmacro()