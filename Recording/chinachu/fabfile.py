# coding: utf-8

from fabric.api import run
from fabric.api import env

env.hosts = ["${IP}"]
env.user = "${USER}"
env.key_filename = './id_rsa'

def enc(ts_file):
        run("bash /home/${USER}/ts2mp4.sh %s" % (ts_file))
