export CLFS_HOST="x86_64-cross-linux-gnu"
export CLFS_TARGET="x86_64-unknown-linux-gnu"
export BUILD64="-m64"

export CC="${CLFS_TARGET}-gcc ${BUILD64}"
export CXX="${CLFS_TARGET}-g++ ${BUILD64}"
export AR="${CLFS_TARGET}-ar"
export AS="${CLFS_TARGET}-as"
export RANLIB="${CLFS_TARGET}-ranlib"
export LD="${CLFS_TARGET}-ld"
export STRIP="${CLFS_TARGET}-strip" 

 cd ${CLFS}
 cd build/
 mkdir chap6
 cd chap6
 tar xf $CLFS/sources/gmp-6.0.0a.tar.xz
 cd gmp-6.0.0/
 CC_FOR_BUILD=gcc ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --enable-cxx
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/mpfr-3.1.3.tar.xz
 cd mpfr-3.1.3/
 patch -Np1 -i $CLFS/sources/mpfr-3.1.3-fixes-1.patch
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/mpc-1.0.3.tar.gz
 cd mpc-1.0.3/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/isl-0.15.tar.xz
 cd isl-0.15/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/zlib-1.2.8.tar.xz
 cd zlib-1.2.8/
 ./configure --prefix=/tools
 make -j4
 make install
 cd ..
 history > history_1.log
 tar xf $CLFS/sources/binutils-2.25.1.tar.bz2
 cd binutils-2.25.1/
 mkdir -v ../binutils-build
 cd ../binutils-build
 ../binutils-2.25.1/configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --target=${CLFS_TARGET} --with-lib-path=/tools/lib --disable-nls --enable-shared --enable-64-bit-bfd --disable-multilib --enable-gold=yes --enable-plugins --enable-threads
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/gcc-5.3.0.tar.bz2
 cd gcc-5.3.0/
 patch -Np1 -i $CLFS/sources/gcc-5.3.0-pure64_specs-1.patch
 echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
 echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h
 cp -v gcc/Makefile.in{,.orig}
 sed 's@\./fixinc\.sh@-c true@' gcc/Makefile.in.orig > gcc/Makefile.in
 mkdir -v ../gcc-build
 cd ../gcc-build
 ../gcc-5.3.0/configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --target=${CLFS_TARGET} --with-local-prefix=/tools --disable-multilib --enable-languages=c,c++ --with-system-zlib --with-native-system-header-dir=/tools/include --disable-libssp --enable-install-libiberty
 make -j4 AS_FOR_TARGET="${AS}" LD_FOR_TARGET="${LD}"
 make install
 cd ..
 tar xf $CLFS/sources/ncurses-6.0.tar.gz
 cd ncurses-6.0/
 patch -Np1 -i $CLFS/sources/ncurses-mouse_trafo-warning.patch
 ./configure --prefix=/tools --with-shared --build=${CLFS_HOST} --host=${CLFS_TARGET} --without-debug --without-ada --enable-overwrite --with-build-cc=gcc
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/bash-4.3.tar.gz
 cd bash-4.3/
 patch -Np1 -i $CLFS/sources/bash-4.3-branch_update-5.patch
 cat > config.cache << "EOF"
ac_cv_func_mmap_fixed_mapped=yes
ac_cv_func_strcoll_works=yes
ac_cv_func_working_mktime=yes
bash_cv_func_sigsetjmp=present
bash_cv_getcwd_malloc=yes
bash_cv_job_control_missing=present
bash_cv_printf_a_format=yes
bash_cv_sys_named_pipes=present
bash_cv_ulimit_maxfds=yes
bash_cv_under_sys_siglist=yes
bash_cv_unusable_rtsigs=no
gt_cv_int_divbyzero_sigfpe=yes
EOF
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --without-bash-malloc --cache-file=config.cache
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/bzip2-1.0.6.tar.gz
 cd bzip2-1.0.6/
 cp -v Makefile{,.orig}
 sed -e 's@^\(all:.*\) test@\1@g' Makefile.orig > Makefile
 make -j4 CC="${CC}" AR="${AR}" RANLIB="${RANLIB}"
 make PREFIX=/tools install
 cd ..
 tar xf $CLFS/sources/check-0.10.0.tar.gz
 cd check-0.10.0/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/coreutils-8.23.tar.xz
 history > history_4.log
 cd coreutils-8.23/
