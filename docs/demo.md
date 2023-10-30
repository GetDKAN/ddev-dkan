# Build a DKAN Demo Site

    mkdir my-project && cd my-project
    ddev config --auto
    ddev get https://github.com/GetDKAN/ddev-dkan/archive/refs/heads/main.tar.gz
    ddev restart
    ddev dkan-demo
    ddev launch
