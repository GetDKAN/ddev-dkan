#!/usr/bin/env bash

# Use this script to set up the BATS testing environment.

git clone https://github.com/bats-core/bats-core.git tests/bats
git clone https://github.com/bats-core/bats-support.git tests/test_helper/bats-support
git clone https://github.com/bats-core/bats-assert.git tests/test_helper/bats-assert

rm -rf tests/bats/.git
rm -rf tests/test_helper/bats-support/.git
rm -rf tests/test_helper/bats-assert/.git
