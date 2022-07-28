setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export PROJNAME=test-dkan-ddev-addon
  export TESTDIR=~/tmp/$PROJNAME
  mkdir -p $TESTDIR
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} || true
}

teardown() {
  set -eu -o pipefail
  echo "teardown..."
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME}
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install a demo site" {
  set -eu -o pipefail
  cd ${TESTDIR}
  ddev config --project-name=${PROJNAME}
  ddev get ${DIR}
  ddev composer create getdkan/recommended-project:@dev -y
  # Shuffle around the settings file until ddev can do it for us.
  # TODO: Change this after ddev 1.19.6 release.
  cat .ddev/misc/settings.dkan-snippet.php.txt >> docroot/sites/default/settings.php
  cp .ddev/misc/settings.dkan.php docroot/sites/default/settings.dkan.php
  ddev dkan-demo
  wget https://${PROJNAME}.ddev.site/home
}
