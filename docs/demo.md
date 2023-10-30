# Build a DKAN demo site

The following commands will create a Drupal site with DKAN enabled and a sample react frontend for you to test out.

    mkdir my-project && cd my-project
    ddev config --auto
    ddev get https://github.com/GetDKAN/ddev-dkan/archive/refs/heads/main.tar.gz
    ddev restart
    ddev dkan-demo
    ddev launch
