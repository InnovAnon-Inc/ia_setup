#! /usr/bin/env python
# cython: language_level=3
# distutils: language=c++

"""
guess project name
(assumes standard file tree structure)
"""

import os
from pathlib   import Path
from typing    import Iterable, Optional, List

#from structlog import get_logger

#logger = get_logger()

def normalize_project_name(project_name:str)->str:
	normalized:str = project_name.replace('-', '_')
	return normalized

def guess_project_dir()->Path:
	project_dir :Path             = Path()
	project_dir                   = project_dir.resolve()
	assert project_dir.is_dir()
	return project_dir

def guess_project_name()->str:
	project_dir :Path             = guess_project_dir()
	project_name:str              = project_dir.name
	project_name                  = normalize_project_name(project_name,)
	return project_name

#	project_str :Optional[str]    = os.getenv('IA_PROJECT_DIR', None)
#	project_dir :Path
#	if(project_str is None):
#		project_dir           = Path('.')
#	else:
#		project_dir           = Path(project_str)
#	assert project_dir.is_dir(), project_dir.resolve()
#
#	project_dir                   = project_dir.resolve()
#	assert project_dir.is_dir(), project_dir.resolve()
#	assert(str(project_dir) != '.'), str(project_dir)
#
#	project_str                   = str(project_dir)
#	if('IA_PROJECT_DIR' not in os.environ):
#	#	logger.info('setenv %s = %s', 'IA_PROJECT_DIR', project_str)
#		pass
#	elif(os.environ['IA_PROJECT_DIR'] == project_str):
#		assert isinstance(project_dir,Path)
#		return project_dir
#	else:
#		assert('IA_PROJECT_DIR' in os.environ)
#		assert(os.environ['IA_PROJECT_DIR'] != project_dir)
#		#logger.info('overwrite env: %s = %s', 'IA_PROJECT_DIR', project_str)
#	#os.environ['IA_PROJECT_DIR']  = project_str
#	#assert(os.environ['IA_PROJECT_DIR'] == project_str)
#	assert isinstance(project_dir,Path)
#	return project_dir

def guess_project_name()->str:
	project_name:Optional[str]    = os.getenv('IA_PROJECT_NAME', None)
	if(project_name is not None):
		assert project_name, project_name
		return project_name

	project_dir :Path             = guess_project_dir()
	project_name:str              = project_dir.stem
	assert project_name, project_name

	project_name                  = normalize_project_name(project_name=project_name,)
	assert project_name, project_name

	#logger.info('setenv %s = %s', 'IA_PROJECT_NAME', project_name,)
	os.environ['IA_PROJECT_NAME'] = project_name
	return project_name

def guess_author()->str:
	author      :Optional[str]    = os.getenv('IA_AUTHOR', None)
	if(author is None):
		author:str            = 'you.com'
	assert author, author

	#logger.info('setenv %s = %s', 'IA_AUTHOR', author,)
	os.environ['IA_AUTHOR']       = author
	return author

##
#
##

def _guess_project(name:str,)->Path:
	project_dir     :Path = guess_project_dir()
	project_file    :Path = project_dir / name
	assert isinstance(project_file,Path)
	return project_file

def _guess_project_file(filename:str,)->Path:
	project_file    :Path = _guess_project(name=filename,)
	assert(project_file.is_file() or (not project_file.exists())), project_file.resolve()
	return project_file

def _guess_project_dir(dirname:str,)->Path:
	project_dir    :Path = _guess_project(name=dirname,)
	assert(project_dir.is_dir() or (not project_dir.exists())), project_dir.resolve()
	return project_dir

def guess_setup_py()->Path:
	return _guess_project_file('setup.py')

def guess_requirements_txt()->Path:
	return _guess_project_file('requirements.txt')

# TODO guess_modules_gitignore()
def guess_gitignore()->Path:
	return _guess_project_file('.gitignore')

def guess_dockerignore()->Path:
	dockerignore    :Path = _guess_project(name='.dockerignore',)
	assert(dockerignore.is_symlink() or dockerignore.is_file() or (not dockerignore.exists())), dockerignore.resolve()
	return dockerignore

def guess_build()->Path:
	return _guess_project_dir(dirname='build',)

def guess_dist()->Path:
	return _guess_project_dir(dirname='dist',)

##
#
##

def _glob_project(pattern:str,)->List[Path]:
	project_dir     :Path           = guess_project_dir()
	results         :Iterable[Path] = project_dir.glob(pattern,)# recurse_symlinks=False,)
	results                         = list(results)
	assert all([isinstance(result,Path)
	            for result in results])
	return results

def _glob_project_files(pattern:str,)->List[Path]:
	results         :List[Path]     = _glob_project(pattern=pattern,)
	assert all([result.is_file() for result in results]), results
	return results

def _glob_project_dirs(pattern:str,)->List[Path]:
	results         :List[Path]     = _glob_project(pattern=pattern,)
	assert all([result.is_dir() for result in results]), results
	return results

def guess_egg_info()->List[Path]:
	return _glob_project_dirs('*.egg-info/')

def guess_spec()->List[Path]:
	return _glob_project_files('*.spec',)

##
#
##

#def guess_modules()->List[Path]:
#	project_dirs    :List[Path]     = _glob_project_dirs('*/',)
#
#	build_dir       :Path           = guess_build()
#	assert(build_dir in project_dirs), project_dirs
#	project_dirs.remove(build_dir,)
#	
#	dist_dir        :Path           = guess_dist()
#	assert(dist_dir in project_dirs), project_dirs
#	project_dirs.remove(build_dir,)
#
#	return project_dirs
#
#def _guess_init_py(module_dir:Path,)->Path:
#	init_py    :Path = module_dir / '__init__.py'
#	assert ((not init_py.exists()) or init_py.is_file() or init_py.is_symlink()), init_py.resolve()
#	return init_py
#
#def guess_init_py()->List[Path]:
#	module_dirs     :List[Path]      = guess_modules()
#	init_py    :Iterable[Path]  = map(_guess_init_py, module_dirs)
#	assert all([file.is_file() for file in init_py]), init_py.resolve()
#	return init_py

#def guess_scripts()->List[Path]:

##
#
##

def guess_hook_name()->str:
	project_name:str  = guess_project_name()
	hook_name   :str  = str(f'hook-{project_name}.py')

	project_dir :Path = guess_project_dir()
	hook_path   :Path = project_dir / hook_name
	assert hook_path.is_file()
	return hook_name

def guess_hook_dir()->Path:
	project_dir :Path = guess_project_dir()
	assert guess_hook_name()
	return project_dir

def guess_app_name()->str:
	project_name:str  = guess_project_name()
	app_name    :str  = str(f'main-{project_name}.py')

	project_dir :Path = guess_project_dir()
	app_path    :Path = project_dir / app_name
	assert app_path.is_file()
	return app_name

def guess_app_dir()->Path:
	project_dir :Path = guess_project_dir()
	assert guess_app_name()
	return project_dir

#if __name__ == '__main__':
#
#	project_dir :Path = guess_project_dir()
#	print('project dir :', project_dir)
#
#	project_name:str  = guess_project_name()
#	print('project name:', project_name)

__author__:str = 'you.com' # NOQA
