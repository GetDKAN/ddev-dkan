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
  ddev restart
  ddev dkan-init --force
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  # chown the test dir to current user.
  [ "${TESTDIR}" != "" ] && sudo chown -R $USER: ${TESTDIR}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "doxygen service and command" {
  set -eu -o pipefail
  cd ${TESTDIR}

  run ddev exec -s doxygen exit 0
  assert_success

  run ddev dkan-docs --help
  assert_output --partial "Generate documentation for the DKAN module"
  assert_success

  run ddev dkan-docs
  assert_output --partial "Documentation is now available at"
  assert_success
}