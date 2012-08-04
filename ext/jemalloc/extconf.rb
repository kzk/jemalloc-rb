require 'mkmf'
require File.expand_path('../../lib/je/version', File.dirname(__FILE__))

$stdout.sync = true
cur_dir = Dir.pwd
Dir.chdir(File.dirname(__FILE__)) do
  puts `rm -fR include/jemalloc/internal/jemalloc_internal.h`
  puts `./configure`
end
Dir.chdir cur_dir

include_dir= File.dirname(__FILE__) + "/include/"
$CFLAGS << %[ -std=gnu99 -Wall -pipe -g3 -fvisibility=hidden -O3 -funroll-loops -D_GNU_SOURCE -D_REENTRANT -I.. -I#{include_dir}]

create_makefile('jemalloc')
