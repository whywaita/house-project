# ref: http://takuya-1st.hatenablog.jp/entry/20120318/1332056474

#!/usr/bin/env bash
#uninstall
# sudo apt-get remove ffmpeg x264 libx264-dev -y
sudo apt-get remove ffmpeg -y
## install build-tools and library
sudo apt-get update
sudo apt-get install build-essential checkinstall git libfaac-dev libjack-jackd2-dev \
  libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev \
  libva-dev libvdpau-dev libvorbis-dev libx11-dev libxfixes-dev texi2html yasm zlib1g-dev
sudo apt-get install libtool automake autoconf checkinstall libtheora-dev libvorbis-dev libopencore-amrwb-dev libopencore-amrnb-dev
sudo apt-get install libxfixes-dev libxext-dev
# 
#################################
#yasm
wget -O - http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz  |tar zxvf -
cd yasm-1.3.0
./configure && make
sudo checkinstall  --pkgname=yasm --pkgversion="1:$(date +%Y%m%d%H%M)" --backup=no \
  --deldoc=yes --fstrans=no --default
cd

#####################
#lame install 
cd 
wget -O - http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.4.tar.gz |tar zxvf -
cd lame-3.99.4/
./configure && make
sudo checkinstall --pkgname=lame --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no \
  --deldoc=yes --fstrans=no --default
cd


###############################
## faac
cd
wget -O - http://downloads.sourceforge.net/faac/faac-1.28.tar.gz | tar xzvf -
echo "diff -urN faac-1.28//common/mp4v2/mpeg4ip.h faac-1.28-dst//common/mp4v2/mpeg4ip.h
--- faac-1.28//common/mp4v2/mpeg4ip.h	2009-01-27 07:42:35.000000000 +0900
+++ faac-1.28-dst//common/mp4v2/mpeg4ip.h	2012-03-18 21:35:47.000000000 +0900
@@ -120,13 +120,6 @@
 #endif
 #include <sys/param.h>
 
-#ifdef __cplusplus
-extern \"C\" {
-#endif
-char *strcasestr(const char *haystack, const char *needle);
-#ifdef __cplusplus
-}
-#endif
 
 #define OPEN_RDWR O_RDWR
 #define OPEN_CREAT O_CREAT " > faac.diff
cd faac-1.28/
patch -p1 < ../faac.diff
./bootstrap && ./configure 
make
sudo checkinstall --pkgname=faac --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no \
  --deldoc=yes --fstrans=no --default
cd 
#とりあえず。リンク
#sudo ln -s   /usr/local/lib/libfaac.so.0.0.0  /usr/lib/libfaac.so.0
#sudo ln -s   /usr/local/lib/libmp3lame.so.0.0.0 /usr/lib/libmp3lame.so.0
sudo ldconfig
################################
#install x264
cd
git clone git://git.videolan.org/x264
cd x264
./configure --enable-static
make
sudo checkinstall --pkgname=x264 --pkgversion="3:$(./version.sh | \
    awk -F'[" ]' '/POINT/{print $4"+git"$5}')" --backup=no --deldoc=yes \
    --fstrans=no --default

##########################
#install ffmpeg
cd
rm -rf  ./ffmpeg
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
./configure --enable-gpl --enable-libfaac --enable-libmp3lame --enable-libopencore-amrnb \
    --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libx264 \
    --enable-nonfree --enable-postproc --enable-version3 --enable-x11grab
make
sudo checkinstall --pkgname=ffmpeg --pkgversion="5:$(date +%Y%m%d%H%M)-git" --backup=no \
  --deldoc=yes --fstrans=no --default
hash x264 ffmpeg ffplay ffprobe
