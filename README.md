# je - Instant [jemalloc](http://www.canonware.com/jemalloc/) injection into Ruby apps

jemalloc sometimes dramatically supresses the memory fragmentation on server programs. `je` gem contains jemalloc itself within a gem, and enables you to inject jemalloc into your application in a really easy way: install `je` gem, and launch your app with `je` command.

# Install

Install `je` gem in your application. For [bundler](http://gembundler.com/) based application, please add the following line into your Gemfile, and and install `je` by `bundle install`.

    gem 'je'

# Usage

Execute your application with `je` command, which is contained in `je` gem. Example command for Rails + bundler application is like follows.


    $ bundle exec je ./script/rails s

# TODO

Currently, this gem works only on Linux. Not working on Windows and Mac OS X.

# License

[BSD-derived License](http://www.canonware.com/jemalloc/license.html).