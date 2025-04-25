# How to build the docs locally
The add-on documentation uses:
- [Jekyll](https://jekyllrb.com/docs/installation/)
- [Minima](https://github.com/jekyll/minima)

Jekyll requires the following:

- Ruby version 2.7.0 or higher
- RubyGems
- GCC and Make

After installing all prerequisites:

    gem install jekyll bundler
    cd docs
    bundle install
    bundle exec jekyll serve


If you have trouble with serving the build try adding the ruby-erb package system-wide. See [this issue](https://talk.jekyllrb.com/t/cannot-exec-jekyll/9434)
