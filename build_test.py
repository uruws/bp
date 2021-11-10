#!/usr/bin/env python3

# Copyright (c) Jeremías Casteglione <jeremias@talkingpts.org>
# See LICENSE file.

import unittest

from os import environ
environ['BUILDPACK_TESTING'] = '1'

import build

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

if __name__ == '__main__':
	unittest.main()
