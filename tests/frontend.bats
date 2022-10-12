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
  mv .ddev/misc/docker-compose.cypress.yaml .ddev/docker-compose.cypress.yml
  ddev restart
  ddev dkan-init --force
  ddev dkan-site-install
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install and build the frontend app" {
  set -eu -o pipefail

  run ddev dkan-frontend-install
  refute_output --partial "Not installing default frontend theme"
  assert_output --partial 'Gathering frontend application:'
  assert_output --partial "Frontend install complete."
  assert_success

  run ddev dkan-frontend-build
  assert_output --partial "Frontend build complete."
  assert_success
}
