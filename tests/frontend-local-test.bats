setup() {
  set -eu -o pipefail

  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export PROJNAME=test-dkan-frontend-local
  export TESTDIR=~/tmp/$PROJNAME
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
  rm -rf $TESTDIR
  mkdir -p $TESTDIR
  cd "${TESTDIR}"
  pwd

  ddev config --project-name=${PROJNAME}
  ddev get ${DIR}
  ddev dkan-init --force
  mv .ddev/misc/docker-compose.cypress.yaml .ddev/docker-compose.cypress.yml
  ddev restart
  ddev dkan-site-install
  ddev dkan-frontend-install
  ddev dkan-frontend-build
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

  skip "This test requires Cypress in the host. Run it manually."

  # run the tests, but ignore the pass/fail. We only care if they ran.
  run ddev dkan-frontend-test-cypress
  assert_output --partial '(Run Finished)'
}
