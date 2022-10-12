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

@test "dkan-frontend-install" {
  run ddev dkan-frontend-install
  assert_output --partial "Installing default frontend theme"
  refute_output --partial "Not installing default frontend theme"
  assert_output --partial "Gathering frontend application"
  assert_success
}

@test "dkan-frontend-install no default theme" {
  run ddev dkan-frontend-install --theme 0
  refute_output --partial "Installing default frontend theme"
  assert_output --partial "Not installing default frontend theme"
  assert_output --partial "Gathering frontend application"
  assert_success
}
