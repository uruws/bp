#!/usr/bin/env python3

# Copyright (c) Jeremías Casteglione <jeremias@talkingpts.org>
# See LICENSE file.

import unittest
from unittest.mock import MagicMock

import build
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
		build.system = MagicMock(return_value = 0)
		build.getstatusoutput = MagicMock(return_value = (0, 'FAKE_TAG'))

class TestBuild(unittest.TestCase):

	def test_gitFetch(self):
		build.gitFetch('testing/src')
		build.system.assert_called_with('git -C testing/src fetch --tags --prune --prune-tags')

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

if __name__ == '__main__':
	unittest.main()
