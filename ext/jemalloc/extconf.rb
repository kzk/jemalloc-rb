require 'mkmf'
require 'rbconfig'

$stdout.sync = true
pkg = "jemalloc-5.2.1"

def sys(cmd)
  puts "$ #{cmd}"
  unless ret = xsystem(cmd)
    raise "system command `#{cmd}' failed, please report to https://github.com/ibc/em-udns/issues"
  end
  ret
end

# grab config options
config_options = []
config_options << '--disable-valgrind' unless (with_config('valgrind') == false)

# monfigure and copy sources to cur_dir
src_dir = File.expand_path(File.dirname(__FILE__))
cur_dir = Dir.pwd
Dir.chdir File.dirname(__FILE__) do
  # cleanup
  FileUtils.remove_dir(pkg, true)

  # decompress and copy source files
  sys "tar vjxf #{pkg}.tar.bz2"
  Dir.chdir(pkg) do
    # configure
    sys "./configure #{ config_options.join(' ') }"
    # zone.c is only for Mac OS X
    if RbConfig::CONFIG['target_vendor'] != "apple"
      sys "rm -fR src/zone.c"
    end
    # if we don't remove this explicitly, mkmf will try to include it
    # and that causes issues when '--disable-valgrind' is used
    # le sigh
    unless with_config('valgrind') == false
      sys "rm -fR src/valgrind.c"
    end
    # mkmf only allows *.c files on current dir
    sys "cp src/*.c #{src_dir}"
  end
end
Dir.chdir cur_dir

include_dir= File.dirname(__FILE__) + "/#{pkg}/include/"
$CFLAGS << %[ -std=gnu99 -Wall -pipe -g3 -fvisibility=hidden -O3 -funroll-loops -D_GNU_SOURCE -D_REENTRANT -I.. -I#{include_dir}]

create_makefile('jemalloc')

# Modify Makefile to create .dylib, instead of .bundle. Because extconf.rb
# generates .bundle by default, but .bundle cannot be dynamically loaded by
# LD_PRELOAD.
# NOTICE: Mac OS X only
if RbConfig::CONFIG['target_vendor'] == "apple"
  makefile = open('Makefile').read
  # for 1.9.2 and 1.9.3
  if makefile =~ /-dynamic\ -bundle/ && makefile =~ /-flat_namespace/
    makefile.gsub!(/-dynamic\ -bundle/, '-shared')
    makefile.gsub!(/-flat_namespace/, '-dylib_install_name')
  # for 2.0.0
  elsif makefile =~ /-dynamic\ -bundle/
    makefile.gsub!(/-dynamic\ -bundle/, '-shared')
  else
    raise 'Your platform is not supported. Please report to http://github.com/treasure-data/jemalloc-rb'
  end
  open('Makefile', 'w'){ |f| f.write(makefile) }
end
