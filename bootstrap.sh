#!/usr/bin/env bash

#################################
# Vagrant Provision Bash Script #
#################################

##### Install Software #####

echo ""
echo "#################### Software Installation ####################"
echo ""

### IUS repo install
yum -y install https://centos7.iuscommunity.org/ius-release.rpm

### EPEL repo install
yum -y install epel-release

### Update system
yum -y update

### Extend yum, install development tools
yum -y install yum-utils
yum -y groupinstall development

### Fix locale LC_ALL problem 
# MacOS fix: Terminal -> Preferences -> Profiles -> Advanced ->
# disable Set locale environment variables on startup
# Otherwise reinstall glibc
#yum -y reinstall glibc-common

### Python 3.5 from IUS repo
# see also: http://stackoverflow.com/a/23317640/4241180
yum -y install python35u python35u-devel python35u-libs
yum -y install python35u-pip

### Ngnix
yes | yum install nginx

### PostgreSQL
# see also https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-centos-7
yum -y install postgresql-server postgresql-contrib

### RabbitMQ
yum -y install erlang
wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.1/rabbitmq-server-3.6.1-1.noarch.rpm
rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
yum -y install rabbitmq-server-3.6.1-1.noarch.rpm

### Git
yum -y install git

### Emacs
yum -y install emacs

### Bash-completion
yum -y install bash-completion 

echo ""
echo "#################### Customize Environment ####################"
echo ""

### Add dotfiles

# add github's key to known_hosts
# ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# clone repo
git clone https://github.com/pilosus/dotfiles.git

# add dotfiles to existing ones
cat dotfiles/.bashrc >> /home/vagrant/.bashrc
cat dotfiles/.bashrc >> /root/.bashrc
cp dotfiles/.gitconfig /home/vagrant/

# make sure vagrant's shell prompt is visually distinct from other shells
echo "PS1=\"(vagrant) \[\e[1;34m\]\u@\h (\W) \$HISTCMD : \[\e[m\]\"" >> /home/vagrant/.bashrc
echo "PS1=\"(vagrant) \[\e[1;35m\]\u@\h (\W) \$HISTCMD : \[\e[m\]\"" >> /root/.bashrc

# clean up
rm -rf dotfiles

##### Create a directory for a project #####

mkdir -p /var/www/project
mkdir -p /opt/git
cd /var/www/project

##### Enable and Start Services ######

echo ""
echo "################## Enable and Start Services ################@#"
echo ""

## Nginx

# install config file
cp /vagrant/nginx-default.conf /etc/nginx/conf.d/
cp /vagrant/index.html /var/www/project/

# start and enable systemd service
systemctl start nginx.service
systemctl enable nginx.service

## Postgres

# initialize DB
postgresql-setup initdb

# update config file (auth with passwd md5)
cp /vagrant/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf

# start and enable systemd service
systemctl start postgresql.service
systemctl enable postgresql.service

##### Install pip packages #####

### virtualenv
pip3.5 install virtualenv
virtualenv --python=python3.5 venv

### uWSGI application server
pip3.5 install uwsgi

## Celery
pip3.5 install celery

echo ""
echo "## Now go and see http://127.0.0.1:8888 on the host machine.. ##"
echo ""

#################################################
# once the file changed                         #
# do not forget to $ vagrant reload --provision #
#################################################
