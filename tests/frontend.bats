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
  ddev dkan-site-install
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install and build the frontend app" {
  set -eu -o pipefail

  run ddev dkan-frontend-install
  refute_output --partial "Forcing installation of frontend app over existing one."
  assert_output --partial 'Gathering frontend application:'
  assert_output --partial "Frontend install complete."

  run ddev dkan-frontend-install --force
  assert_output --partial "Forcing installation of frontend app over existing one."
  assert_output --partial 'Gathering frontend application:'
  assert_output --partial "Frontend install complete."

  run ddev dkan-frontend-build
  assert_output --partial "Frontend build complete."

  # run the tests, but ignore the pass/fail. We only care if they ran.
  run ddev dkan-frontend-test-cypress
  assert_output --partial '(Run Finished)'
}
