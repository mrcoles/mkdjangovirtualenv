
An enhancement for mkvirtualenv and django projects
===================================================

Performs the command `mkvirtualenv ENV_NAME`, but also:

*   sets the directory to `cd` to when the virtualenv is activated
*   sets the PYTHONPATH and DJANGO_SETTINGS_MODULE in the postactivate hook
*   auto-installs from a requirements.txt file
*   auto-inits git submodules

Run this after pulling down a django project from git, and you’ll save yourself from a bunch of redundant busywork.

*This does not run django-admin.py startproject, instead it is for configuring the environment for an existing django project.* If you are looking for a way to create an empty django project with virtualenvwrapper, check out the [virtualenvwrapper.django template plugin for virtualenvwrapper](http://www.doughellmann.com/projects/virtualenvwrapper.django/).


### Usage

    source mkdjangovirtualenv [--settings DJANGO_SETTINGS_MODULE] ENV_NAME [PROJECT_DIRECTORY]

### Options

    --settings DJANGO_SETTINGS_MODULE

        Provide a python import path for the settings file.
        Defaults to project.settings

    ENV_NAME

        The name for the virtualenv

    PROJECT_DIRECTORY

        Provide a path to the root of the project. May be a
        relative path, defaults the current working directory.
