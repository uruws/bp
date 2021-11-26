#!/bin/sh
set -eu

cd ${HOME}/tmp

rm -f .coverage

echo '*** /srv/deploy/Buildpack/build_test.py'
python3-coverage run /srv/deploy/Buildpack/build_test.py "$@"

covd=${HOME}/tmp/htmlcov
rm -rf ${covd}

python3-coverage report
python3-coverage html -d ${covd}

exit 0
