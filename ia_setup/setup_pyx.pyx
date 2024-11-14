#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" setup.py for Cython """

from pathlib             import Path
from typing              import Any, Dict, List

from Cython.Build        import cythonize
from setuptools          import Extension

#from .ensure_setup_py    import ensure_setup_py
#from .guess_project_name import guess_project_name
from .setup_py           import setup as _setup
from .typ                import P

def setup(*args:P.args, clobber:bool=False, **kwargs:P.kwargs,)->None:
	#ensure_setup_py(clobber=clobber,)

	_kwargs             :Dict[str,Any]      = dict(kwargs)
	#project_name        :str                = guess_project_name()

	#if('packages'    not in kwargs):
	#	_kwargs['packages']  = [project_name,]

	if('ext_modules' not in kwargs):
		#pyx_glob    :str                = str(f'{project_name}/*.pyx')
		pyx_glob    :str                = '*/*.pyx'
		extension_glob                  = Extension(
			'*',
			sources  =[ pyx_glob,],
            		language = "c++",)
		extensions  :List[Extension]    = [ extension_glob,]
		_kwargs['ext_modules']          = cythonize(
			extensions,
			compiler_directives={
				'language_level':  '3',
				#'embedsignature': True, # PyInstaller
			},)

	#if('package_dir'          not in kwargs):
	#	_kwargs['package_dir']          = {
	#		project_name : project_name,
	#	}

	if('package_data'         not in kwargs):
		_kwargs['package_data']         = {
            		'': ['*.so',],
        	}

	if('exclude_package_data' not in kwargs):
		_kwargs['exclude_package_data'] = {
			'': ['*.cpp', '*.pyx', '*.py', 'hook-*.py', 'main-*.py', '__pycache__', '.env',]
		}

	if('zip_safe'             not in kwargs): # PyInstaller
		_kwargs['zip_safe']             = False
	if('include_package_data' not in kwargs): # PyInstaller
		_kwargs['include_package_data'] = True

	_setup( *args, **_kwargs,)

#if __name__ == '__main__':
#	setup()

__author__:str = 'you.com' # NOQA
