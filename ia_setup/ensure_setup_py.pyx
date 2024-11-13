#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" create setup.py """

from pathlib             import Path

#from structlog           import get_logger

from .guess_project_name import guess_setup_py
from .guess_project_name import guess_project_dir

#logger = get_logger()

setup_src:str = '''
#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" setup.py for python """

from iasetup.setup_py import setup

if __name__ == '__main__':
	setup()

__author__:str = 'you.com' # NOQA
'''

#def guess_setup_py()->Path:
#	project_dir     :Path = guess_project_dir()
#	setup_py        :Path = project_dir / 'setup.py'
#	assert(setup_py.is_file() or (not setup_py.exists())), setup_py.resolve()
#	return setup_py

def create_setup_py(setup_src:str, clobber:bool,)->None:
	setup_py:Path = guess_setup_py()
	assert((not setup_py.exists()) or clobber), setup_py.resolve()

	#logger.info('write setup.py: %s', setup_py,)
	with setup_py.open('w',) as f:
		f.write(setup_src)
	assert setup_py.is_file(), setup_py.resolve()
	#logger.info('wrote setup.py: %s', setup_py)
	# TODO sanity check

def ensure_setup_py(setup_src:str=setup_src, clobber:bool=False,)->bool:
	setup_py:Path = guess_setup_py()
	if((not setup_py.is_file()) or clobber):
		#if(setup_py.exists() and clobber):
			#logger.warn('clobbering setup.py: %s', setup_py,)
		create_setup_py(setup_src=setup_src, clobber=clobber,)
		return True
	assert setup_py.is_file(), setup_py.resolve()
	#logger.info('setup.py exists: %s', setup_py)
	return False

#if __name__ == '__main__':
#	setup_py:Path = guess_setup_py()
#	print('setup.py:', setup_py)
#
#	result  :bool = ensure_setup_py()
#	print('created :', result)

__author__:str = 'you.com' # NOQA
