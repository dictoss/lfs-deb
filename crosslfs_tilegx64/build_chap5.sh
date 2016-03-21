export CLFS_HOST="x86_64-cross-linux-gnu"
export CLFS_TARGET="tilegx-unknown-linux-gnu"
export CLFS_TARGET_PKG="tilegx-unknown-linux-gnu"
export BUILD64="-m64"
export MY_CLFS_ARCH="tilegx"

unset CC
unset CXX
unset AR
unset AS
unset RANLIB
unset LD
unset STRIP

pwd
chown -fR clfs:clfs $CLFS
cd $CLFS 
pwd
mkdir -p build
 cd build/
 mkdir chap5
 cd chap5/
 tar xf $CLFS/sources/file-5.25.tar.gz
 cd file-5.25/
 ./configure --prefix=/cross-tools
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/linux-4.1.tar.xz
 cd linux-4.1/
 xzcat $CLFS/sources/patch-4.1.7.xz | patch -Np1 -i -
 make mrproper
 make ARCH=$MY_CLFS_ARCH headers_check
 make ARCH=$MY_CLFS_ARCH INSTALL_HDR_PATH=/tools headers_install
 cd ..
 tar xf $CLFS/sources/m4-1.4.17.tar.xz
 ./configure --prefix=/cross-tools
 cd m4-1.4.17/
 ./configure --prefix=/cross-tools
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/ncurses-6.0.tar.gz
 cd ncurses-6.0/
 AWK=gawk ./configure --prefix=/cross-tools --without-debug
 make -C include
 make -C progs tic
 install -v -m755 progs/tic /cross-tools/bin
 cd ..
 tar xf $CLFS/sources/pkg-config-lite-0.28-1.tar.gz
 cd pkg-config-lite-0.28-1/
 ./configure --prefix=/cross-tools --host=${CLFS_TARGET_PKG} --with-pc-path=/tools/lib/pkgconfig:/tools/share/pkgconfig
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/gmp-6.0.0a.tar.xz
 cd gmp-6.0.0/
 ./configure --prefix=/cross-tools --enable-cxx --disable-static
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/mpfr-3.1.3.tar.xz
 cd mpfr-3.1.3/
 patch -Np1 -i $CLFS/sources/mpfr-3.1.3-fixes-1.patch
 LDFLAGS="-Wl,-rpath,/cross-tools/lib" ./configure --prefix=/cross-tools --disable-static --with-gmp=/cross-tools
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/mpc-1.0.3.tar.gz
 cd mpc-1.0.3/
 LDFLAGS="-Wl,-rpath,/cross-tools/lib" ./configure --prefix=/cross-tools --disable-static --with-gmp=/cross-tools --with-mpfr=/cross-tools
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/isl-0.15.tar.xz
 cd isl-0.15/
 LDFLAGS="-Wl,-rpath,/cross-tools/lib" ./configure --prefix=/cross-tools --disable-static --with-gmp-prefix=/cross-tools
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/binutils-2.25.1.tar.bz2
 cd binutils-2.25.1/
 mkdir -v ../binutils-build
 cd ../binutils-build
 AR=ar AS=as ../binutils-2.25.1/configure --prefix=/cross-tools --host=${CLFS_HOST} --target=${CLFS_TARGET} --with-sysroot=${CLFS} --with-lib-path=/tools/lib --disable-nls --disable-static --enable-64-bit-bfd --disable-multilib --enable-gold=yes --enable-plugins --enable-threads --disable-werror
 make -j4
 make install
 cd ..
 tar xf $CLFS/sources/gcc-5.3.0.tar.bz2
 cd gcc-5.3.0/
 patch -Np1 -i $CLFS/sources/gcc-5.3.0-pure64_specs-1.patch
 echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
 echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h
 touch /tools/include/limits.h
 mkdir -v ../gcc-build
 cd ../gcc-build
 AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" ../gcc-5.3.0/configure --prefix=/cross-tools --build=${CLFS_HOST} --host=${CLFS_HOST} --target=${CLFS_TARGET} --with-sysroot=${CLFS} --with-local-prefix=/tools --with-native-system-header-dir=/tools/include --disable-shared --with-mpfr=/cross-tools --with-gmp=/cross-tools --with-isl=/cross-tools --with-mpc=/cross-tools --without-headers --with-newlib --disable-decimal-float --disable-libgomp --disable-libssp --disable-libatomic --disable-libitm --disable-libsanitizer --disable-libquadmath --disable-libvtv --disable-libcilkrts --disable-libstdc++-v3 --disable-threads --disable-multilib --with-system-zlib --enable-languages=c --with-glibc-version=2.22
 make -j4 all-gcc all-target-libgcc
 make install-gcc install-target-libgcc
 cd ..
 tar xf $CLFS/sources/glibc-2.22.tar.xz
 cd glibc-2.22/
 mkdir -v ../glibc-build
 cd ../glibc-build
 BUILD_CC="gcc" CC="${CLFS_TARGET}-gcc ${BUILD64}" AR="${CLFS_TARGET}-ar" RANLIB="${CLFS_TARGET}-ranlib" ../glibc-2.22/configure --prefix=/tools --host=${CLFS_TARGET} --build=${CLFS_HOST} --enable-kernel=2.6.32 --with-binutils=/cross-tools/bin --with-headers=/tools/include --enable-obsolete-rpc
 make -j4
 make install
 cd ..
 rm -fr gcc-build_1 gcc-5.3.0_1
 mv gcc-build gcc-build_1
 mv gcc-5.3.0 gcc-5.3.0_1
 tar xf $CLFS/sources/gcc-5.3.0.tar.bz2
 cd gcc-5.3.0
 patch -Np1 -i $CLFS/sources/gcc-5.3.0-pure64_specs-1.patch
 echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
 echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h
 mkdir -v ../gcc-build
 cd ../gcc-build
 AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" ../gcc-5.3.0/configure --prefix=/cross-tools --build=${CLFS_HOST} --target=${CLFS_TARGET} --host=${CLFS_HOST} --with-sysroot=${CLFS} --with-local-prefix=/tools --with-native-system-header-dir=/tools/include --disable-nls --disable-static --enable-languages=c,c++ --disable-multilib --with-mpc=/cross-tools --with-mpfr=/cross-tools --with-gmp=/cross-tools --with-isl=/cross-tools --with-system-zlib
 make -j4 AS_FOR_TARGET="${CLFS_TARGET}-as" LD_FOR_TARGET="${CLFS_TARGET}-ld"
 make install
 cd ..
echo ""
echo "chapter 5 done."
