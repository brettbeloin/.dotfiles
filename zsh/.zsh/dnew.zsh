           #--------------------------------------------------------#
           #      _       _              _                          #
           #   __| | ___ | |_ _ __   ___| |_   _ __   _____      __ #
           #  / _` |/ _ \| __| '_ \ / _ \ __| | '_ \ / _ \ \ /\ / / #
           # | (_| | (_) | |_| | | |  __/ |_  | | | |  __/\ V  V /  #
           #  \__,_|\___/ \__|_| |_|\___|\__| |_| |_|\___| \_/\_/   #
           #                                                        #
           #--------------------------------------------------------#

#dotnet project + solution (dnew [template] [--sln-in-project]) or a linked xunit test project (dnew --test)
dnew() {
    if [[ "$1" == "--test" ]]; then
        local out
        out=$(__dnew_find_project)
        if [[ $? -ne 0 ]]; then
            echo "dnew --test: $out" >&2
            return 1
        fi
        local -a info=(${(f)out})
        local sln_file=${info[1]}
        local main_proj=${info[2]}
        local root=${info[3]}

        local ref_name=$(basename "$main_proj" .csproj)
        local test_name="$ref_name.Tests"
        local test_dir="$root/$test_name"

        dotnet new xunit -o "$test_dir" || return 1

        local test_proj="$test_dir/$test_name.csproj"

        dotnet add "$test_proj" reference "$main_proj" || return 1

        dotnet sln "$sln_file" add "$test_proj" || return 1

        echo "Created $test_proj"
        echo "  linked to  $main_proj"
        echo "  added to   $sln_file"
        return 0
    fi

    local type=console
    local sln_in_project=0

    local a
    for a in "$@"; do
        if [[ "$a" == "--sln-in-project" ]]; then
            sln_in_project=1
        else
            type=$a
        fi
    done

    local default_proj="${type}01"

    local projname slnname
    read "projname?Project name [$default_proj]: "
    if [[ -z "$projname" ]]; then
        projname=$default_proj
    fi

    read "slnname?Solution name [$projname]: "
    if [[ -z "$slnname" ]]; then
        slnname=$projname
    fi

    local root="$(realpath "$PWD")/$projname"
    mkdir -p "$root" || return 1

    dotnet new "$type" -o "$root/$projname" || return 1

    local sln_target_dir=$root
    if [[ $sln_in_project -eq 1 ]]; then
        sln_target_dir="$root/$projname"
    fi

    dotnet new sln -n "$slnname" -o "$sln_target_dir" || return 1

    local sln_path="$sln_target_dir/$slnname.slnx"
    if [[ ! -f "$sln_path" ]]; then
        sln_path="$sln_target_dir/$slnname.sln"
    fi

    dotnet sln "$sln_path" add "$root/$projname/$projname.csproj" || return 1

    echo "Created $root/$projname/$projname.csproj"
    echo "  solution   $sln_path"
}


