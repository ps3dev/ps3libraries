cmake_minimum_required(VERSION 3.10)

# ---------------------------------------------------------------------------
# create_pkg_file
#
# Packages a PS3 ELF/SELF target into a signed .pkg.
#
# Usage:
#
#   add_executable(mygame main.c)
#   ps3_create_pkg_file(
#     TARGET     mygame
#     TITLE      "My Game"
#     APPID      "TEST00001"
#     CONTENTID  "UP0001-TEST00001_00-0000000000000000"
#     ICON0      "${CMAKE_SOURCE_DIR}/assets/ICON0.PNG"
#     SFOXML     "${CMAKE_SOURCE_DIR}/assets/sfo.xml"
#   )
#
# All arguments except TARGET are optional and fall back to sane defaults,
# matching the variables at the top of the original Makefile. Any of them
# can be overridden per-call, and PS3DEV-relative defaults can be
# overridden globally by setting the corresponding cache variable before
# calling the macro (e.g. -DPS3_DEFAULT_ICON0=... on the cmake command line).
# ---------------------------------------------------------------------------

set(PS3_DEFAULT_APPID     "TEST00001"                    CACHE STRING "Default PS3 APPID")
set(PS3_DEFAULT_ICON0     "$ENV{PS3DEV}/bin/ICON0.PNG"   CACHE FILEPATH "Default ICON0.PNG path")
set(PS3_DEFAULT_SFOXML    "$ENV{PS3DEV}/bin/sfo.xml"     CACHE FILEPATH "Default sfo.xml path")

set(MAKE_SELF_NPDRM_EXECUTABLE "$ENV{PS3DEV}/bin/make_self_npdrm")
set(SFO_EXECUTABLE          "$ENV{PS3DEV}/bin/sfo")
set(PKG_EXECUTABLE          "$ENV{PS3DEV}/bin/pkg")

macro(ps3_create_pkg_file)

  set(options)
  set(oneValueArgs
    TARGET       # required, defined by add_executable() before calling ps3_create_pkg_file
    TITLE        # optional, string, title shown in the PS3 XMB
    APPID        # optional, e.g. "TEST00001"
    CONTENTID    # optional, e.g. "UP0001-<APPID>_00-0000000000000000"
    ICON0        # optional, absolute path to ICON0.PNG
    SFOXML       # optional, absolute path to sfo.xml template
    OUTPUT_DIR   # optional, directory the final .pkg is written to
    OUTPUT_NAME  # optional, filename (without extension) of the final .pkg
  )
  set(multiValueArgs)


  cmake_parse_arguments(ARG "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if(NOT DEFINED ARG_TARGET)
    message(FATAL_ERROR "create_pkg_file: TARGET must be defined")
  endif()

  if(NOT TARGET ${ARG_TARGET})
    message(FATAL_ERROR "create_pkg_file: '${ARG_TARGET}' is not a defined CMake target (call add_executable() first)")
  endif()

  # ---- fill in defaults for anything not passed in --------------------
  if(NOT DEFINED ARG_TITLE)
    set(ARG_TITLE "${ARG_TARGET}")
  endif()

  if(NOT DEFINED ARG_APPID)
    set(ARG_APPID "${PS3_DEFAULT_APPID}")
  endif()

  if(NOT DEFINED ARG_CONTENTID)
    set(ARG_CONTENTID "UP0001-${ARG_APPID}_00-0000000000000000")
  endif()

  if(NOT DEFINED ARG_ICON0)
    set(ARG_ICON0 "${PS3_DEFAULT_ICON0}")
  endif()

  if(NOT DEFINED ARG_SFOXML)
    set(ARG_SFOXML "${PS3_DEFAULT_SFOXML}")
  endif()

  if(NOT DEFINED ARG_OUTPUT_DIR)
    set(ARG_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}")
  endif()

  if(NOT DEFINED ARG_OUTPUT_NAME)
    set(ARG_OUTPUT_NAME "${ARG_TARGET}")
  endif()

  set(PS3_PKG_STAGE_DIR "${CMAKE_CURRENT_BINARY_DIR}/${ARG_TARGET}.pkgdir")
  set(PS3_PKG_FILE      "${ARG_OUTPUT_DIR}/${ARG_OUTPUT_NAME}.pkg")
# Attached directly to the target's own build steps: runs every time
  # ${ARG_TARGET} is (re)built, right after it links, no separate
  # "_pkg" target to remember to invoke and no EXCLUDE_FROM_ALL surprises.
  add_custom_command(
    TARGET ${ARG_TARGET}
    POST_BUILD
 
    # fresh staging tree (mirrors `rm -Rf pkg && mkdir -p pkg/USRDIR`)
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${PS3_PKG_STAGE_DIR}"
    COMMAND ${CMAKE_COMMAND} -E make_directory   "${PS3_PKG_STAGE_DIR}/USRDIR"
 
    # cp $(ICON0) pkg
    COMMAND ${CMAKE_COMMAND} -E copy "${ARG_ICON0}" "${PS3_PKG_STAGE_DIR}/ICON0.PNG"
 
    # make_self_npdrm $< pkg/USRDIR/EBOOT.BIN $(CONTENTID)
    COMMAND "${MAKE_SELF_NPDRM_EXECUTABLE}"
            "$<TARGET_FILE:${ARG_TARGET}>"
            "${PS3_PKG_STAGE_DIR}/USRDIR/EBOOT.BIN"
            "${ARG_CONTENTID}"
 
    # sfo --title .. --appid .. -f sfo.xml pkg/PARAM.SFO
    COMMAND "${SFO_EXECUTABLE}"
            --title "${ARG_TITLE}"
            --appid "${ARG_APPID}"
            -f "${ARG_SFOXML}"
            "${PS3_PKG_STAGE_DIR}/PARAM.SFO"
 
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ARG_OUTPUT_DIR}"
 
    # pkg --contentid $(CONTENTID) pkg/ $@
    COMMAND "${PKG_EXECUTABLE}"
            --contentid "${ARG_CONTENTID}"
            "${PS3_PKG_STAGE_DIR}/"
            "${PS3_PKG_FILE}"
 
    # rm -Rf pkg
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${PS3_PKG_STAGE_DIR}"
 
    WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    COMMENT "Building PS3 package ${PS3_PKG_FILE}"
    VERBATIM
  )

  unset(PS3_PKG_STAGE_DIR)
  unset(PS3_PKG_FILE)

endmacro()