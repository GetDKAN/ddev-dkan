setup() {
  set -eu -o pipefail

  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-addon-init
  mkdir -p $TESTDIR
  export PROJNAME=test-addon-init
  export DDEV_NON_INTERACTIVE=true
  cd "${TESTDIR}"
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  rm -rf *
  ddev config --project-name=${PROJNAME}
  ddev get ${DIR}
  ddev restart >/dev/null
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "dkan-init" {
  set -eu -o pipefail
  cd ${TESTDIR}

  run ddev dkan-init --help
  assert_output --partial "--moduledev"
  assert_output --partial "--force"
  assert_output --partial "--project-version"

  run ddev dkan-site-install --help
  assert_output --partial "ddev dkan-site-install [flags]"

  run ddev dkan-init --force
  refute_output --partial "Setting up for local DKAN module development"
  assert_output --partial "Site codebase initialized"
  assert_output --partial "Using project version: 10.2.x-dev"

  # Make sure we added our directories.
  assert [ -d "docroot/sites/default/files/uploaded_resources" ]
  assert [ -d "docroot/sites/default/files/resources" ]
}

@test "dkan-init-moduledev" {
  set -eu -o pipefail
  cd ${TESTDIR}

  run ddev dkan-init --force --moduledev
  assert_output --partial "Setting up for local DKAN module development"
  assert_output --partial "Site codebase initialized"
}

@test "dkan-init protects existing work" {
  set -eu -o pipefail
  cd ${TESTDIR}

  touch composer.json

  run ddev dkan-init --project-version 10.0.x-dev
  assert_output --partial "Using project version: 10.0.x-dev"
  assert_output --partial "Found composer.json"
  assert_failure

  rm composer.json
  mkdir -p docroot/core

  run ddev dkan-init
  assert_output --partial "Found docroot/core"
  assert_failure

  rm -rf docroot/core
  mkdir dkan

  run ddev dkan-init
  assert_output --partial "Found dkan"
  assert_failure
}