cat > config.cache << EOF
fu_cv_sys_stat_statfs2_bsize=yes
gl_cv_func_working_mkstemp=yes
EOF
 patch -Np1 -i $CLFS/sources/coreutils-8.23-noman-1.patch
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --enable-install-program=hostname --cache-file=config.cache
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/diffutils-3.3.tar.xz
 cd diffutils-3.3/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/file-5.25.tar.gz
 cd file-5.25/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/findutils-4.4.2.tar.gz
 cd findutils-4.4.2/
 echo "gl_cv_func_wcwidth_works=yes" > config.cache
 echo "ac_cv_func_fnmatch_gnu=yes" >> config.cache
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --cache-file=config.cache
 make -j4
 make install
 cd ..
 history > history_4.log
 tar xf $CLFS/sources/gawk-4.1.3.tar.xz
 cd gawk-4.1.3/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/gettext-0.19.6.tar.xz
 cd gettext-0.19.6/
 cd gettext-tools
 EMACS="no" ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --disable-shared
 make -j4 -C gnulib-lib
 make -j4 -C intl pluralx.c
 make -j4 -C src msgfmt
 cp -v src/msgfmt /tools/bin
 cd ../../
 tar xf $CLFS/sources/grep-2.22.tar.xz
 cd grep-2.22/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --without-included-regex
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/gzip-1.6.tar.xz
 cd gzip-1.6/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/make-4.1.tar.bz2
 cd make-4.1/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/patch-2.7.5.tar.xz
 cd patch-2.7.5/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/sed-4.2.2.tar.bz2
 cd sed-4.2.2/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/tar-1.28.tar.xz
 cd tar-1.28/
 cat > config.cache << EOF
gl_cv_func_wcwidth_works=yes
gl_cv_func_btowc_eof=yes
ac_cv_func_malloc_0_nonnull=yes
gl_cv_func_mbrtowc_incomplete_state=yes
gl_cv_func_mbrtowc_nul_retval=yes
gl_cv_func_mbrtowc_null_arg1=yes
gl_cv_func_mbrtowc_null_arg2=yes
gl_cv_func_mbrtowc_retval=yes
gl_cv_func_wcrtomb_retval=yes
EOF
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --cache-file=config.cache
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/texinfo-6.0.tar.xz
 cd texinfo-6.0/
 history
 PERL=/usr/bin/perl ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 cd tools/info/
 ln -fs ../../info/makedoc
 cd ../..
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/util-linux-2.25.2.tar.xz
 cd util-linux-2.25.2/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET} --disable-makeinstall-chown --disable-makeinstall-setuid --without-python
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/vim-7.4.tar.bz2
 cd vim74/
 patch -Np1 -i $CLFS/sources/vim-7.4-branch_update-7.patch
 cat > src/auto/config.cache << "EOF"
vim_cv_getcwd_broken=no
vim_cv_memmove_handles_overlap=yes
vim_cv_stat_ignores_slash=no
vim_cv_terminfo=yes
vim_cv_toupper_broken=no
vim_cv_tty_group=world
EOF
 echo '#define SYS_VIMRC_FILE "/tools/etc/vimrc"' >> src/feature.h
 ./configure --build=${CLFS_HOST} --host=${CLFS_TARGET} --prefix=/tools --enable-gui=no --disable-gtktest --disable-xim --disable-gpm --without-x --disable-netbeans --with-tlib=ncurses
 make -j4
 make install
 ln -sv vim /tools/bin/vi
 cat > /tools/etc/vimrc << "EOF"
 " Begin /tools/etc/vimrc

 nocompatible
 backspace=2
 ruler
 on

 " End /tools/etc/vimrc
EOF
 cd ..
 tar xf $CLFS/sources/xz-5.2.2.tar.xz
 cd xz-5.2.2/
 ./configure --prefix=/tools --build=${CLFS_HOST} --host=${CLFS_TARGET}
 make -j4
 make install
 cd ..
