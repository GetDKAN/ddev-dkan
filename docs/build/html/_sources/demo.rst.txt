Run The DKAN Demo Site
======================

Note: As of DDev 1.19.5, these instructions require managing the settings.php
file. After DDev 1.19.6 is released, this will (hopefully) not be required.

.. prompt:: bash $

    mkdir my-project && cd my-project
    ddev config --auto
    ddev get getdkan/dkan-ddev-addon
    ddev restart
    ddev composer create getdkan/recommended-project:@dev -y

At this point, we must add a configuration to settings.php

This should change after DDev 1.19.6 is released.

.. prompt:: bash $

    cat .ddev/misc/settings.dkan-snippet.php.txt >> docroot/sites/default/settings.php
    cp .ddev/misc/settings.dkan.php docroot/sites/default/settings.dkan.php
    ddev dkan-demo
