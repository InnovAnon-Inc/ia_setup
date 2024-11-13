#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" setup.py for python """

from typing              import Any, Dict, List

from setuptools          import find_packages
from setuptools          import setup as _setup

#from .ensure_setup_py    import ensure_setup_py
#from .guess_project_name import guess_project_name
#from .guess_project_name import guess_author
from .typ                import P

def setup(*args:P.args, clobber:bool=False, **kwargs:P.kwargs,)->None:
	#ensure_setup_py(clobber=clobber,)

	_kwargs                     :Dict[str,Any]       = dict(kwargs)

	#if('name'                 not in kwargs):
	#	_kwargs['name']                          = guess_project_name()
	#
	#if('author'               not in kwargs):
	#	_kwargs['author']                        = guess_author()

	if('packages'             not in kwargs):
		_kwargs['packages']                      = find_packages()

	if('exclude_package_data' not in kwargs):
		_kwargs['exclude_package_data']          = {
            		'': ['*.cpp', '*.pyx', 'hook-*.py', 'main-*.py', '__pycache__',] # '*.py',
        	}
	_setup(
		*args,
        	#package_dir         = {
            	#	project_name : project_name,
        	#},
        	#package_data        = {
            	#	'': ['*.so'],
        	#},
		**_kwargs, )

#if __name__ == '__main__':
#	setup()

__author__:str = 'you.com' # NOQA
