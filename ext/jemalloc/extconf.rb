require 'mkmf'
require 'rbconfig'

$stdout.sync = true
pkg = "jemalloc-3.0.0"

# monfigure and copy sources to cur_dir
cur_dir = Dir.pwd
Dir.chdir File.dirname(__FILE__) do
  # cleanup
  puts `rm -fR #{pkg}`
  puts `tar vjxf #{pkg}.tar.bz2`
  Dir.chdir(pkg) do
    # configure
    puts `./configure`
    # zone.c is only for Mac OS X
    if RbConfig::CONFIG['target_vendor'] != "apple"
      puts `rm -fR src/zone.c`
    end
    # mkmf only allows *.c files on current dir
    puts `cp src/*.c #{cur_dir}`
  end
end
Dir.chdir cur_dir

include_dir= File.dirname(__FILE__) + "/#{pkg}/include/"
$CFLAGS << %[ -std=gnu99 -Wall -pipe -g3 -fvisibility=hidden -O3 -funroll-loops -D_GNU_SOURCE -D_REENTRANT -I.. -I#{include_dir}]

create_makefile('jemalloc')

# modify Makefile to create .dylib, instead of .bundle
# NOTICE: Mac OS X only
if RbConfig::CONFIG['target_vendor'] == "apple"
  makefile = open('Makefile').read
  makefile.gsub!(/-dynamic\ -bundle/, '-shared')
  makefile.gsub!(/-flat_namespace/, '-dylib_install_name')
  #,-dylib_install_name
  open('Makefile', 'w'){ |f| f.write(makefile) }
end
