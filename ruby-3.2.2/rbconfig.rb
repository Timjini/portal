# encoding: ascii-8bit
# frozen-string-literal: false
#
# The module storing Ruby interpreter configurations on building.
#
# This file was created by mkconfig.rb when ruby was built.  It contains
# build information for ruby which is used e.g. by mkmf to build
# compatible native extensions.  Any changes made to this file will be
# lost the next time ruby is built.

module RbConfig
  RUBY_VERSION.start_with?("3.2.") or
    raise "ruby lib version (3.2.2) doesn't match executable version (#{RUBY_VERSION})"

  # Ruby installed directory.
  TOPDIR = File.dirname(__FILE__).chomp!("/lib/ruby/3.2.0/x86_64-linux")
  # DESTDIR on make install.
  DESTDIR = '' unless defined? DESTDIR
  # The hash configurations stored.
  CONFIG = {}
  CONFIG["DESTDIR"] = DESTDIR
  CONFIG["MAJOR"] = "3"
  CONFIG["MINOR"] = "2"
  CONFIG["TEENY"] = "2"
  CONFIG["PATCHLEVEL"] = "53"
  CONFIG["INSTALL"] = '/nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/install -c'
  CONFIG["EXEEXT"] = ""
  CONFIG["prefix"] = (TOPDIR || DESTDIR + "/home/runner/.rubies/ruby-3.2.2")
  CONFIG["ruby_install_name"] = "$(RUBY_BASE_NAME)"
  CONFIG["RUBY_INSTALL_NAME"] = "$(RUBY_BASE_NAME)"
  CONFIG["RUBY_SO_NAME"] = "$(RUBY_BASE_NAME)"
  CONFIG["exec"] = "exec"
  CONFIG["ruby_pc"] = "ruby-3.2.pc"
  CONFIG["CC_WRAPPER"] = ""
  CONFIG["PACKAGE"] = "ruby"
  CONFIG["BUILTIN_TRANSSRCS"] = " enc/trans/newline.c"
  CONFIG["MKMF_VERBOSE"] = "0"
  CONFIG["MANTYPE"] = "man"
  CONFIG["vendorarchhdrdir"] = "$(vendorhdrdir)/$(sitearch)"
  CONFIG["sitearchhdrdir"] = "$(sitehdrdir)/$(sitearch)"
  CONFIG["rubyarchhdrdir"] = "$(rubyhdrdir)/$(arch)"
  CONFIG["vendorhdrdir"] = "$(rubyhdrdir)/vendor_ruby"
  CONFIG["sitehdrdir"] = "$(rubyhdrdir)/site_ruby"
  CONFIG["rubyhdrdir"] = "$(includedir)/$(RUBY_VERSION_NAME)"
  CONFIG["RUBY_SEARCH_PATH"] = ""
  CONFIG["UNIVERSAL_INTS"] = ""
  CONFIG["UNIVERSAL_ARCHNAMES"] = ""
  CONFIG["configure_args"] = " '--prefix=/home/runner/.rubies/ruby-3.2.2' 'CFLAGS=' 'LDFLAGS=-L/nix/store/im4zgh092kphdqwwdcv46hqrilg9zkp2-ruby3.2-io-console-0.7.2/lib -L/nix/store/hszhyccxkl3klidixsnrv72d20hbpf70-ruby3.2-zeitwerk-2.6.13/lib -L/nix/store/8qmsl40rak8h8nqshnjl9c9sa2pwmhhn-ruby3.2-mutex_m-0.2.0/lib -L/nix/store/a2yx8rqdb3ilfm3mssrf5a0la7bwsf83-ruby3.2-rack-3.0.10/lib -L/nix/store/n2vsaszmwq5lnzp7v127ab2604l2disq-ruby3.2-irb-1.12.0/lib -L/nix/store/89020cz4p82vi66rckl23wq4llpg134g-ruby3.2-psych-5.1.2/lib -L/nix/store/dlcspccydmqd9qljclfqdggzzvxdvy01-ruby3.2-thor-1.3.1/lib -L/nix/store/c8r9gjvd6mz59lbk0jvkj3vs55ybjcm2-ruby3.2-mini_portile2-2.8.5/lib -L/nix/store/3ai2b07ybl4aba9jcmjyaps26bim2avb-ruby3.2-crass-1.0.6/lib -L/nix/store/gv6ahkd40a581p98nhqhyr8kxgb3z76b-ruby3.2-webrick-1.8.1/lib -L/nix/store/25xk1dw6wvysya4lk2llfamb3krw9912-ruby3.2-actionpack-7.1.3.2/lib -L/nix/store/cqgi9z0zxcrzqm6mqn7nf9s16ckl9b0h-ruby3.2-minitest-5.22.3/lib -L/nix/store/9h8dg1m7qbbnif4v8vsypw6dsb7y83r0-ruby3.2-nokogiri-1.16.3/lib -L/nix/store/5p92ch4zxg2pcf43sdbxfdsnh0b3c7ma-ruby3.2-activesupport-7.1.3.2/lib -L/nix/store/cxcdlbl4i2fwy9ffwvz3lrgwzzvlzx8h-ruby3.2-erubi-1.12.0/lib -L/nix/store/9p2g93d1hraa9lkjf0ikrdvk3v22h79c-ruby3.2-racc-1.7.3/lib -L/nix/store/i9wz0rm6wbk0j1ycpx6fjnlvjn8sndiw-ruby3.2-rails-html-sanitizer-1.6.0/lib -L/nix/store/1cm9zjr32qcfizcpcjm6c9k5llnjwphx-ruby3.2-tzinfo-2.0.6/lib -L/nix/store/4djagqamg5bxxxr9dywzmk9b7n4fwba4-ruby3.2-builder-3.2.4/lib -L/nix/store/1f1n8vklwym6kvg1a7cd1ixp5qvwpc2m-ruby3.2-rdoc-6.6.3.1/lib -L/nix/store/bh4i6md622xm0zlihsc3rw0p7gl92wdw-ruby3.2-stringio-3.1.0/lib -L/nix/store/j0fw86s1kbjnamv8rlqrh2knknslyxp0-ruby3.2-railties-7.1.3.2/lib -L/nix/store/7cdx2hki4zijq0zlhmv0lia6fvq692ai-ruby3.2-actionview-7.1.3.2/lib -L/nix/store/6piqxnb9a4wdxkjsxb4b4l5b3ns8xqpa-ruby3.2-concurrent-ruby-1.2.3/lib -L/nix/store/l77q291mz8dkb83zgrc495s2xiqvz1by-ruby3.2-rackup-2.1.0/lib -L/nix/store/sff8nnynhdx00jg78cvjnd4lhzffnvi9-ruby3.2-base64-0.2.0/lib -L/nix/store/d1fywbqdrxpnw0azhwm2bk71p59y2yh1-ruby3.2-rack-session-2.0.0/lib -L/nix/store/x0v4dbsg72pzbhy213cvb1hc1ihibwqz-ruby3.2-reline-0.5.0/lib -L/nix/store/rr79s4pmk48d7y030s7g4d8qnc81d5xq-ruby3.2-rake-13.1.0/lib -L/nix/store/d47g6jv4d059amprcnyvn85j6mljj2dx-ruby3.2-drb-2.2.1/lib -L/nix/store/42xzn4c2269brd8a17z65skq031ym9b1-ruby3.2-i18n-1.14.4/lib -L/nix/store/6d0xkr7fbnd3ai639c1j43lmd04ybdxx-ruby3.2-rails-dom-testing-2.2.0/lib -L/nix/store/7yqii7pvvw124xn1f1jl0ilj5v7mn731-ruby3.2-rack-test-2.1.0/lib -L/nix/store/n14z5y2qmnqi3i0ax26h72kcwhclawnj-ruby3.2-bigdecimal-3.1.7/lib -L/nix/store/kysa37knwc6ncsjjy3a9gl80fjhsm726-ruby3.2-connection_pool-2.4.1/lib -L/nix/store/mkq3dvizjkgzy3m0ww9ssjhqrlb7pqry-ruby3.2-loofah-2.22.0/lib'"
  CONFIG["CONFIGURE"] = "configure"
  CONFIG["vendorarchdir"] = "$(vendorlibdir)/$(sitearch)"
  CONFIG["vendorlibdir"] = "$(vendordir)/$(ruby_version)"
  CONFIG["vendordir"] = "$(rubylibprefix)/vendor_ruby"
  CONFIG["sitearchdir"] = "$(sitelibdir)/$(sitearch)"
  CONFIG["sitelibdir"] = "$(sitedir)/$(ruby_version)"
  CONFIG["sitedir"] = "$(rubylibprefix)/site_ruby"
  CONFIG["rubyarchdir"] = "$(rubylibdir)/$(arch)"
  CONFIG["rubylibdir"] = "$(rubylibprefix)/$(ruby_version)"
  CONFIG["ruby_version"] = "3.2.0"
  CONFIG["sitearch"] = "$(arch)"
  CONFIG["arch"] = "x86_64-linux"
  CONFIG["sitearchincludedir"] = "$(includedir)/$(sitearch)"
  CONFIG["archincludedir"] = "$(includedir)/$(arch)"
  CONFIG["sitearchlibdir"] = "$(libdir)/$(sitearch)"
  CONFIG["archlibdir"] = "$(libdir)/$(arch)"
  CONFIG["libdirname"] = "libdir"
  CONFIG["RUBY_EXEC_PREFIX"] = "/home/runner/.rubies/ruby-3.2.2"
  CONFIG["RUBY_LIB_VERSION"] = ""
  CONFIG["RUBY_LIB_VERSION_STYLE"] = "3\t/* full */"
  CONFIG["RI_BASE_NAME"] = "ri"
  CONFIG["ridir"] = "$(datarootdir)/$(RI_BASE_NAME)"
  CONFIG["rubysitearchprefix"] = "$(rubylibprefix)/$(sitearch)"
  CONFIG["rubyarchprefix"] = "$(rubylibprefix)/$(arch)"
  CONFIG["MAKEFILES"] = "Makefile GNUmakefile"
  CONFIG["PLATFORM_DIR"] = ""
  CONFIG["COROUTINE_TYPE"] = "amd64"
  CONFIG["THREAD_MODEL"] = "pthread"
  CONFIG["SYMBOL_PREFIX"] = ""
  CONFIG["EXPORT_PREFIX"] = ""
  CONFIG["COMMON_HEADERS"] = ""
  CONFIG["COMMON_MACROS"] = ""
  CONFIG["COMMON_LIBS"] = ""
  CONFIG["MAINLIBS"] = "-lrt -lrt -ldl -lm -lpthread "
  CONFIG["ENABLE_SHARED"] = "no"
  CONFIG["DLDSHARED"] = "$(CC) -shared"
  CONFIG["DLDLIBS"] = "-lc"
  CONFIG["SOLIBS"] = "$(MAINLIBS)"
  CONFIG["LIBRUBYARG_SHARED"] = "-Wl,-rpath,$(libdir) -L$(libdir) "
  CONFIG["LIBRUBYARG_STATIC"] = "-Wl,-rpath,$(libdir) -L$(libdir) -l$(RUBY_SO_NAME)-static $(MAINLIBS)"
  CONFIG["LIBRUBYARG"] = "$(LIBRUBYARG_STATIC)"
  CONFIG["LIBRUBY"] = "$(LIBRUBY_A)"
  CONFIG["LIBRUBY_ALIASES"] = "lib$(RUBY_SO_NAME).$(SOEXT)"
  CONFIG["LIBRUBY_SONAME"] = "lib$(RUBY_SO_NAME).$(SOEXT).$(RUBY_API_VERSION)"
  CONFIG["LIBRUBY_SO"] = "lib$(RUBY_SO_NAME).$(SOEXT).$(RUBY_PROGRAM_VERSION)"
  CONFIG["LIBRUBY_A"] = "lib$(RUBY_SO_NAME)-static.a"
  CONFIG["RUBYW_INSTALL_NAME"] = ""
  CONFIG["rubyw_install_name"] = ""
  CONFIG["EXTDLDFLAGS"] = ""
  CONFIG["EXTLDFLAGS"] = ""
  CONFIG["strict_warnflags"] = ""
  CONFIG["warnflags"] = "-Wall -Wextra -Wdeprecated-declarations -Wdiv-by-zero -Wduplicated-cond -Wimplicit-function-declaration -Wimplicit-int -Wmisleading-indentation -Wpointer-arith -Wwrite-strings -Wold-style-definition -Wimplicit-fallthrough=0 -Wmissing-noreturn -Wno-cast-function-type -Wno-constant-logical-operand -Wno-long-long -Wno-missing-field-initializers -Wno-overlength-strings -Wno-packed-bitfield-compat -Wno-parentheses-equality -Wno-self-assign -Wno-tautological-compare -Wno-unused-parameter -Wno-unused-value -Wsuggest-attribute=format -Wsuggest-attribute=noreturn -Wunused-variable -Wundef"
  CONFIG["debugflags"] = "-ggdb3"
  CONFIG["optflags"] = "-O3 -fno-fast-math"
  CONFIG["NULLCMD"] = ":"
  CONFIG["ENABLE_DEBUG_ENV"] = ""
  CONFIG["DLNOBJ"] = "dln.o"
  CONFIG["INSTALL_STATIC_LIBRARY"] = "yes"
  CONFIG["YJIT_OBJ"] = ""
  CONFIG["YJIT_LIBS"] = ""
  CONFIG["CARGO_BUILD_ARGS"] = ""
  CONFIG["YJIT_SUPPORT"] = "no"
  CONFIG["CARGO"] = ""
  CONFIG["RUSTC"] = "no"
  CONFIG["MJIT_SUPPORT"] = "yes"
  CONFIG["EXECUTABLE_EXTS"] = ""
  CONFIG["ARCHFILE"] = ""
  CONFIG["LIBRUBY_RELATIVE"] = "no"
  CONFIG["EXTOUT"] = ".ext"
  CONFIG["PREP"] = "miniruby$(EXEEXT)"
  CONFIG["CROSS_COMPILING"] = "no"
  CONFIG["TEST_RUNNABLE"] = "yes"
  CONFIG["rubylibprefix"] = "$(libdir)/$(RUBY_BASE_NAME)"
  CONFIG["setup"] = "Setup"
  CONFIG["SOEXT"] = "so"
  CONFIG["TRY_LINK"] = ""
  CONFIG["PRELOADENV"] = "LD_PRELOAD"
  CONFIG["LIBPATHENV"] = "LD_LIBRARY_PATH"
  CONFIG["RPATHFLAG"] = " -Wl,-rpath,%1$-s"
  CONFIG["LIBPATHFLAG"] = " -L%1$-s"
  CONFIG["LINK_SO"] = ""
  CONFIG["ADDITIONAL_DLDFLAGS"] = ""
  CONFIG["ENCSTATIC"] = ""
  CONFIG["EXTSTATIC"] = ""
  CONFIG["ASMEXT"] = "S"
  CONFIG["LIBEXT"] = "a"
  CONFIG["DLEXT"] = "so"
  CONFIG["LDSHAREDXX"] = "$(CXX) -shared"
  CONFIG["LDSHARED"] = "$(CC) -shared"
  CONFIG["CCDLFLAGS"] = "-fPIC"
  CONFIG["STATIC"] = ""
  CONFIG["ARCH_FLAG"] = ""
  CONFIG["DLDFLAGS"] = "-L/nix/store/im4zgh092kphdqwwdcv46hqrilg9zkp2-ruby3.2-io-console-0.7.2/lib -L/nix/store/hszhyccxkl3klidixsnrv72d20hbpf70-ruby3.2-zeitwerk-2.6.13/lib -L/nix/store/8qmsl40rak8h8nqshnjl9c9sa2pwmhhn-ruby3.2-mutex_m-0.2.0/lib -L/nix/store/a2yx8rqdb3ilfm3mssrf5a0la7bwsf83-ruby3.2-rack-3.0.10/lib -L/nix/store/n2vsaszmwq5lnzp7v127ab2604l2disq-ruby3.2-irb-1.12.0/lib -L/nix/store/89020cz4p82vi66rckl23wq4llpg134g-ruby3.2-psych-5.1.2/lib -L/nix/store/dlcspccydmqd9qljclfqdggzzvxdvy01-ruby3.2-thor-1.3.1/lib -L/nix/store/c8r9gjvd6mz59lbk0jvkj3vs55ybjcm2-ruby3.2-mini_portile2-2.8.5/lib -L/nix/store/3ai2b07ybl4aba9jcmjyaps26bim2avb-ruby3.2-crass-1.0.6/lib -L/nix/store/gv6ahkd40a581p98nhqhyr8kxgb3z76b-ruby3.2-webrick-1.8.1/lib -L/nix/store/25xk1dw6wvysya4lk2llfamb3krw9912-ruby3.2-actionpack-7.1.3.2/lib -L/nix/store/cqgi9z0zxcrzqm6mqn7nf9s16ckl9b0h-ruby3.2-minitest-5.22.3/lib -L/nix/store/9h8dg1m7qbbnif4v8vsypw6dsb7y83r0-ruby3.2-nokogiri-1.16.3/lib -L/nix/store/5p92ch4zxg2pcf43sdbxfdsnh0b3c7ma-ruby3.2-activesupport-7.1.3.2/lib -L/nix/store/cxcdlbl4i2fwy9ffwvz3lrgwzzvlzx8h-ruby3.2-erubi-1.12.0/lib -L/nix/store/9p2g93d1hraa9lkjf0ikrdvk3v22h79c-ruby3.2-racc-1.7.3/lib -L/nix/store/i9wz0rm6wbk0j1ycpx6fjnlvjn8sndiw-ruby3.2-rails-html-sanitizer-1.6.0/lib -L/nix/store/1cm9zjr32qcfizcpcjm6c9k5llnjwphx-ruby3.2-tzinfo-2.0.6/lib -L/nix/store/4djagqamg5bxxxr9dywzmk9b7n4fwba4-ruby3.2-builder-3.2.4/lib -L/nix/store/1f1n8vklwym6kvg1a7cd1ixp5qvwpc2m-ruby3.2-rdoc-6.6.3.1/lib -L/nix/store/bh4i6md622xm0zlihsc3rw0p7gl92wdw-ruby3.2-stringio-3.1.0/lib -L/nix/store/j0fw86s1kbjnamv8rlqrh2knknslyxp0-ruby3.2-railties-7.1.3.2/lib -L/nix/store/7cdx2hki4zijq0zlhmv0lia6fvq692ai-ruby3.2-actionview-7.1.3.2/lib -L/nix/store/6piqxnb9a4wdxkjsxb4b4l5b3ns8xqpa-ruby3.2-concurrent-ruby-1.2.3/lib -L/nix/store/l77q291mz8dkb83zgrc495s2xiqvz1by-ruby3.2-rackup-2.1.0/lib -L/nix/store/sff8nnynhdx00jg78cvjnd4lhzffnvi9-ruby3.2-base64-0.2.0/lib -L/nix/store/d1fywbqdrxpnw0azhwm2bk71p59y2yh1-ruby3.2-rack-session-2.0.0/lib -L/nix/store/x0v4dbsg72pzbhy213cvb1hc1ihibwqz-ruby3.2-reline-0.5.0/lib -L/nix/store/rr79s4pmk48d7y030s7g4d8qnc81d5xq-ruby3.2-rake-13.1.0/lib -L/nix/store/d47g6jv4d059amprcnyvn85j6mljj2dx-ruby3.2-drb-2.2.1/lib -L/nix/store/42xzn4c2269brd8a17z65skq031ym9b1-ruby3.2-i18n-1.14.4/lib -L/nix/store/6d0xkr7fbnd3ai639c1j43lmd04ybdxx-ruby3.2-rails-dom-testing-2.2.0/lib -L/nix/store/7yqii7pvvw124xn1f1jl0ilj5v7mn731-ruby3.2-rack-test-2.1.0/lib -L/nix/store/n14z5y2qmnqi3i0ax26h72kcwhclawnj-ruby3.2-bigdecimal-3.1.7/lib -L/nix/store/kysa37knwc6ncsjjy3a9gl80fjhsm726-ruby3.2-connection_pool-2.4.1/lib -L/nix/store/mkq3dvizjkgzy3m0ww9ssjhqrlb7pqry-ruby3.2-loofah-2.22.0/lib -Wl,--compress-debug-sections=zlib"
  CONFIG["ALLOCA"] = ""
  CONFIG["EGREP"] = "/usr/bin/grep -E"
  CONFIG["GREP"] = "/usr/bin/grep"
  CONFIG["dsymutil"] = ""
  CONFIG["codesign"] = ""
  CONFIG["cleanlibs"] = ""
  CONFIG["POSTLINK"] = ":"
  CONFIG["WERRORFLAG"] = "-Werror"
  CONFIG["RUBY_DEVEL"] = ""
  CONFIG["CHDIR"] = "cd -P"
  CONFIG["RMALL"] = "rm -fr"
  CONFIG["RMDIRS"] = "rmdir --ignore-fail-on-non-empty -p"
  CONFIG["RMDIR"] = "rmdir --ignore-fail-on-non-empty"
  CONFIG["CP"] = "cp"
  CONFIG["RM"] = "rm -f"
  CONFIG["PKG_CONFIG"] = ""
  CONFIG["DOXYGEN"] = ""
  CONFIG["DOT"] = ""
  CONFIG["MKDIR_P"] = "/nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/mkdir -p"
  CONFIG["INSTALL_DATA"] = "$(INSTALL) -m 644"
  CONFIG["INSTALL_SCRIPT"] = "$(INSTALL)"
  CONFIG["INSTALL_PROGRAM"] = "$(INSTALL)"
  CONFIG["SET_MAKE"] = ""
  CONFIG["LN_S"] = "ln -s"
  CONFIG["DLLWRAP"] = ""
  CONFIG["WINDRES"] = ""
  CONFIG["ASFLAGS"] = ""
  CONFIG["ARFLAGS"] = "rcD "
  CONFIG["try_header"] = ""
  CONFIG["CC_VERSION_MESSAGE"] = "gcc (GCC) 13.3.0\nCopyright (C) 2023 Free Software Foundation, Inc.\nThis is free software; see the source for copying conditions.  There is NO\nwarranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
  CONFIG["CC_VERSION"] = "$(CC) --version"
  CONFIG["MJIT_CC"] = "/nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/gcc"
  CONFIG["CSRCFLAG"] = ""
  CONFIG["COUTFLAG"] = "-o "
  CONFIG["OUTFLAG"] = "-o "
  CONFIG["CPPOUTFILE"] = "-o conftest.i"
  CONFIG["GNU_LD"] = "yes"
  CONFIG["GCC"] = "yes"
  CONFIG["CPP"] = "$(CC) -E"
  CONFIG["CXXFLAGS"] = ""
  CONFIG["OBJEXT"] = "o"
  CONFIG["CPPFLAGS"] = " $(DEFS) $(cppflags)"
  CONFIG["LDFLAGS"] = "-L. -L/nix/store/im4zgh092kphdqwwdcv46hqrilg9zkp2-ruby3.2-io-console-0.7.2/lib -L/nix/store/hszhyccxkl3klidixsnrv72d20hbpf70-ruby3.2-zeitwerk-2.6.13/lib -L/nix/store/8qmsl40rak8h8nqshnjl9c9sa2pwmhhn-ruby3.2-mutex_m-0.2.0/lib -L/nix/store/a2yx8rqdb3ilfm3mssrf5a0la7bwsf83-ruby3.2-rack-3.0.10/lib -L/nix/store/n2vsaszmwq5lnzp7v127ab2604l2disq-ruby3.2-irb-1.12.0/lib -L/nix/store/89020cz4p82vi66rckl23wq4llpg134g-ruby3.2-psych-5.1.2/lib -L/nix/store/dlcspccydmqd9qljclfqdggzzvxdvy01-ruby3.2-thor-1.3.1/lib -L/nix/store/c8r9gjvd6mz59lbk0jvkj3vs55ybjcm2-ruby3.2-mini_portile2-2.8.5/lib -L/nix/store/3ai2b07ybl4aba9jcmjyaps26bim2avb-ruby3.2-crass-1.0.6/lib -L/nix/store/gv6ahkd40a581p98nhqhyr8kxgb3z76b-ruby3.2-webrick-1.8.1/lib -L/nix/store/25xk1dw6wvysya4lk2llfamb3krw9912-ruby3.2-actionpack-7.1.3.2/lib -L/nix/store/cqgi9z0zxcrzqm6mqn7nf9s16ckl9b0h-ruby3.2-minitest-5.22.3/lib -L/nix/store/9h8dg1m7qbbnif4v8vsypw6dsb7y83r0-ruby3.2-nokogiri-1.16.3/lib -L/nix/store/5p92ch4zxg2pcf43sdbxfdsnh0b3c7ma-ruby3.2-activesupport-7.1.3.2/lib -L/nix/store/cxcdlbl4i2fwy9ffwvz3lrgwzzvlzx8h-ruby3.2-erubi-1.12.0/lib -L/nix/store/9p2g93d1hraa9lkjf0ikrdvk3v22h79c-ruby3.2-racc-1.7.3/lib -L/nix/store/i9wz0rm6wbk0j1ycpx6fjnlvjn8sndiw-ruby3.2-rails-html-sanitizer-1.6.0/lib -L/nix/store/1cm9zjr32qcfizcpcjm6c9k5llnjwphx-ruby3.2-tzinfo-2.0.6/lib -L/nix/store/4djagqamg5bxxxr9dywzmk9b7n4fwba4-ruby3.2-builder-3.2.4/lib -L/nix/store/1f1n8vklwym6kvg1a7cd1ixp5qvwpc2m-ruby3.2-rdoc-6.6.3.1/lib -L/nix/store/bh4i6md622xm0zlihsc3rw0p7gl92wdw-ruby3.2-stringio-3.1.0/lib -L/nix/store/j0fw86s1kbjnamv8rlqrh2knknslyxp0-ruby3.2-railties-7.1.3.2/lib -L/nix/store/7cdx2hki4zijq0zlhmv0lia6fvq692ai-ruby3.2-actionview-7.1.3.2/lib -L/nix/store/6piqxnb9a4wdxkjsxb4b4l5b3ns8xqpa-ruby3.2-concurrent-ruby-1.2.3/lib -L/nix/store/l77q291mz8dkb83zgrc495s2xiqvz1by-ruby3.2-rackup-2.1.0/lib -L/nix/store/sff8nnynhdx00jg78cvjnd4lhzffnvi9-ruby3.2-base64-0.2.0/lib -L/nix/store/d1fywbqdrxpnw0azhwm2bk71p59y2yh1-ruby3.2-rack-session-2.0.0/lib -L/nix/store/x0v4dbsg72pzbhy213cvb1hc1ihibwqz-ruby3.2-reline-0.5.0/lib -L/nix/store/rr79s4pmk48d7y030s7g4d8qnc81d5xq-ruby3.2-rake-13.1.0/lib -L/nix/store/d47g6jv4d059amprcnyvn85j6mljj2dx-ruby3.2-drb-2.2.1/lib -L/nix/store/42xzn4c2269brd8a17z65skq031ym9b1-ruby3.2-i18n-1.14.4/lib -L/nix/store/6d0xkr7fbnd3ai639c1j43lmd04ybdxx-ruby3.2-rails-dom-testing-2.2.0/lib -L/nix/store/7yqii7pvvw124xn1f1jl0ilj5v7mn731-ruby3.2-rack-test-2.1.0/lib -L/nix/store/n14z5y2qmnqi3i0ax26h72kcwhclawnj-ruby3.2-bigdecimal-3.1.7/lib -L/nix/store/kysa37knwc6ncsjjy3a9gl80fjhsm726-ruby3.2-connection_pool-2.4.1/lib -L/nix/store/mkq3dvizjkgzy3m0ww9ssjhqrlb7pqry-ruby3.2-loofah-2.22.0/lib -fstack-protector-strong -rdynamic -Wl,-export-dynamic"
  CONFIG["CFLAGS"] = ""
  CONFIG["STRIP"] = "strip -S -x"
  CONFIG["RANLIB"] = "ranlib"
  CONFIG["OBJDUMP"] = "objdump"
  CONFIG["OBJCOPY"] = ":"
  CONFIG["NM"] = "nm"
  CONFIG["LD"] = "ld"
  CONFIG["CXX"] = "g++"
  CONFIG["AS"] = "as"
  CONFIG["AR"] = "ar"
  CONFIG["CC"] = "gcc"
  CONFIG["wasmoptflags"] = ""
  CONFIG["WASMOPT"] = ""
  CONFIG["target_os"] = "linux"
  CONFIG["target_vendor"] = "pc"
  CONFIG["target_cpu"] = "x86_64"
  CONFIG["target"] = "$(target_cpu)-$(target_vendor)-$(target_os)"
  CONFIG["host_os"] = "$(target_os)"
  CONFIG["host_vendor"] = "$(target_vendor)"
  CONFIG["host_cpu"] = "$(target_cpu)"
  CONFIG["host"] = "$(target)"
  CONFIG["build_os"] = "linux-gnu"
  CONFIG["build_vendor"] = "pc"
  CONFIG["build_cpu"] = "x86_64"
  CONFIG["build"] = "x86_64-pc-linux-gnu"
  CONFIG["RUBY_VERSION_NAME"] = "$(RUBY_BASE_NAME)-$(ruby_version)"
  CONFIG["RUBYW_BASE_NAME"] = "rubyw"
  CONFIG["RUBY_BASE_NAME"] = "ruby"
  CONFIG["RUBY_PROGRAM_VERSION"] = "$(MAJOR).$(MINOR).$(TEENY)"
  CONFIG["RUBY_API_VERSION"] = "$(MAJOR).$(MINOR)"
  CONFIG["HAVE_GIT"] = "yes"
  CONFIG["GIT"] = "git"
  CONFIG["cxxflags"] = ""
  CONFIG["cppflags"] = ""
  CONFIG["cflags"] = "$(optflags) $(debugflags) $(warnflags)"
  CONFIG["MAKEDIRS"] = "/nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/mkdir -p"
  CONFIG["target_alias"] = ""
  CONFIG["host_alias"] = "$(target_alias)"
  CONFIG["build_alias"] = ""
  CONFIG["LIBS"] = "-lm -lpthread "
  CONFIG["ECHO_T"] = ""
  CONFIG["ECHO_N"] = "-n"
  CONFIG["ECHO_C"] = ""
  CONFIG["DEFS"] = ""
  CONFIG["mandir"] = "$(datarootdir)/man"
  CONFIG["localedir"] = "$(datarootdir)/locale"
  CONFIG["libdir"] = "$(exec_prefix)/lib"
  CONFIG["psdir"] = "$(docdir)"
  CONFIG["pdfdir"] = "$(docdir)"
  CONFIG["dvidir"] = "$(docdir)"
  CONFIG["htmldir"] = "$(docdir)"
  CONFIG["infodir"] = "$(datarootdir)/info"
  CONFIG["docdir"] = "$(datarootdir)/doc/$(PACKAGE)"
  CONFIG["oldincludedir"] = "/usr/include"
  CONFIG["includedir"] = "$(prefix)/include"
  CONFIG["runstatedir"] = "$(localstatedir)/run"
  CONFIG["localstatedir"] = "$(prefix)/var"
  CONFIG["sharedstatedir"] = "$(prefix)/com"
  CONFIG["sysconfdir"] = "$(prefix)/etc"
  CONFIG["datadir"] = "$(datarootdir)"
  CONFIG["datarootdir"] = "$(prefix)/share"
  CONFIG["libexecdir"] = "$(exec_prefix)/libexec"
  CONFIG["sbindir"] = "$(exec_prefix)/sbin"
  CONFIG["bindir"] = "$(exec_prefix)/bin"
  CONFIG["exec_prefix"] = "$(prefix)"
  CONFIG["PACKAGE_URL"] = ""
  CONFIG["PACKAGE_BUGREPORT"] = ""
  CONFIG["PACKAGE_STRING"] = ""
  CONFIG["PACKAGE_VERSION"] = ""
  CONFIG["PACKAGE_TARNAME"] = ""
  CONFIG["PACKAGE_NAME"] = ""
  CONFIG["PATH_SEPARATOR"] = ":"
  CONFIG["SHELL"] = "/bin/bash"
  CONFIG["UNICODE_VERSION"] = "15.0.0"
  CONFIG["UNICODE_EMOJI_VERSION"] = "15.0"
  CONFIG["platform"] = "$(arch)"
  CONFIG["archdir"] = "$(rubyarchdir)"
  CONFIG["topdir"] = File.dirname(__FILE__)
  # Almost same with CONFIG. MAKEFILE_CONFIG has other variable
  # reference like below.
  #
  #   MAKEFILE_CONFIG["bindir"] = "$(exec_prefix)/bin"
  #
  # The values of this constant is used for creating Makefile.
  #
  #   require 'rbconfig'
  #
  #   print <<-END_OF_MAKEFILE
  #   prefix = #{RbConfig::MAKEFILE_CONFIG['prefix']}
  #   exec_prefix = #{RbConfig::MAKEFILE_CONFIG['exec_prefix']}
  #   bindir = #{RbConfig::MAKEFILE_CONFIG['bindir']}
  #   END_OF_MAKEFILE
  #
  #   => prefix = /usr/local
  #      exec_prefix = $(prefix)
  #      bindir = $(exec_prefix)/bin  MAKEFILE_CONFIG = {}
  #
  # RbConfig.expand is used for resolving references like above in rbconfig.
  #
  #   require 'rbconfig'
  #   p RbConfig.expand(RbConfig::MAKEFILE_CONFIG["bindir"])
  #   # => "/usr/local/bin"
  MAKEFILE_CONFIG = {}
  CONFIG.each{|k,v| MAKEFILE_CONFIG[k] = v.dup}

  # call-seq:
  #
  #   RbConfig.expand(val)         -> string
  #   RbConfig.expand(val, config) -> string
  #
  # expands variable with given +val+ value.
  #
  #   RbConfig.expand("$(bindir)") # => /home/foobar/all-ruby/ruby19x/bin
  def RbConfig::expand(val, config = CONFIG)
    newval = val.gsub(/\$\$|\$\(([^()]+)\)|\$\{([^{}]+)\}/) {
      var = $&
      if !(v = $1 || $2)
	'$'
      elsif key = config[v = v[/\A[^:]+(?=(?::(.*?)=(.*))?\z)/]]
	pat, sub = $1, $2
	config[v] = false
	config[v] = RbConfig::expand(key, config)
	key = key.gsub(/#{Regexp.quote(pat)}(?=\s|\z)/n) {sub} if pat
	key
      else
	var
      end
    }
    val.replace(newval) unless newval == val
    val
  end
  CONFIG.each_value do |val|
    RbConfig::expand(val)
  end

  # call-seq:
  #
  #   RbConfig.fire_update!(key, val)               -> array
  #   RbConfig.fire_update!(key, val, mkconf, conf) -> array
  #
  # updates +key+ in +mkconf+ with +val+, and all values depending on
  # the +key+ in +mkconf+.
  #
  #   RbConfig::MAKEFILE_CONFIG.values_at("CC", "LDSHARED") # => ["gcc", "$(CC) -shared"]
  #   RbConfig::CONFIG.values_at("CC", "LDSHARED")          # => ["gcc", "gcc -shared"]
  #   RbConfig.fire_update!("CC", "gcc-8")                  # => ["CC", "LDSHARED"]
  #   RbConfig::MAKEFILE_CONFIG.values_at("CC", "LDSHARED") # => ["gcc-8", "$(CC) -shared"]
  #   RbConfig::CONFIG.values_at("CC", "LDSHARED")          # => ["gcc-8", "gcc-8 -shared"]
  #
  # returns updated keys list, or +nil+ if nothing changed.
  def RbConfig.fire_update!(key, val, mkconf = MAKEFILE_CONFIG, conf = CONFIG) # :nodoc:
    return if mkconf[key] == val
    mkconf[key] = val
    keys = [key]
    deps = []
    begin
      re = Regexp.new("\\$\\((?:%1$s)\\)|\\$\\{(?:%1$s)\\}" % keys.join('|'))
      deps |= keys
      keys.clear
      mkconf.each {|k,v| keys << k if re =~ v}
    end until keys.empty?
    deps.each {|k| conf[k] = mkconf[k].dup}
    deps.each {|k| expand(conf[k])}
    deps
  end

  # call-seq:
  #
  #   RbConfig.ruby -> path
  #
  # returns the absolute pathname of the ruby command.
  def RbConfig.ruby
    File.join(
      RbConfig::CONFIG["bindir"],
      RbConfig::CONFIG["ruby_install_name"] + RbConfig::CONFIG["EXEEXT"]
    )
  end
end
CROSS_COMPILING = nil unless defined? CROSS_COMPILING
