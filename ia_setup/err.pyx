#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" Error Types """

from structlog import get_logger

logger = get_logger()

class InnovationException(Exception):
	""" we dun gooft """

class KillSwitchException(Exception):
	""" shut it down! (the goyim know) """

#if __name__ == '__main__':
#	try:
#		raise InnovationException('testing')
#	except InnovationException as error:
#		logger.info(error)

__author__:str = 'you.com' # NOQA
