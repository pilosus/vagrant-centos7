## Vagrantfile for Python Web Development  ##

Vagrantfile used for setting up an environment needed for Python web
development purposes. A box provisioned with:

1. CentOS 7 (bento/centos-7.2 box)
2. Python 3.5
    * pip3.5
    * virtualenv

3. Nginx
4. uWSGI	
5. Celery
6. RabbitMQ
7. Git
8. Bash-completion
9. Emacs
10. PostgreSQL

Vagrant allows you to run this box on GNU/Linux, MacOS or Windows with
ease.

### Prerequisites ###

You need [Vagrant](https://www.vagrantup.com/) installed. Vagrant also
runs on top of a virtual machine
[provider](https://www.vagrantup.com/docs/providers/). VirtualBox,
Hyper-V, and Docker are amongst the most popular providers used in
conjuction with Vagrant.


### Usage ###

1. Clone this repo with `git clone https://github.com/pilosus/vagrant-centos7.git`

2. Go to the project root directory `cd vagrant-centos7`

3. Run vagrant `vagrant up`

4. Once provisioning is done (it takes time, be patient) connect to
   the virtual machine `vagrant ssh`

5. Now you are ready to tweak the machine for you needs.

6. Go to http://127.0.0.1:8888 on your host machine and see the page
   Nginx serves on your guest's machine from `/var/www/project/` root
   directory.

7. Take a look at the
   [Vagrant documentation](https://www.vagrantup.com/docs/) to further
   explore its features.
