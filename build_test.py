#!/usr/bin/env python3

# Copyright (c) Jeremías Casteglione <jeremias@talkingpts.org>
# See LICENSE file.

import unittest
from unittest.mock import MagicMock

from os import environ
environ['BUILDPACK_TESTING'] = '1'

import build

build.system = MagicMock(return_value = 0)

class TestBuild(unittest.TestCase):

	def test_gitFetch(self):
		self.assertIsNone(build.gitFetch('testing'))

	def test_gitCheckout(self):
		self.assertIsNone(build.gitCheckout('testing', '999'))

	def test_appBuildTag(self):
		self.assertIsNotNone(build.appBuildTag('.'))
		# invalid source dir
		with self.assertRaises(build.cmdError) as e:
			build.appBuildTag('invalid')
		err = e.exception
		self.assertEqual(err.args[0], 128)

	def test_make(self):
		build.make('testing')
		build.system.assert_called_with('make testing')

	def test_build(self):
		build.build()
		build.system.assert_called_with('make deploy')

	def test_publish(self):
		build.publish('testing')
		build.system.assert_called_with('make publish-testing')

if __name__ == '__main__':
	unittest.main()
