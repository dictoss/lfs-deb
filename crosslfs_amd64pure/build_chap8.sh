 cd $CLFS
 mkdir chap8
 cd chap8
 mkdir -pv ${CLFS}/{dev,proc,run,sys}
 mknod -m 600 ${CLFS}/dev/console c 5 1
 sudo mknod -m 600 ${CLFS}/dev/console c 5 1
 sudo mknod -m 666 ${CLFS}/dev/null c 1 3
 sudo mount -v -o bind /dev ${CLFS}/dev
 sudo mount -vt devpts -o gid=5,mode=620 devpts ${CLFS}/dev/pts
 sudo mount -vt proc proc ${CLFS}/proc
 sudo mount -vt tmpfs tmpfs ${CLFS}/run
 sudo mount -vt sysfs sysfs ${CLFS}/sys
 [ -h ${CLFS}/dev/shm ] && mkdir -pv ${CLFS}/$(readlink ${CLFS}/dev/shm)

chroot "${CLFS}" /tools/bin/env -i \
    HOME=/root TERM="${TERM}" PS1='\u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h

 chown -Rv 0:0 /tools
 chown -Rv 0:0 /cross-tools
 ls
 mkdir -pv /{bin,boot,dev,{etc/,}opt,home,lib,mnt}
 mkdir -pv /{proc,media/{floppy,cdrom},run/shm,sbin,srv,sys}
 mkdir -pv /var/{lock,log,mail,spool}
 ls
 mkdir -pv /var/{opt,cache,lib/{misc,locate},local}
 install -dv -m 0750 /root
 install -dv -m 1777 {/var,}/tmp
 n -sv ../run /var/run
 n -sv ../run /var/run~l
 ln -sv ../run /var/run
 mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
 mkdir -pv /usr/{,local/}share/{doc,info,locale,man}
 mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
 mkdir -pv /usr/{,local/}share/man/man{1..8}
 ln -sv /tools/bin/{bash,cat,echo,grep,pwd,stty} /bin
 ln -sv /tools/bin/file /usr/bin
 ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
 ln -sv /tools/lib/libstdc++.so{.6,} /usr/lib
 sed -e 's/tools/usr/' /tools/lib/libstdc++.la > /usr/lib/libstdc++.la
 ln -sv bash /bin/sh
 ln -sv /proc/self/mounts /etc/mtab
 export BUILD64="-m64"
 echo export BUILD64=\""${BUILD64}\"" >> ~/.bash_profile
 cat > /etc/passwd << "EOF"
 root:x:0:0:root:/root:/bin/bash
 bin:x:1:1:/bin:/bin/false
 daemon:x:2:6:/sbin:/bin/false
 messagebus:x:27:27:D-Bus Message Daemon User:/dev/null:/bin/false
 nobody:x:65534:65533:Unprivileged User:/dev/null:/bin/false
 EOF
 cat > /etc/group << "EOF"
 root:x:0:
 bin:x:1:
 sys:x:2:
 kmem:x:3:
 tty:x:5:
 tape:x:4:
 daemon:x:6:
 floppy:x:7:
 disk:x:8:
 lp:x:9:
 dialout:x:10:
 audio:x:11:
 video:x:12:
 utmp:x:13:
 usb:x:14:
 cdrom:x:15:
 adm:x:16:
 messagebus:x:27:
 mail:x:30:
 wheel:x:39:
 nogroup:x:65533:
 EOF
 touch /var/log/{btmp,faillog,lastlog,wtmp}
 chgrp -v utmp /var/log/{faillog,lastlog}
 chmod -v 664 /var/log/{faillog,lastlog}
 chmod -v 600 /var/log/btmp
 exit
