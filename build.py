#!/usr/bin/env python3

import sys

from argparse import ArgumentParser
from os import chdir, path, system, environ
from subprocess import getstatusoutput
from time import time

app = {
	'app': {'src': 'app/src'},
	'beta': {'src': 'beta/src'},
	'cs': {'src': 'cs/src', 'target': 'crowdsourcing'},
}

class cmdError(Exception):
	pass

def gitFetch(src):
	if environ.get('BUILDPACK_TESTING', default = '0') == '1':
		return None
	cmd = "git -C %s fetch --tags --prune --prune-tags" % src
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def gitCheckout(src, version):
	if environ.get('BUILDPACK_TESTING', default = '0') == '1':
		return None
	cmd = "git -C %s checkout %s" % (src, version)
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def appBuildTag(src):
	cmd = "git -C %s describe --tags --always" % src
	rc, out = getstatusoutput(cmd)
	if rc != 0:
		print(out, file = sys.stderr)
		raise cmdError(rc)
	try:
		return out.split('/')[1]
	except IndexError:
		return out

def make(target):
	cmd = "make %s" % target
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def build():
	cmd = "make deploy"
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def publish(target):
	cmd = "make publish-%s" % target
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def main():
	flags = ArgumentParser(description = 'meteor buildpack')
	flags.add_argument('--target', metavar = 'app', default = 'app',
		choices = sorted(app.keys()), required = True, help = 'target app')
	flags.add_argument('--version', metavar = 'X.Y.Z', required = True,
		help = 'app version/tag')
	flags.add_argument('test_flags', metavar = 'test flags', default = '',
		help = 'test flags', nargs = '*')

	args = flags.parse_args()

	workdir = path.abspath(path.dirname(__file__))
	try:
		chdir(workdir)
	except FileNotFoundError as err:
		print("chdir: %s" % err, file = sys.stderr)
		return 1

	src = app[args.target]['src']
	target = app[args.target].get('target', args.target)

	t_start = time()
	try:
		gitFetch(src)
		gitCheckout(src, args.version)
	except cmdError as err:
		print('Fetch', src, 'version', args.version, 'failed!', file = sys.stderr)
		return 2

	try:
		environ['APP_NAME'] = target
		environ['APP_BUILD_TAG'] = appBuildTag(src)
		environ['TEST_FLAGS'] = ' '.join(args.test_flags)
		make(target)
		build()
	except cmdError as err:
		print('Build', target, 'version', args.version, 'failed!', file = sys.stderr)
		return 3

	try:
		publish(target)
	except cmdError as err:
		print('Publish', target, 'version', args.version, 'failed!', file = sys.stderr)
		return 4

	print('Build', target, 'version', args.version, ', done in', "%fs" % (time() - t_start))
	return 0

if __name__ == '__main__':
	sys.stdout.reconfigure(line_buffering = False)
	sys.stderr.reconfigure(line_buffering = False)
	sys.exit(main())
