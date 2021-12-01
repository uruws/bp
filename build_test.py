#!/usr/bin/env python3

# Copyright (c) Jeremías Casteglione <jeremias@talkingpts.org>
# See LICENSE file.

import unittest
from unittest.mock import MagicMock, call

import build

def system_mock():
	build.system = MagicMock(return_value = 0)
	build.getstatusoutput = MagicMock(return_value = (0, 'FAKE_TAG'))

from contextlib import contextmanager

@contextmanager
def system_error(status):
	try:
		build.system = MagicMock(return_value = status)
		build.getstatusoutput = MagicMock(return_value = (status, 'FAKE_TAG'))
		yield
	finally:
		system_mock()

@contextmanager
def mock_environ():
	try:
		build.environ['BUILDPACK_TESTING'] = '1'
		yield
	finally:
		del build.environ['BUILDPACK_TESTING']

class Test(unittest.TestCase):

	def setUp(t):
		system_mock()

	def test_gitFetch(t):
		build.gitFetch('testing/src')
		build.system.assert_called_with('git -C testing/src fetch --tags --prune --prune-tags')
		with mock_environ():
			t.assertIsNone(build.gitFetch('testing/src'))

	def test_gitCheckout(t):
		build.gitCheckout('testing/src', '0.999')
		build.system.assert_called_with('git -C testing/src checkout 0.999')
		with mock_environ():
			t.assertIsNone(build.gitCheckout('testing/src', '0.999'))

	def test_appBuildTag(t):
		build.appBuildTag('testing/src')
		build.getstatusoutput.assert_called_with('git -C testing/src describe --tags --always')

	def test_make(t):
		build.make('testing')
		build.system.assert_called_with('make testing')

	def test_build(t):
		build.build()
		build.system.assert_called_with('make deploy')

	def test_publish(t):
		build.publish('testing')
		build.system.assert_called_with('make publish-testing')

	def test_cmdError(t):
		with system_error(999):
			# git fetch
			with t.assertRaises(build.cmdError) as e:
				build.gitFetch('testing/src')
			err = e.exception
			t.assertEqual(err.args[0], 999)
			# git checkout
			with t.assertRaises(build.cmdError) as e:
				build.gitCheckout('testing/src', '0.999')
			err = e.exception
			t.assertEqual(err.args[0], 999)
			# git describe tags
			with t.assertRaises(build.cmdError) as e:
				build.appBuildTag('testing/src')
			err = e.exception
			t.assertEqual(err.args[0], 999)
			# make
			with t.assertRaises(build.cmdError) as e:
				build.make('testing.error')
			err = e.exception
			t.assertEqual(err.args[0], 999)
			# build
			with t.assertRaises(build.cmdError) as e:
				build.build()
			err = e.exception
			t.assertEqual(err.args[0], 999)
			# publish
			with t.assertRaises(build.cmdError) as e:
				build.publish('testing.error')
			err = e.exception
			t.assertEqual(err.args[0], 999)

	def test_main_no_args(t):
		with t.assertRaises(SystemExit) as e:
			build.main(argv = [])
		err = e.exception
		t.assertEqual(err.args[0], 2)

	def test_main(t):
		build.main(argv = [
			'--src', 'testing/src',
			'--target', 'testing',
			'--version', '0.999',
		])
		calls = [
			call('git -C testing/src fetch --tags --prune --prune-tags'),
			call('git -C testing/src checkout 0.999'),
			call('make testing'),
			call('make deploy'),
			call('make publish-testing'),
		]
		build.system.assert_has_calls(calls)

if __name__ == '__main__':
	unittest.main()
