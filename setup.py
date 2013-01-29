from distutils.core import setup

setup(
    name='mkdjangovirtualenv',
    version='0.0.5',
    description='A django-specific enhancement to virtualenvwrapper\'s mkvirtualenv function to setup the settings and pythonpath variables, auto-install requirements, set the project path, and install git modules if possible.',
    author='Peter Coles',
    author_email='peter@mrcoles.com',
    url='https://github.com/mrcoles/mkdjangovirtualenv',
    scripts=['bin/mkdjangovirtualenv', 'bin/mkdjangovirtualenv.sh'],
    classifiers=[
        'Programming Language :: Python',
        'License :: OSI Approved :: MIT License',
        'Development Status :: 3 - Alpha',
        'Operating System :: MacOS :: MacOS X',
        'Operating System :: Unix',
        'Intended Audience :: Developers',
        'Topic :: Text Processing',
        'Topic :: Software Development :: Libraries :: Python Modules',
        ],
    )
