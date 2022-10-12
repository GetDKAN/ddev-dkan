setup() {
  set -eu -o pipefail

  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-addon-template
  mkdir -p $TESTDIR
  export PROJNAME=test-dkan-ddev-addon
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"

  ddev config --project-name=${PROJNAME}
  ddev get ${DIR}
  ddev restart
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "run project-level cypress tests" {
  set -eu -o pipefail
  cd ${TESTDIR}

  # We don't have any Cypress tests around, and we don't want to
  # manage installing cypress on the github test runner, so
  # we're only going to test that the command runs and outputs
  # the proper error messages.
  run ddev project-test-cypress
  assert_output --partial "Starting project Cypress tests"
  assert_output --partial "Unable to find Cypress tests in"
  assert_failure
}
