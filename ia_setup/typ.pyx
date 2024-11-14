import sys
from typing import Callable

if sys.version_info < (3, 10):
	from typing_extensions import ParamSpec
	from typing_extensions import TypeAlias
	from typing_extensions import TypeVar
else:
	from typing import ParamSpec
	from typing import TypeAlias
	from typing import TypeVar

T:TypeVar   = TypeVar('T')
P:ParamSpec = ParamSpec('P')

X: TypeVar = TypeVar('X')
Y: TypeVar = TypeVar('Y')
Z: TypeVar = TypeVar('Z')

Function: TypeAlias = Callable[P, T]
Wrapper : TypeAlias = Function
Decorator:TypeAlias = Callable[[Function,], Wrapper]

__author__:str = 'you.com' # NOQA
