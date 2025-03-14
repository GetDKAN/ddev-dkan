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
  ddev addon get ${DIR}
  ddev restart
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "set up for moduledev and create a db backup" {
  set -eu -o pipefail
  cd ${TESTDIR}

  run ddev dkan-init --force --moduledev
  cd dkan
  git checkout tags/2.20.0
  cd ..
  ddev dkan-site-install
  run ddev dkan-update-test-dump
  assert_output --partial "Database dump for update tests created"
  assert [ -f ${TESTDIR}/dkan/tests/fixtures/update/update-2.20.0.sql.gz ]
  run ddev dkan-update-test-dump
  assert_output --partial "The file $(FILENAME) already exists. Overwrite? (y/n)"
  # Select 'n' to not overwrite the file
  run echo "n"
  assert_outpuut --partial "Enter a new filename"
  run echo "something"
  assert_output --partial "Database dump for update tests created"
  assert [ -f ${TESTDIR}/dkan/tests/fixtures/update/something.sql.gz ]
} 
