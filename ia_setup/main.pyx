#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" setup.py """

from pathlib           import Path
import os
import sys
from   typing          import Dict, Optional, TypeAlias

#import docopt
#import dotenv
#from   pid.decorator   import pidfile
#from   structlog       import get_logger

#from .build_app        import pyinstaller
#from .ensure_setup_py  import ensure_setup_py
#from .ensure_setup_pyx import ensure_setup_pyx
#from .err              import KillSwitchException
from .pip_install      import pip_v1, pip_v2
from .typ              import P

#logger         = get_logger()

#def ensure_setup(clobber:bool, use_cython:bool,)->None:
#	if use_cython:
#		ensure_setup_pyx(clobber=clobber,)
#		return
#	ensure_setup_py(clobber=clobber,)

def get_path(path:Optional[Path]=None,)->Path:
	if(path is None):
		project_str:str  = os.getenv('PROJECT_DIR', '.')
		path:Path = Path(project_str)
	assert isinstance(path,Path)
	path              = path.resolve()
	assert path.is_dir()
	assert(path.name != '.')
	return path

def main(
	*args      :P.args,
	path        :Optional[Path]=None,
	#clobber    :bool          =False,
	#use_cython :bool          =True,
	**kwargs   :P.kwargs,
)->None:
	#dotenv.load_dotenv()

	path       :Path = get_path(path=path,)
	#logger.info('project dir: %s', path)

	#if(clobber is None):
	#	clobber   :bool = bool(os.getenv('CLOBBER', False))
	#if(use_cython is None):
	#	use_cython:bool = bool(os.getenv('USE_CYTHON', True))

	#ensure_setup(clobber=clobber, use_cython=use_cython,)

	#if use_wheels:
	#	pip_v2(wheel_dir, cwd=path,)
	#else:
	pip_v1(cwd=path,)

__author__:str = 'you.com' # NOQA
