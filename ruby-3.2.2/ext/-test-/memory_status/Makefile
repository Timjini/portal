# ***DUMMY MAKEFILE***

SHELL = /bin/sh

# V=0 quiet, V=1 verbose.  other values don't work.
V = 0
V0 = $(V:0=)
Q1 = $(V:1=)
Q = $(Q1:0=@)
ECHO1 = $(V:1=@ :)
ECHO = $(ECHO1:0=@ echo)
NULLCMD = :

#### Start of system configuration section. ####
top_srcdir = $(topdir)/.
srcdir = $(top_srcdir)/ext/-test-/memory_status
topdir = ../../..
hdrdir = $(top_srcdir)/include
arch_hdrdir = $(extout)/include/$(arch)
PATH_SEPARATOR = :
VPATH = $(srcdir):$(arch_hdrdir)/ruby:$(hdrdir)/ruby
RUBYLIB =
RUBYOPT = -
prefix = $(DESTDIR)/home/runner/.rubies/ruby-3.2.2
rubysitearchprefix = $(rubylibprefix)/$(sitearch)
rubyarchprefix = $(rubylibprefix)/$(arch)
rubylibprefix = $(libdir)/$(RUBY_BASE_NAME)
exec_prefix = $(prefix)
vendorarchhdrdir = $(vendorhdrdir)/$(sitearch)
sitearchhdrdir = $(sitehdrdir)/$(sitearch)
rubyarchhdrdir = $(rubyhdrdir)/$(arch)
vendorhdrdir = $(rubyhdrdir)/vendor_ruby
sitehdrdir = $(rubyhdrdir)/site_ruby
rubyhdrdir = $(includedir)/$(RUBY_VERSION_NAME)
vendorarchdir = $(vendorlibdir)/$(sitearch)
vendorlibdir = $(vendordir)/$(ruby_version)
vendordir = $(rubylibprefix)/vendor_ruby
sitearchdir = $(sitelibdir)/$(sitearch)
sitelibdir = $(sitedir)/$(ruby_version)
sitedir = $(rubylibprefix)/site_ruby
rubyarchdir = $(rubylibdir)/$(arch)
rubylibdir = $(rubylibprefix)/$(ruby_version)
sitearchincludedir = $(includedir)/$(sitearch)
archincludedir = $(includedir)/$(arch)
sitearchlibdir = $(libdir)/$(sitearch)
archlibdir = $(libdir)/$(arch)
ridir = $(datarootdir)/$(RI_BASE_NAME)
mandir = $(datarootdir)/man
localedir = $(datarootdir)/locale
libdir = $(exec_prefix)/lib
psdir = $(docdir)
pdfdir = $(docdir)
dvidir = $(docdir)
htmldir = $(docdir)
infodir = $(datarootdir)/info
docdir = $(datarootdir)/doc/$(PACKAGE)
oldincludedir = $(DESTDIR)/usr/include
includedir = $(prefix)/include
runstatedir = $(localstatedir)/run
localstatedir = $(prefix)/var
sharedstatedir = $(prefix)/com
sysconfdir = $(prefix)/etc
datadir = $(datarootdir)
datarootdir = $(prefix)/share
libexecdir = $(exec_prefix)/libexec
sbindir = $(exec_prefix)/sbin
bindir = $(exec_prefix)/bin
archdir = $(rubyarchdir)


CC_WRAPPER = 
CC = gcc
CXX = g++
LIBRUBY = $(LIBRUBY_A)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -Wl,-rpath,$(libdir) -L$(libdir) 
LIBRUBYARG_STATIC = -Wl,-rpath,$(libdir) -L$(libdir) -l$(RUBY_SO_NAME)-static $(MAINLIBS)
empty =
OUTFLAG = -o $(empty)
COUTFLAG = -o $(empty)
CSRCFLAG = $(empty)

