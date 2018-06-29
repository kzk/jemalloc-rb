# jemalloc

Instant [jemalloc](http://www.canonware.com/jemalloc/) injection into Ruby apps, for better performance and less memory.

# Why jemalloc?

Ruby relies on malloc(3) for its internal memory allocation. Using better malloc() implementation will boost your application performance, and supress the memory usage.

jemalloc is a malloc(3) implementation, originally developed by Jason Evans. jemalloc handles small object better than other allocators so usually gives better performance and memory usage to Ruby programs.

# Why jemalloc?

Installing jemalloc separately from Ruby is pain in some cases (e.g. Heroku, EngineYard, etc). `je` gem contains jemalloc itself within a gem, and enables instant jemalloc injection in a really easy way: install `je` gem, and launch your app with `je` command.

# Install

Install `jemalloc` gem in your application. For [bundler](http://gembundler.com/) based application, please add the following line into your Gemfile, and install `jemalloc` by `bundle install`.

    gem 'jemalloc'

# Usage

Execute your application with `je` command, which is contained in `je` gem. Example command for Rails + bundler application is like follows.

    $ bundle exec je ./script/rails s

`-v` option will let you confirm jemalloc is actually injected.

    $ bundle exec je -v ./script/rails s
    => Injecting jemalloc...
    => Booting WEBrick
    ...

# Limitation

Currently, this gem works only on Linux and Mac OS X.

# License

[BSD-derived License](http://www.canonware.com/jemalloc/license.html).
