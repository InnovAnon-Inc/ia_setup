#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

""" PyInstaller """

import os
from pathlib             import Path
import subprocess
from typing              import List, Optional, Iterable

import PyInstaller.__main__
from structlog           import get_logger

from .guess_project_name import guess_dist
from .guess_project_name import guess_project_name
from .guess_project_name import guess_hook_dir
from .guess_project_name import guess_app_name

logger = get_logger()

def pyinstaller()->None:
	project_name:str       = guess_project_name()
	logger.info('project name: %s', project_name)

	hook_dir    :Path      = guess_hook_dir()
	logger.info('hook dir    : %s', hook_dir)

	app_name    :str       = guess_app_name()
	logger.info('app name    : %s', app_name)

	args        :List[str] = [
		'--onefile',
		'--additional-hooks-dir', str(hook_dir),
		'--name',                 project_name,
		app_name,
	]
	logger.info('pyinstaller : %s', args)
	PyInstaller.__main__.run(args,)

#if __name__ == '__main__':
#	pyinstaller()

__author__:str = 'you.com' # NOQA
