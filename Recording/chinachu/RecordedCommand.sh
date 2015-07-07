#!/bin/bash -x

IP="hoge.example.com"
USER=${USER}
SCRIPT=/home/${USER}/ts2mp4.sh
KEY=/home/chinachu/bin/id_rsa

TS=$1
BASE=$(basename $TS .ts)
[ "${BASE}.ts" = "$(basename $TS)" ] || exit 1

/usr/bin/ssh ${IP} -l ${USER} -i ${KEY} "${SCRIPT} '${TS}'"

exit
