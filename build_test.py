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

class TestBuild(unittest.TestCase):

	def setUp(self):
		system_mock()

	def test_gitFetch(self):
		build.gitFetch('testing/src')
		build.system.assert_called_with('git -C testing/src fetch --tags --prune --prune-tags')

	def test_gitCheckout(self):
		build.gitCheckout('testing/src', '0.999')
		build.system.assert_called_with('git -C testing/src checkout 0.999')

	def test_appBuildTag(self):
		build.appBuildTag('testing/src')
		build.getstatusoutput.assert_called_with('git -C testing/src describe --tags --always')

	def test_make(self):
		build.make('testing')
		build.system.assert_called_with('make testing')

	def test_build(self):
		build.build()
		build.system.assert_called_with('make deploy')

	def test_publish(self):
		build.publish('testing')
		build.system.assert_called_with('make publish-testing')

	def test_cmdError(self):
		with system_error(999):
			# git fetch
			with self.assertRaises(build.cmdError) as e:
				build.gitFetch('testing/src')
			err = e.exception
			self.assertEqual(err.args[0], 999)
			# git checkout
			with self.assertRaises(build.cmdError) as e:
				build.gitCheckout('testing/src', '0.999')
			err = e.exception
			self.assertEqual(err.args[0], 999)
			# git describe tags
			with self.assertRaises(build.cmdError) as e:
				build.appBuildTag('testing/src')
			err = e.exception
			self.assertEqual(err.args[0], 999)
			# make
			with self.assertRaises(build.cmdError) as e:
				build.make('testing.error')
			err = e.exception
			self.assertEqual(err.args[0], 999)
			# build
			with self.assertRaises(build.cmdError) as e:
				build.build()
			err = e.exception
			self.assertEqual(err.args[0], 999)
			# publish
			with self.assertRaises(build.cmdError) as e:
				build.publish('testing.error')
			err = e.exception
			self.assertEqual(err.args[0], 999)

	def test_main_no_args(self):
		with self.assertRaises(SystemExit) as e:
			build.main(argv = [])
		err = e.exception
		self.assertEqual(err.args[0], 2)

	def test_main(self):
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
