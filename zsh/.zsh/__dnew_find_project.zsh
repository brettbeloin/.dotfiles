            #------------------------------------------------------#
            #      _       _              _      __ _           _  #
            #   __| | ___ | |_ _ __   ___| |_   / _(_)_ __   __| | #
            #  / _` |/ _ \| __| '_ \ / _ \ __| | |_| | '_ \ / _` | #
            # | (_| | (_) | |_| | | |  __/ |_  |  _| | | | | (_| | #
            #  \__,_|\___/ \__|_| |_|\___|\__| |_| |_|_| |_|\__,_| #
            #                                                      #
            #------------------------------------------------------#

# Internal: locate the nearest dnew solution + its main project. Prints sln_file, main_proj, root on 3 lines.
__dnew_find_project() {
    # Walk up from cwd looking for the solution; check the directory itself
    # and one level of subdirectories at each step, since the .sln may sit
    # either at the root or inside the project's own subfolder.
    local sln_dir=$(realpath "$PWD")
    local sln_file=""
    while [[ -n "$sln_dir" ]]; do
        sln_file=$(find "$sln_dir" -maxdepth 2 \( -name "*.sln" -o -name "*.slnx" \) | head -n 1)
        if [[ -n "$sln_file" ]]; then
            break
        fi
        if [[ "$sln_dir" == "/" ]]; then
            break
        fi
        sln_dir=$(dirname "$sln_dir")
    done

    if [[ -z "$sln_file" ]]; then
        echo "no .sln/.slnx found in the current directory, its parents, or an immediate subdirectory" >&2
        return 1
    fi

    local sln_container=$(realpath "$(dirname "$sln_file")")
    local root
    local main_proj=$(find "$sln_container" -maxdepth 1 -name "*.csproj" | head -n 1)

    if [[ -n "$main_proj" ]]; then
        # sln sits alongside the project itself (--sln-in-project layout)
        root=$(realpath "$(dirname "$sln_container")")
    else
        # sln sits at the root; the project is one level down in its own subfolder
        root=$sln_container
        local -a candidates=(${(f)"$(find "$root" -mindepth 2 -maxdepth 2 -name "*.csproj")"})
        local -a filtered=()
        local c parent
        for c in $candidates; do
            parent=$(basename "$(dirname "$c")")
            if [[ "$parent" != *.Tests ]]; then
                filtered+=("$c")
            fi
        done
        if (( ${#filtered} != 1 )); then
            echo "could not auto-detect a single main project under $root" >&2
            return 1
        fi
        main_proj=${filtered[1]}
    fi

    echo "$sln_file"
    echo "$main_proj"
    echo "$root"
}


