#!/usr/bin/env python3

import sys

from argparse import ArgumentParser
from os import chdir, path, system, environ
from time import time

class cmdError(Exception):
	pass

def gitFetch(src):
	cmd = "git -C %s fetch --tags --prune --prune-tags" % src
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def gitCheckout(version):
	cmd = "git -C app/src checkout %s" % version
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def appBuildTag(version):
	try:
		return version.split('/')[1]
	except IndexError:
		return version

def build(target):
	cmd = "make %s" % target
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def publish(target):
	cmd = "make publish-%s" % target
	rc = system(cmd)
	if rc != 0:
		raise cmdError(rc)

def main():
	flags = ArgumentParser(description = 'uws meteor apps build tools')
	flags.add_argument('version', metavar = 'X.Y.Z')
	flags.add_argument('--src', metavar = 'app', default = 'app/src',
		help = 'source app')
	flags.add_argument('--target', metavar = 'app', default = 'app',
		help = 'target app')
	flags.add_argument('--test-flags', metavar = 'flag', default = '',
		help = 'test flags')

	args = flags.parse_args()

	workdir = path.abspath(path.dirname(__file__))
	try:
		chdir(workdir)
	except FileNotFoundError as err:
		print("chdir: %s" % err, file = sys.stderr)
		return 1

	t_start = time()
	try:
		gitFetch(args.src)
		gitCheckout(args.version)
		environ['APP_BUILD_TAG'] = appBuildTag(args.version)
		build(args.target)
		publish(args.target)
	except cmdError as err:
		print('Build', args.target, 'version', args.version, 'failed!', file = sys.stderr)
		return err.args[0]

	print('Build', args.target, 'version', args.version, ', done in', "%fs" % (time() - t_start))
	return 0

if __name__ == '__main__':
	sys.exit(main())
