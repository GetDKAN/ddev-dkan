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
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "dkan-init" {
  set -eu -o pipefail
  cd ${TESTDIR}

  run ddev dkan-init --help
  assert_output --partial "--moduledev"

  run ddev dkan-site-install --help
  assert_output --partial "ddev dkan-site-install [flags]"

  run ddev dkan-init
  refute_output --partial "Setting up for local DKAN module development"
  assert_output --partial "Site codebase initialized."
}

@test "dkan-init-moduledev" {
  set -eu -o pipefail
  cd ${TESTDIR}

  run ddev dkan-init --moduledev
  assert_output --partial "Setting up for local DKAN module development"
  assert_output --partial "Site codebase initialized."
}
