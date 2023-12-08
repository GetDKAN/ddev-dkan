setup() {
  set -eu -o pipefail

  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export PROJNAME=test-dkan-phpunit
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
  # TODO: Change this after https://www.drupal.org/project/moderated_content_bulk_publish/issues/3301389
  ddev composer require drupal/pathauto:^1.10
  ddev dkan-site-install
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "run phpunit tests" {
  set -eu -o pipefail
  cd ${TESTDIR}

  # Run a test group that does not exist, since we're not actually testing
  # PHP code here.
  run ddev dkan-phpunit --group this-group-should-not-exist
  assert_output --partial 'Starting PHPUnit test run'
  assert_output --partial 'No tests executed!'
}
