#ifndef RUBY_MJIT_CONFIG_H
#define RUBY_MJIT_CONFIG_H 1

#ifdef LOAD_RELATIVE
#define MJIT_HEADER_INSTALL_DIR "/include/ruby-3.2.0/x86_64-linux"
#else
#define MJIT_HEADER_INSTALL_DIR "/home/runner/.rubies/ruby-3.2.2/include/ruby-3.2.0/x86_64-linux"
#endif
#define MJIT_MIN_HEADER_NAME "rb_mjit_min_header-3.2.2.h"
#define MJIT_CC_COMMON   "/nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/gcc",
#define MJIT_CFLAGS      MJIT_ARCHFLAG "-w",
#define MJIT_OPTFLAGS    "-O3", "-fno-fast-math",
#define MJIT_DEBUGFLAGS  "-ggdb3",
#define MJIT_LDSHARED    "/nix/store/87s2rsdjfkgc26m9k878avxawsz2i8ng-replit-runtime-path/bin/gcc", "-shared",
#define MJIT_DLDFLAGS    MJIT_ARCHFLAG "-L/nix/store/im4zgh092kphdqwwdcv46hqrilg9zkp2-ruby3.2-io-console-0.7.2/lib", "-L/nix/store/hszhyccxkl3klidixsnrv72d20hbpf70-ruby3.2-zeitwerk-2.6.13/lib", "-L/nix/store/8qmsl40rak8h8nqshnjl9c9sa2pwmhhn-ruby3.2-mutex_m-0.2.0/lib", "-L/nix/store/a2yx8rqdb3ilfm3mssrf5a0la7bwsf83-ruby3.2-rack-3.0.10/lib", "-L/nix/store/n2vsaszmwq5lnzp7v127ab2604l2disq-ruby3.2-irb-1.12.0/lib", "-L/nix/store/89020cz4p82vi66rckl23wq4llpg134g-ruby3.2-psych-5.1.2/lib", "-L/nix/store/dlcspccydmqd9qljclfqdggzzvxdvy01-ruby3.2-thor-1.3.1/lib", "-L/nix/store/c8r9gjvd6mz59lbk0jvkj3vs55ybjcm2-ruby3.2-mini_portile2-2.8.5/lib", "-L/nix/store/3ai2b07ybl4aba9jcmjyaps26bim2avb-ruby3.2-crass-1.0.6/lib", "-L/nix/store/gv6ahkd40a581p98nhqhyr8kxgb3z76b-ruby3.2-webrick-1.8.1/lib", "-L/nix/store/25xk1dw6wvysya4lk2llfamb3krw9912-ruby3.2-actionpack-7.1.3.2/lib", "-L/nix/store/cqgi9z0zxcrzqm6mqn7nf9s16ckl9b0h-ruby3.2-minitest-5.22.3/lib", "-L/nix/store/9h8dg1m7qbbnif4v8vsypw6dsb7y83r0-ruby3.2-nokogiri-1.16.3/lib", "-L/nix/store/5p92ch4zxg2pcf43sdbxfdsnh0b3c7ma-ruby3.2-activesupport-7.1.3.2/lib", "-L/nix/store/cxcdlbl4i2fwy9ffwvz3lrgwzzvlzx8h-ruby3.2-erubi-1.12.0/lib", "-L/nix/store/9p2g93d1hraa9lkjf0ikrdvk3v22h79c-ruby3.2-racc-1.7.3/lib", "-L/nix/store/i9wz0rm6wbk0j1ycpx6fjnlvjn8sndiw-ruby3.2-rails-html-sanitizer-1.6.0/lib", "-L/nix/store/1cm9zjr32qcfizcpcjm6c9k5llnjwphx-ruby3.2-tzinfo-2.0.6/lib", "-L/nix/store/4djagqamg5bxxxr9dywzmk9b7n4fwba4-ruby3.2-builder-3.2.4/lib", "-L/nix/store/1f1n8vklwym6kvg1a7cd1ixp5qvwpc2m-ruby3.2-rdoc-6.6.3.1/lib", "-L/nix/store/bh4i6md622xm0zlihsc3rw0p7gl92wdw-ruby3.2-stringio-3.1.0/lib", "-L/nix/store/j0fw86s1kbjnamv8rlqrh2knknslyxp0-ruby3.2-railties-7.1.3.2/lib", "-L/nix/store/7cdx2hki4zijq0zlhmv0lia6fvq692ai-ruby3.2-actionview-7.1.3.2/lib", "-L/nix/store/6piqxnb9a4wdxkjsxb4b4l5b3ns8xqpa-ruby3.2-concurrent-ruby-1.2.3/lib", "-L/nix/store/l77q291mz8dkb83zgrc495s2xiqvz1by-ruby3.2-rackup-2.1.0/lib", "-L/nix/store/sff8nnynhdx00jg78cvjnd4lhzffnvi9-ruby3.2-base64-0.2.0/lib", "-L/nix/store/d1fywbqdrxpnw0azhwm2bk71p59y2yh1-ruby3.2-rack-session-2.0.0/lib", "-L/nix/store/x0v4dbsg72pzbhy213cvb1hc1ihibwqz-ruby3.2-reline-0.5.0/lib", "-L/nix/store/rr79s4pmk48d7y030s7g4d8qnc81d5xq-ruby3.2-rake-13.1.0/lib", "-L/nix/store/d47g6jv4d059amprcnyvn85j6mljj2dx-ruby3.2-drb-2.2.1/lib", "-L/nix/store/42xzn4c2269brd8a17z65skq031ym9b1-ruby3.2-i18n-1.14.4/lib", "-L/nix/store/6d0xkr7fbnd3ai639c1j43lmd04ybdxx-ruby3.2-rails-dom-testing-2.2.0/lib", "-L/nix/store/7yqii7pvvw124xn1f1jl0ilj5v7mn731-ruby3.2-rack-test-2.1.0/lib", "-L/nix/store/n14z5y2qmnqi3i0ax26h72kcwhclawnj-ruby3.2-bigdecimal-3.1.7/lib", "-L/nix/store/kysa37knwc6ncsjjy3a9gl80fjhsm726-ruby3.2-connection_pool-2.4.1/lib", "-L/nix/store/mkq3dvizjkgzy3m0ww9ssjhqrlb7pqry-ruby3.2-loofah-2.22.0/lib", "-Wl,--compress-debug-sections=zlib",
#define MJIT_LIBS        "-Wl,-rpath,/home/runner/.rubies/ruby-3.2.2/lib", "-L/home/runner/.rubies/ruby-3.2.2/lib",
#define PRELOADENV       "LD_PRELOAD"
#define MJIT_ARCHFLAG    /* no flag */

#endif /* RUBY_MJIT_CONFIG_H */
