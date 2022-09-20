setup() {
  set -eu -o pipefail

  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  export SUT_DIR=$(pwd)
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export PROJNAME=test-dkan-ddev-addon
  export TESTDIR=~/tmp/$PROJNAME
  mkdir -p $TESTDIR
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev get ${DIR}
  ddev restart
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "run project-level phpunit tests" {
  set -eu -o pipefail
  cd ${TESTDIR}

  # No phpunit.xml file.
  run ddev project-test-phpunit
  assert_output --partial "PHPUnit config not found"
  assert_failure

  # Add config, but no executable.
  mkdir -p docroot/modules/custom
  cp .ddev/misc/phpunit.xml docroot/modules/custom
  run ddev project-test-phpunit
  assert_output --partial "Unable to find PHPUnit executable"
  assert_failure

  # Can perform test run, for a group that doesn't exist.
  ddev dkan-init
  mkdir -p docroot/modules/custom
  cp .ddev/misc/phpunit.xml docroot/modules/custom
  run ddev project-test-phpunit --group this-group-should-not-exist
  assert_output --partial 'Starting PHPUnit test run'
  assert_output --partial 'No tests executed!'
  assert_output --partial 'Project PHPUnit tests complete'
  assert_success

  # Can perform test run, for a group that does exist.
  cp -R $SUT_DIR/tests/phpunit_tests docroot/modules/custom
  run ddev project-test-phpunit --group dkan-ddev-addon-test
  assert_output --partial 'Starting PHPUnit test run'
  assert_output --partial 'OK (1 test, 1 assertion)'
  assert_output --partial 'Project PHPUnit tests complete'
  assert_success
}
