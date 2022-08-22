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
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart

  # TODO: Replace this with actual dkan-* commands.
  ddev composer create getdkan/recommended-project:@dev --no-interaction -y
  # TODO: Change this after https://www.drupal.org/project/moderated_content_bulk_publish/issues/3301389
  ddev composer require drupal/pathauto:^1.10

  ddev drush si -y
  ddev drush pm-enable dkan -y
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
  run ddev dkan-test-phpunit --group this-group-should-not-exist
  assert_output --partial 'Starting PHPUnit test run'
  assert_output --partial 'No tests executed!'
}
