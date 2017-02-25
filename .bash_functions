
# editor
function xy() {
    XYZZY='/cygdrive/c/Tool/xyzzy/xyzzycli.exe'

    # convert path for windows
    declare -a args
    for arg in "$@"
    do
        args+=( $(cygpath -w -a "${arg}") )
    done

    for arg in "${args[@]}"
    do
        "${XYZZY}" "${arg}"
    done
}

# merge
function merge() {
    WINMERGE='/cygdrive/c/Program Files/WinMerge/WinMergeU.exe'

    # convert path for windows
    declare -a args
    for arg in "$@"
    do
        args+=( "$(cygpath -w -a "${arg}")" )
    done

    "${WINMERGE}" "${args[@]}" &
}

# explorer
function open() {
    EXPLORER='explorer.exe'

    # convert path for windows
    declare -a args
    if [[ $# -eq 0 ]] ; then
        args=( "$(cygpath -w -a .)" )
    else
        for arg in "$@"
        do
            args+=( "$(cygpath -w -a "${arg}")" )
        done
    fi

    "${EXPLORER}" "${args[@]}"
}
