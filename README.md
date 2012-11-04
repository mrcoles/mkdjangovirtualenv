
An enhancement for mkvirtualenv and django projects
===================================================

### Usage

    source mkdjangovirtualenv [--settings DJANGO__settings_MODULE] ENV_NAME [PROJECT_DIRECTORY]

### Options

    --settings DJANGO_SETTINGS_MODULE

        Provide a python import path for the settings file.
        Defaults to project.settings

    ENV_NAME

        The name for the virtualenv

    PROJECT_DIRECTORY

        Provide a path to the root of the project. May be a
        relative path, defaults the current working directory.


### Description

Performs the command `mkvirtualenv ENV_NAME`, but also sets up:

*   sets the directory to `cd` to when the virtualenv is activated
*   sets the PYTHONPATH and DJANGO_SETTINGS_MODULE in the postactivate hook
*   auto-installs from a requirements.txt file
*   auto-inits git submodules

Run this after pulling down a django project from git, and you’ll save yourself from a bunch of redundant busywork.
