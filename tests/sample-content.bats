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
  # This section is copied from dkan-demo.
  ddev dkan-init
  ddev dkan-site-install

  ddev drush pm-enable dkan dkan_js_frontend config_update_ui -y

  mkdir -p sites/default/files/uploaded_resources
  mkdir -p sites/default/files/resources
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "add sample content" {
  set -eu -o pipefail

  run ddev dkan-sample-content
  assert_output --partial "Sample content added."
}
