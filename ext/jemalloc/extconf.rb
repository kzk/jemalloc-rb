require 'mkmf'
require 'rbconfig'
require File.expand_path('../../lib/je/version', File.dirname(__FILE__))

$stdout.sync = true
pkg = "jemalloc-3.0.0"

cur_dir = Dir.pwd
Dir.chdir File.dirname(__FILE__) do
  # cleanup
  puts `rm -fR #{pkg}`
  puts `tar vjxf #{pkg}.tar.bz2`
  Dir.chdir(pkg) do
    # configure
    puts `./configure`
    # mkmf only allows *.c file on current dir
    puts `cp src/*.c ../`
    # zone.c is only for Mac OS X
    if RbConfig::CONFIG['target_vendor'] != "apple"
      puts `rm -fR ../zone.c`
    end
  end
end
Dir.chdir cur_dir

include_dir= File.dirname(__FILE__) + "/#{pkg}/include/"
$CFLAGS << %[ -std=gnu99 -Wall -pipe -g3 -fvisibility=hidden -O3 -funroll-loops -D_GNU_SOURCE -D_REENTRANT -I.. -I#{include_dir}]

create_makefile('jemalloc')
