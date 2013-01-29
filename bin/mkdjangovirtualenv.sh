#!/usr/bin/env bash

#
# A function to create and custom tailor a virtualenv for an
# existing Django project (using virtualenvwrapper)
#
# *   Set the DJANGO_SETTINGS_MODULE and PYTHONPATH in postactivate
# *   Set the project directory in the .project file
# *   Install pip requirements if there's a requirements.txt file
# *   Install git submodules if a git repo with submodules
#
# Source this file or copy it into a startup script, and
# see usage info by running `mkdjangovirtualenv -h`
#
# Alternatively, `pip install mkdjangovirtualenv` and use:
# `mkdjangovirtualenv` in the same way.
#

function mkdjangovirtualenv {
    _settings='project.settings'
    _env_name=
    _collect_path=
    _workon_home="$WORKON_HOME";
    if [ "$_workon_home" = "" ]; then
        _workon_home="~/.virtualenvs"
    fi

    die () {
        if [ $# != 0 ]; then
            echo >&2 "$@"
            echo
        fi
        echo "Usage: source mkdjangovirtualenv [--settings DJANGO__settings_MODULE]"\
         "ENV_NAME [PROJECT_DIRECTORY]"
        echo
        echo " --settings DJANGO_SETTINGS_MODULE"
        echo
        echo "    Provide a python import path for the settings file."
        echo "    Defaults to ${_settings}"
        echo
        return 0
    }

    ## parse args
    until [ -z "$1" ]; do
        case $1 in
            --settings|-s )
                shift
                _settings=$1
                ;;
            --help|-h )
                die && return 1
                ;;
            -* )
                die "Unrecognized option: $1" && return 1
                ;;
            * )
                if [ ! $_env_name ]; then
                    _env_name=$1
                elif [ ! $_collect_path ]; then
                    _collect_path=$1
                else
                    die "Invalid number of arguments." && return 1
                fi
                ;;
        esac
        shift
        if [ "$#" = "0" ]; then break; fi
    done

    if [ ! $_collect_path ]; then _collect_path=`pwd`; fi
    if [ ! $_env_name ]; then
        die "You must specify the name of your environment." && return 1
    fi


    ## make sure we're not in another virtualenv
    deactivate > /dev/null 2>&1


    ## try to load virtualenvwrapper if we don't have access to it
    if [ "`type -t mkvirtualenv`" != function ]; then
        _wrapper_locations="
/usr/local/share/python/virtualenvwrapper.sh
/usr/local/bin/virtualenvwrapper.sh
/usr/bin/virtualenvwrapper.sh"
        _wrapper_success=
        for f in $_wrapper_locations; do
            if [ -e "$f" ]; then
                source $f || die "
[ERROR] running virtualenvwrapper.sh -- if you have a virtualenv enabled, run the \`deactivate\` command before calling this script." && return 1
                _wrapper_success=1
                break
            fi
        done
        if [ ! $_wrapper_success ]; then
            die "Unable to find virtualenvwrapper.sh in the standard locations:\
            ${_wrapper_locations}" && return 1
        fi
    fi


    ## start from the proper directory
    cd $_collect_path


    ## create virtual env
    echo
    echo "## setting up virtualenv: ${_env_name}"
    echo
    mkvirtualenv -a `pwd` $_env_name || die "Unable to create virtualenv with name ${_env_name}" && return 1


    ## set DJANGO_SETTINGS_MODULE and PYTHONPATH in postactivate
    echo "export DJANGO_SETTINGS_MODULE=\"${_settings}\"
export PYTHONPATH=`pwd`" >> $_workon_home/$_env_name/bin/postactivate
    source $_workon_home/$_env_name/bin/postactivate


    ## try to install requirements - separate from [-r requirements_file]
    if [ -e "requirements.txt" ]; then
        echo
        echo "## installing pip requirements"
        echo
        pip install -r requirements.txt
        if (( $? )); then echo "Error installing requirements..."; fi
    fi


    ## try to pull down submodules
    git status > /dev/null 2>&1
    if [ $? == 0 ]; then
        echo
        echo "## checking for submodules"
        echo
        git submodule init
        git submodule update
    fi


    ## print out results

    echo "------------------------------------------------------------"
    echo "- Success                                                  -"
    echo "------------------------------------------------------------"
    echo

    _tpath=$_workon_home/$_env_name/.project
    echo
    echo "##"
    echo "## new project path (${_tpath}):"
    echo "##"
    echo
    cat $_tpath

    _tpath=$_workon_home/$_env_name/bin/postactivate
    echo
    echo "##"
    echo "## postactivate script (${_tpath}):"
    echo "##"
    echo
    cat $_tpath

    echo
    echo "##"
    echo "## Work on your project with..."
    echo "##"
    echo
    echo "workon ${_env_name}"
    echo

    return 0
}