RUBY_EXTCONF_H = 
cflags   = $(optflags) $(debugflags) $(warnflags)
cxxflags = 
optflags = -O3 -fno-fast-math
debugflags = -ggdb3
warnflags = -Wall -Wextra -Wdeprecated-declarations -Wdiv-by-zero -Wduplicated-cond -Wimplicit-function-declaration -Wimplicit-int -Wmisleading-indentation -Wpointer-arith -Wwrite-strings -Wold-style-definition -Wimplicit-fallthrough=0 -Wmissing-noreturn -Wno-cast-function-type -Wno-constant-logical-operand -Wno-long-long -Wno-missing-field-initializers -Wno-overlength-strings -Wno-packed-bitfield-compat -Wno-parentheses-equality -Wno-self-assign -Wno-tautological-compare -Wno-unused-parameter -Wno-unused-value -Wsuggest-attribute=format -Wsuggest-attribute=noreturn -Wunused-variable -Wundef
cppflags = 
CCDLFLAGS = -fPIC
CFLAGS   = $(CCDLFLAGS)  $(ARCH_FLAG)
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir) -I$(srcdir)
DEFS     = 
CPPFLAGS =   $(DEFS) $(cppflags)
CXXFLAGS = $(CCDLFLAGS)  $(ARCH_FLAG)
ldflags  = -L. -L/nix/store/im4zgh092kphdqwwdcv46hqrilg9zkp2-ruby3.2-io-console-0.7.2/lib -L/nix/store/hszhyccxkl3klidixsnrv72d20hbpf70-ruby3.2-zeitwerk-2.6.13/lib -L/nix/store/8qmsl40rak8h8nqshnjl9c9sa2pwmhhn-ruby3.2-mutex_m-0.2.0/lib -L/nix/store/a2yx8rqdb3ilfm3mssrf5a0la7bwsf83-ruby3.2-rack-3.0.10/lib -L/nix/store/n2vsaszmwq5lnzp7v127ab2604l2disq-ruby3.2-irb-1.12.0/lib -L/nix/store/89020cz4p82vi66rckl23wq4llpg134g-ruby3.2-psych-5.1.2/lib -L/nix/store/dlcspccydmqd9qljclfqdggzzvxdvy01-ruby3.2-thor-1.3.1/lib -L/nix/store/c8r9gjvd6mz59lbk0jvkj3vs55ybjcm2-ruby3.2-mini_portile2-2.8.5/lib -L/nix/store/3ai2b07ybl4aba9jcmjyaps26bim2avb-ruby3.2-crass-1.0.6/lib -L/nix/store/gv6ahkd40a581p98nhqhyr8kxgb3z76b-ruby3.2-webrick-1.8.1/lib -L/nix/store/25xk1dw6wvysya4lk2llfamb3krw9912-ruby3.2-actionpack-7.1.3.2/lib -L/nix/store/cqgi9z0zxcrzqm6mqn7nf9s16ckl9b0h-ruby3.2-minitest-5.22.3/lib -L/nix/store/9h8dg1m7qbbnif4v8vsypw6dsb7y83r0-ruby3.2-nokogiri-1.16.3/lib -L/nix/store/5p92ch4zxg2pcf43sdbxfdsnh0b3c7ma-ruby3.2-activesupport-7.1.3.2/lib -L/nix/store/cxcdlbl4i2fwy9ffwvz3lrgwzzvlzx8h-ruby3.2-erubi-1.12.0/lib -L/nix/store/9p2g93d1hraa9lkjf0ikrdvk3v22h79c-ruby3.2-racc-1.7.3/lib -L/nix/store/i9wz0rm6wbk0j1ycpx6fjnlvjn8sndiw-ruby3.2-rails-html-sanitizer-1.6.0/lib -L/nix/store/1cm9zjr32qcfizcpcjm6c9k5llnjwphx-ruby3.2-tzinfo-2.0.6/lib -L/nix/store/4djagqamg5bxxxr9dywzmk9b7n4fwba4-ruby3.2-builder-3.2.4/lib -L/nix/store/1f1n8vklwym6kvg1a7cd1ixp5qvwpc2m-ruby3.2-rdoc-6.6.3.1/lib -L/nix/store/bh4i6md622xm0zlihsc3rw0p7gl92wdw-ruby3.2-stringio-3.1.0/lib -L/nix/store/j0fw86s1kbjnamv8rlqrh2knknslyxp0-ruby3.2-railties-7.1.3.2/lib -L/nix/store/7cdx2hki4zijq0zlhmv0lia6fvq692ai-ruby3.2-actionview-7.1.3.2/lib -L/nix/store/6piqxnb9a4wdxkjsxb4b4l5b3ns8xqpa-ruby3.2-concurrent-ruby-1.2.3/lib -L/nix/store/l77q291mz8dkb83zgrc495s2xiqvz1by-ruby3.2-rackup-2.1.0/lib -L/nix/store/sff8nnynhdx00jg78cvjnd4lhzffnvi9-ruby3.2-base64-0.2.0/lib -L/nix/store/d1fywbqdrxpnw0azhwm2bk71p59y2yh1-ruby3.2-rack-session-2.0.0/lib -L/nix/store/x0v4dbsg72pzbhy213cvb1hc1ihibwqz-ruby3.2-reline-0.5.0/lib -L/nix/store/rr79s4pmk48d7y030s7g4d8qnc81d5xq-ruby3.2-rake-13.1.0/lib -L/nix/store/d47g6jv4d059amprcnyvn85j6mljj2dx-ruby3.2-drb-2.2.1/lib -L/nix/store/42xzn4c2269brd8a17z65skq031ym9b1-ruby3.2-i18n-1.14.4/lib -L/nix/store/6d0xkr7fbnd3ai639c1j43lmd04ybdxx-ruby3.2-rails-dom-testing-2.2.0/lib -L/nix/store/7yqii7pvvw124xn1f1jl0ilj5v7mn731-ruby3.2-rack-test-2.1.0/lib -L/nix/store/n14z5y2qmnqi3i0ax26h72kcwhclawnj-ruby3.2-bigdecimal-3.1.7/lib -L/nix/store/kysa37knwc6ncsjjy3a9gl80fjhsm726-ruby3.2-connection_pool-2.4.1/lib -L/nix/store/mkq3dvizjkgzy3m0ww9ssjhqrlb7pqry-ruby3.2-loofah-2.22.0/lib -fstack-protector-strong -rdynamic -Wl,-export-dynamic
dldflags = -L/nix/store/im4zgh092kphdqwwdcv46hqrilg9zkp2-ruby3.2-io-console-0.7.2/lib -L/nix/store/hszhyccxkl3klidixsnrv72d20hbpf70-ruby3.2-zeitwerk-2.6.13/lib -L/nix/store/8qmsl40rak8h8nqshnjl9c9sa2pwmhhn-ruby3.2-mutex_m-0.2.0/lib -L/nix/store/a2yx8rqdb3ilfm3mssrf5a0la7bwsf83-ruby3.2-rack-3.0.10/lib -L/nix/store/n2vsaszmwq5lnzp7v127ab2604l2disq-ruby3.2-irb-1.12.0/lib -L/nix/store/89020cz4p82vi66rckl23wq4llpg134g-ruby3.2-psych-5.1.2/lib -L/nix/store/dlcspccydmqd9qljclfqdggzzvxdvy01-ruby3.2-thor-1.3.1/lib -L/nix/store/c8r9gjvd6mz59lbk0jvkj3vs55ybjcm2-ruby3.2-mini_portile2-2.8.5/lib -L/nix/store/3ai2b07ybl4aba9jcmjyaps26bim2avb-ruby3.2-crass-1.0.6/lib -L/nix/store/gv6ahkd40a581p98nhqhyr8kxgb3z76b-ruby3.2-webrick-1.8.1/lib -L/nix/store/25xk1dw6wvysya4lk2llfamb3krw9912-ruby3.2-actionpack-7.1.3.2/lib -L/nix/store/cqgi9z0zxcrzqm6mqn7nf9s16ckl9b0h-ruby3.2-minitest-5.22.3/lib -L/nix/store/9h8dg1m7qbbnif4v8vsypw6dsb7y83r0-ruby3.2-nokogiri-1.16.3/lib -L/nix/store/5p92ch4zxg2pcf43sdbxfdsnh0b3c7ma-ruby3.2-activesupport-7.1.3.2/lib -L/nix/store/cxcdlbl4i2fwy9ffwvz3lrgwzzvlzx8h-ruby3.2-erubi-1.12.0/lib -L/nix/store/9p2g93d1hraa9lkjf0ikrdvk3v22h79c-ruby3.2-racc-1.7.3/lib -L/nix/store/i9wz0rm6wbk0j1ycpx6fjnlvjn8sndiw-ruby3.2-rails-html-sanitizer-1.6.0/lib -L/nix/store/1cm9zjr32qcfizcpcjm6c9k5llnjwphx-ruby3.2-tzinfo-2.0.6/lib -L/nix/store/4djagqamg5bxxxr9dywzmk9b7n4fwba4-ruby3.2-builder-3.2.4/lib -L/nix/store/1f1n8vklwym6kvg1a7cd1ixp5qvwpc2m-ruby3.2-rdoc-6.6.3.1/lib -L/nix/store/bh4i6md622xm0zlihsc3rw0p7gl92wdw-ruby3.2-stringio-3.1.0/lib -L/nix/store/j0fw86s1kbjnamv8rlqrh2knknslyxp0-ruby3.2-railties-7.1.3.2/lib -L/nix/store/7cdx2hki4zijq0zlhmv0lia6fvq692ai-ruby3.2-actionview-7.1.3.2/lib -L/nix/store/6piqxnb9a4wdxkjsxb4b4l5b3ns8xqpa-ruby3.2-concurrent-ruby-1.2.3/lib -L/nix/store/l77q291mz8dkb83zgrc495s2xiqvz1by-ruby3.2-rackup-2.1.0/lib -L/nix/store/sff8nnynhdx00jg78cvjnd4lhzffnvi9-ruby3.2-base64-0.2.0/lib -L/nix/store/d1fywbqdrxpnw0azhwm2bk71p59y2yh1-ruby3.2-rack-session-2.0.0/lib -L/nix/store/x0v4dbsg72pzbhy213cvb1hc1ihibwqz-ruby3.2-reline-0.5.0/lib -L/nix/store/rr79s4pmk48d7y030s7g4d8qnc81d5xq-ruby3.2-rake-13.1.0/lib -L/nix/store/d47g6jv4d059amprcnyvn85j6mljj2dx-ruby3.2-drb-2.2.1/lib -L/nix/store/42xzn4c2269brd8a17z65skq031ym9b1-ruby3.2-i18n-1.14.4/lib -L/nix/store/6d0xkr7fbnd3ai639c1j43lmd04ybdxx-ruby3.2-rails-dom-testing-2.2.0/lib -L/nix/store/7yqii7pvvw124xn1f1jl0ilj5v7mn731-ruby3.2-rack-test-2.1.0/lib -L/nix/store/n14z5y2qmnqi3i0ax26h72kcwhclawnj-ruby3.2-bigdecimal-3.1.7/lib -L/nix/store/kysa37knwc6ncsjjy3a9gl80fjhsm726-ruby3.2-connection_pool-2.4.1/lib -L/nix/store/mkq3dvizjkgzy3m0ww9ssjhqrlb7pqry-ruby3.2-loofah-2.22.0/lib -Wl,--compress-debug-sections=zlib 
ARCH_FLAG = 
DLDFLAGS = $(ldflags) $(dldflags) $(ARCH_FLAG)
LDSHARED = $(CC) -shared
LDSHAREDXX = $(CXX) -shared
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = $(RUBY_BASE_NAME)
RUBY_SO_NAME = ruby
RUBYW_INSTALL_NAME = 
RUBY_VERSION_NAME = $(RUBY_BASE_NAME)-$(ruby_version)
RUBYW_BASE_NAME = rubyw
RUBY_BASE_NAME = ruby

