setup() {
  set -eu -o pipefail

  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-addon-template
  mkdir -p $TESTDIR
  export PROJNAME=test-dkan-ddev-addon
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"

  ddev config --project-name=${PROJNAME}
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "get from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  ddev get ${DIR}
  ddev restart
}
