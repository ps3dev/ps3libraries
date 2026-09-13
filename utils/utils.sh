#!/usr/bin/env bash
set -eo pipefail

PS3LIBRARIES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Install the PPU CMake toolchain into $PS3DEV so builds (and other projects)
# can pass CMAKE_TOOLCHAIN_FILE without repo-relative paths.
install_ps3_cmake_toolchain() {
    if [ -z "${PS3DEV:-}" ]; then
        echo "install_ps3_cmake_toolchain: PS3DEV is not set" >&2
        return 1
    fi
    mkdir -p "$PS3DEV/share/cmake"
    cp "$PS3LIBRARIES_ROOT/cmake/ps3dev.toolchain.cmake" \
        "$PS3DEV/share/cmake/ps3dev.toolchain.cmake"
}

# cmake_ppu [cmake args...]
# Adds the PPU toolchain and Release build type.
cmake_ppu() {
    cmake \
        -DCMAKE_TOOLCHAIN_FILE="$PS3DEV/share/cmake/ps3dev.toolchain.cmake" \
        -DCMAKE_BUILD_TYPE=Release \
        "$@"
}

# Extract an archive, with pv progress if available.
# Usage: extract <archive> [extra tar args...]
extract() {
    local archive="$1"
    shift

    if [ ! -f "$archive" ]; then
        echo "extract: not a file: $archive" >&2
        return 1
    fi

    local -a flag=()
    case "$archive" in
        *.tar.xz|*.txz)   flag=(-J) ;;
        *.tar.gz|*.tgz)   flag=(-z) ;;
        *.tar.bz2|*.tbz2) flag=(-j) ;;
        *.tar.zst)        flag=(--zstd) ;;
        *.tar)            flag=() ;;
        *)
            echo "extract: unknown archive type: $archive" >&2
            return 1
            ;;
    esac

    if command -v pv >/dev/null 2>&1; then
        pv -pterab "$archive" | tar "${flag[@]}" -xf - "$@"
    else
        echo "  (pv not found, extracting without progress)"
        tar "${flag[@]}" -xf "$archive" "$@"
    fi
}