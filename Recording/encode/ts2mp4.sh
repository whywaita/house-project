# ref: http://d.hatena.ne.jp/munepi/20091227/1261941397

#!/bin/bash -x

TS=$1

CPU_CORES=2
#CPU_CORES=$(/usr/bin/getconf _NPROCESSORS_ONLN)

X264_HIGH_HDTV="-f mp4 -vcodec libx264 \
      -fpre /usr/share/local/ffmpeg/libx264-hq-ts.ffpreset \
          -r 30000/1001 -aspect 16:9 -s 1280x720 -bufsize 20000k -maxrate 25000k \
              -acodec libfaac -ac 2 -ar 48000 -ab 128k -threads ${CPU_CORES} -vsync 1"

ionice -c3 nice -n19 -ffmpeg -y -i $TS ${X264_HIGH_HDTV} /hoge/fuga/mp4/${BASE}.mp4

exit
