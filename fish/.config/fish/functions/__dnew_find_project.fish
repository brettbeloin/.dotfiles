function __dnew_find_project --description 'Internal: locate the nearest dnew solution + its main project. Prints sln_file, main_proj, root on 3 lines.'
    # Walk up from cwd looking for the solution; check the directory itself
    # and one level of subdirectories at each step, since the .sln may sit
    # either at the root or inside the project's own subfolder.
    set -l sln_dir (realpath (pwd))
    set -l sln_file
    while test -n "$sln_dir"
        set sln_file (find $sln_dir -maxdepth 2 \( -name "*.sln" -o -name "*.slnx" \) | head -n 1)
        if test -n "$sln_file"
            break
        end
        if test "$sln_dir" = "/"
            break
        end
        set sln_dir (dirname $sln_dir)
    end

    if test -z "$sln_file"
        echo "no .sln/.slnx found in the current directory, its parents, or an immediate subdirectory" >&2
        return 1
    end

    set -l sln_container (realpath (dirname $sln_file))
    set -l root
    set -l main_proj (find $sln_container -maxdepth 1 -name "*.csproj" | head -n 1)

    if test -n "$main_proj"
        # sln sits alongside the project itself (--sln-in-project layout)
        set root (realpath (dirname $sln_container))
    else
        # sln sits at the root; the project is one level down in its own subfolder
        set root $sln_container
        set -l candidates (find $root -mindepth 2 -maxdepth 2 -name "*.csproj")
        set -l filtered
        for c in $candidates
            set -l parent (basename (dirname $c))
            if not string match -q "*.Tests" $parent
                set filtered $filtered $c
            end
        end
        if test (count $filtered) -ne 1
            echo "could not auto-detect a single main project under $root" >&2
            return 1
        end
        set main_proj $filtered[1]
    end

    echo $sln_file
    echo $main_proj
    echo $root
end