arch = x86_64-linux
sitearch = $(arch)
ruby_version = 3.2.0
ruby = $(topdir)/miniruby -I'$(topdir)' -I'$(top_srcdir)/lib' -I'$(extout)/$(arch)' -I'$(extout)/common'
RUBY = $(ruby)
BUILTRUBY = $(topdir)/miniruby
ruby_headers = $(hdrdir)/ruby.h $(hdrdir)/ruby/backward.h $(hdrdir)/ruby/ruby.h $(hdrdir)/ruby/defines.h $(hdrdir)/ruby/missing.h $(hdrdir)/ruby/intern.h $(hdrdir)/ruby/st.h $(hdrdir)/ruby/subst.h $(arch_hdrdir)/ruby/config.h

RM = rm -f
RM_RF = rm -fr
RMDIRS = rmdir --ignore-fail-on-non-empty -p
MAKEDIRS = /nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/mkdir -p
INSTALL = /nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp
TOUCH = exit >

#### End of system configuration section. ####

preload = 
EXTSO = 
CLEANFILES = mkmf.log
DISTCLEANFILES = 

all install static install-so install-rb: Makefile
	@$(NULLCMD)
.PHONY: all install static install-so install-rb
.PHONY: clean clean-so clean-static clean-rb


clean-static::
clean-rb-default::
clean-rb::
clean-so::
clean: clean-so clean-static clean-rb-default clean-rb
		-$(Q)$(RM_RF) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES) .*.time

distclean-rb-default::
distclean-rb::
distclean-so::
distclean-static::
distclean: clean distclean-so distclean-static distclean-rb-default distclean-rb
		-$(Q)$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log exts.mk
		-$(Q)$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)
		-$(Q)$(RMDIRS) $(DISTCLEANDIRS) 2> /dev/null || true

realclean: distclean
