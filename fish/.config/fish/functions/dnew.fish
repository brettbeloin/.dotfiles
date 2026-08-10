function dnew --description 'Scaffold a dotnet project + solution (dnew [template] [--sln-in-project]) or a linked xunit test project (dnew --test)'
    if test "$argv[1]" = "--test"
        set -l info (__dnew_find_project)
        if test $status -ne 0
            echo "dnew --test: $info" >&2
            return 1
        end
        set -l sln_file $info[1]
        set -l main_proj $info[2]
        set -l root $info[3]

        set -l ref_name (basename $main_proj .csproj)
        set -l test_name "$ref_name.Tests"
        set -l test_dir $root/$test_name

        dotnet new xunit -o $test_dir
        or return 1

        set -l test_proj $test_dir/$test_name.csproj

        dotnet add $test_proj reference $main_proj
        or return 1

        dotnet sln $sln_file add $test_proj
        or return 1

        echo "Created $test_proj"
        echo "  linked to  $main_proj"
        echo "  added to   $sln_file"
        return 0
    end

    set -l type console
    set -l sln_in_project 0

    for a in $argv
        if test "$a" = "--sln-in-project"
            set sln_in_project 1
        else
            set type $a
        end
    end

    set -l default_proj "$type"01

    read -l -P "Project name [$default_proj]: " projname
    if test -z "$projname"
        set projname $default_proj
    end

    read -l -P "Solution name [$projname]: " slnname
    if test -z "$slnname"
        set slnname $projname
    end

    set -l root (realpath (pwd))/$projname
    mkdir -p $root
    or return 1

    dotnet new $type -o $root/$projname
    or return 1

    set -l sln_target_dir $root
    if test $sln_in_project -eq 1
        set sln_target_dir $root/$projname
    end

    dotnet new sln -n $slnname -o $sln_target_dir
    or return 1

    set -l sln_path $sln_target_dir/$slnname.slnx
    if not test -f $sln_path
        set sln_path $sln_target_dir/$slnname.sln
    end

    dotnet sln $sln_path add $root/$projname/$projname.csproj
    or return 1

    echo "Created $root/$projname/$projname.csproj"
    echo "  solution   $sln_path"
end
