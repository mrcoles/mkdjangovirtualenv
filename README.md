===================================================
An enhancement for mkvirtualenv and django projects
===================================================

Performs the command `mkvirtualenv ENV_NAME`, but also:

*   sets the directory to jump to when the virtualenv is activated
*   sets the PYTHONPATH and DJANGO_SETTINGS_MODULE in the postactivate hook
*   auto-installs dependencies if there is a requirements.txt file
*   auto-inits git submodules if there are any

This is intended to save environment setup busywork after pulling down a django project from github.

*This does not run django-admin.py startproject, instead it is for configuring the environment for an existing django project. If you are looking for a way to create an empty django project with virtualenvwrapper, check out the [virtualenvwrapper.django template plugin for virtualenvwrapper](http://www.doughellmann.com/projects/virtualenvwrapper.django/).*


Usage
-----

    mkdjangovirtualenv [--settings DJANGO_SETTINGS_MODULE] ENV_NAME [PROJECT_DIRECTORY]


Options
-------

    --settings DJANGO_SETTINGS_MODULE

        Provide a python import path for the settings file.
        Defaults to project.settings

    ENV_NAME

        The name for the virtualenv

    PROJECT_DIRECTORY

        Provide a path to the root of the project. May be a
        relative path, defaults the current working directory.


Installation
------------

    sudo pip install mkdjangovirtualenv

This will pull down the latest copy of the scripts from PYPI and place them in your path. You can then run the `mkdjangovirtualenv` script directly.

For the best expierence, source the `mkdjangovirtualenv.sh` file just after your source `virtualenvwrapper.sh` in your startup scripts. For example, my `~/.bash_profile` has:

    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    source /usr/local/bin/mkdjangovirtualenv.sh

The benefit of this approach is that it makes it a bash function instead of a script, so it will actually activate the new virualenv for you, whereas the script would have needed to be run with `source` to have the same affect.
