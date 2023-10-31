# Build a DKAN demo site

The following commands will create a Drupal site with DKAN enabled and a sample react frontend for you to test out.

    mkdir my-project && cd my-project
    ddev config --auto
    ddev get getdkan/ddev-dkan
    ddev restart
    ddev dkan-demo
    ddev launch
