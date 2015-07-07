# ref:https://github.com/ssig33/docker-ruby-imagemagick-groonga

#!/bin/bash -x

echo "deb http://ftp.jp.debian.org/debian/ jessie main" > /etc/apt/sources.list
echo "deb-src http://ftp.jp.debian.org/debian/ jessie main" >> /etc/apt/sources.list
echo "deb http://security.debian.org/ jessie/updates main" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/ jessie/updates main" >> /etc/apt/sources.list
echo "deb http://ftp.jaist.ac.jp/debian/ jessie-updates main" >> /etc/apt/sources.list
echo "deb-src http://ftp.jaist.ac.jp/debian/ jessie-updates main" >> /etc/apt/sources.list
echo "deb http://packages.groonga.org/debian/ unstable main"  >> /etc/apt/sources.list
echo "deb-src http://packages.groonga.org/debian/ unstable main" >> /etc/apt/sources.list

apt-get update && apt-get install aptitude git wget make readline-common openssl ruby ruby-dev -y
aptitude -V -D -y --allow-untrusted install groonga-keyring
apt-get update && apt-get install nginx libgroonga-dev groonga libssl-dev libsqlite3-dev libmysqlclient-dev libncurses5-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt-dev libsasl2-dev libsasl2-2 libv8-dev libv8-dev nodejs libgdbm-dev -y
apt-get build-dep imagemagick -y && apt-get build-dep ruby -y
# apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

apt-get update && apt-get install libffi-dev libmagickwand-dev -y
# rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

#wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.bz2 && tar xvf ruby-2.2.2.tar.bz2
#cd ruby-2.2.2 && ./configure && make -j2 && make install && cd .. && rm -rf  ruby-2.2.2 && rm -rf  ruby-2.2.2.tar.gz

apt-get update && apt-get install imagemagick -y
# rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

gem install --no-document foreman bundler rmagick

# gem install --no-document pig-media-server

mkdir -p /home/whywaita/groonga
mkdir -p /home/whywaita/userdata

apt-get install vim git
export EDITOR=vim
git clone https://github.com/ssig33/pig-media-server.git
