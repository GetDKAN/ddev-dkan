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

  ddev dkan-init
  ddev dkan-site-install

  ddev drush pm-enable dkan dkan_js_frontend config_update_ui -y
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "add sample content" {
  set -eu -o pipefail

  run ddev dkan-sample-content
  assert_output --partial "Sample content added."
}
