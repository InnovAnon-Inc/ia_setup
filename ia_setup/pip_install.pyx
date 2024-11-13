#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" setup.py for python """

import os
from pathlib             import Path
import subprocess
from typing              import List, Optional, Iterable

#from structlog           import get_logger

from .guess_project_name import guess_dist
from .guess_project_name import guess_project_name
from .guess_project_name import guess_project_dir
from .typ                import P

#logger = get_logger()

##
#
##

def pip_helper(
	mode:str,
	is_remote:bool,
	is_requirements:bool,
	*args:P.args, **kwargs:P.kwargs,
)->None:
	_args:List[str] = [ 'pip', mode, '--no-input', ]
	if is_remote:
		_args.extend(['--retries', '30', '--timeout', '1200',])
	if is_requirements:
		_args.extend(['-r', 'requirements.txt',])
	subprocess.check_call([*_args, *args,], **kwargs,)

def pip_install(*args:str, **kwargs:P.kwargs,)->None:
	pip_helper('install', *args, **kwargs,)

def pip_wheel(mode:str, wheel_dir:Path, *args:str, **kwargs:P.kwargs,)->None:
	pip_helper('wheel', mode, str(wheel_dir), *args, **kwargs,)

def pip_wheel_build(wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	pip_wheel('--wheel-dir', wheel_dir, *args, **kwargs,)

def pip_wheel_install(wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	pip_helper('--find-links', wheel_dir, *args, **kwargs,)

def pip_install_requirements_v1(*args:P.args, **kwargs:P.kwargs)->None:
	""" pip install -r requirements.txt """
	pip_install(True, True, *args, **kwargs,)

def pip_install_dot_v1(*args:P.args, **kwargs:P.kwargs)->None:
	""" pip install . """
	pip_install(False, False, '.', *args, **kwargs,)

def pip_wheel_requirements(wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	""" pip wheel --wheel-dir {wheel_dir} -r requirements.txt """
	pip_wheel_build(wheel_dir, True, True, *args, **kwargs,)

def pip_wheel_dot(wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	""" pip wheel --wheel-dir {wheel_dir} . """
	pip_wheel_build(wheel_dir, False, False, *args, **kwargs,)

def pip_install_requirements_v2(wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	""" pip install --find-links {wheel_dir} -r requirements.txt """
	pip_wheel_install(wheel_dir, False, True, *args, **kwargs,)

def pip_install_dot_v2(wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	""" pip install --find-links {wheel_dir} . """
	pip_wheel_install(wheel_dir, False, False, '.', *args, **kwargs,)

##
#
##

def pip_v1(*args:P.args, **kwargs:P.kwargs,)->None:
	pip_install_requirements_v1(*args, **kwargs,)
	pip_install_dot_v1         (*args, **kwargs,)

def pip_v2_build              (wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	pip_wheel_requirements(wheel_dir, *args, **kwargs,)
	pip_wheel_dot         (wheel_dir, *args, **kwargs,)

def pip_v2_install                 (wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	pip_install_requirements_v2(wheel_dir, *args, **kwargs,)
	pip_install_dot_v2         (wheel_dir, *args, **kwargs,)

def pip_v2            (wheel_dir:Path, *args:P.args, **kwargs:P.kwargs,)->None:
	pip_v2_build  (wheel_dir, *args, **kwargs,)
	pip_v2_install(wheel_dir, *args, **kwargs,)

__author__:str = 'you.com' # NOQA
