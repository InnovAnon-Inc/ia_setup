#! /usr/bin/env bash
set -euxo nounset -o pipefail
(( ! $# ))

[[ -f requirements.txt ]]
[[ -f setup.py ]]

pip install -r requirements.txt
pip install --force-reinstall .
