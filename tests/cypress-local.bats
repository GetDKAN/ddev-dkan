setup() {
  set -eu -o pipefail

  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export PROJNAME=test-dkan-ddev-addon
  export TESTDIR=~/tmp/$PROJNAME
  mkdir -p $TESTDIR
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev get ${DIR}
  ddev start
  ddev dkan-init --force
  ddev dkan-site-install
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "Run DKAN module Cypress tests locally" {
  set -eu -o pipefail

  skip "This test requires Cypress on the local host. Run it manually."

  cd ${TESTDIR}

  # Now that we have a whole site, let's remove the cypress tests from it.
  # This allows the fixture users to be added, but does not consume time
  # running actual tests. We only want to know whether the command works,
  # not whether the module's tests pass.
  rm -rf docroot/modules/contrib/dkan/cypress

  # Run a test group that does not exist, since we're not actually testing
  # PHP code here.
  run ddev dkan-module-test-cypress
  assert_output --partial "Starting DKAN module Cypress tests."
  assert_output --partial "No package.json present, not trying to install."
  assert_output --partial "Adding users from .ddev/misc/testUsers.json"
  assert_output --partial "Starting Cypress tests for"
  assert_output --partial "Displaying Cypress info..."
  assert_output --partial "Can't run because no spec files were found."
  assert_output --partial "Removing users from .ddev/misc/testUsers.json"
  # Test run should be a fail because there were no tests.
  assert_failure
}
