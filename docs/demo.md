# Run The DKAN Demo Site

Note: As of DDev 1.19.5, these instructions require managing the settings.php
file. After DDev 1.19.6 is released, this will (hopefully) not be required.

    mkdir my-project && cd my-project
    ddev config --auto
    ddev get getdkan/dkan-ddev-addon
    ddev composer create getdkan/recommended-project:@dev -y
    # At this point, we must add a configuration to settings.php
    # This should change after DDev 1.19.6 is released.
// Automatically generated include for settings managed by ddev.
if (file_exists(__DIR__ . '/settings.ddev.php') && getenv('IS_DDEV_PROJECT') == 'true') {
include __DIR__ . '/settings.ddev.php';
}

    ddev dkan-demo
