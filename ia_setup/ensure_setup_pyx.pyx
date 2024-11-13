#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" create setup.py """

from pathlib          import Path

from .ensure_setup_py import ensure_setup_py

setup_src:str = '''
#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" setup.py for Cython """

from iacython.setup_pyx import setup

if __name__ == '__main__':
	setup()

__author__:str = 'you.com' # NOQA
'''

def ensure_setup_pyx(setup_src:str=setup_src, clobber:bool=False,)->bool:
	return ensure_setup_py(setup_src=setup_src, clobber=clobber,)

#if __name__ == '__main__':
#	result:bool = ensure_setup_py()
#	print('created:', result)

__author__:str = 'you.com' # NOQA
