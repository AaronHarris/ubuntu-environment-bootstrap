Ubuntu Environment Bootstrap
============================

This script will install all of the basic dev packages need to start using python and app engine in ubuntu. It'll also install sublime text for you.

You'll still need to setup your git user name and private key as well as install any sublime text packages.

Usage
-----

Just run it:

    cd /tmp && wget https://raw.githubusercontent.com/AaronHarris/ubuntu-environment-bootstrap/master/bootstrap.sh && bash bootstrap.sh


Vagrant
=======

There is a special bootstrap script for vagrant usage. To get started with vagrant:

  1. Install VirtualBox (5.0 as of now) from https://www.virtualbox.org/wiki/Downloads
  2. Install vagrant from http://www.vagrantup.com/downloads.html
  3. Install vagrant-vbguest plugin

        vagrant plugin install vagrant-vbguest

  3. Add a new box to vagrant for Ubuntu 15.10, or another box from [box catalog](https://atlas.hashicorp.com/boxes/search)

        vagrant box add ubuntu/wily64

  4. Clone this repository into your workspace

        git clone https://github.com/AaronHarris/ubuntu-environment-bootstrap.git

  5. Copy the vagrant file from the bootstrap into your workspace (you should now have workspace/Vagrantfile and workspace/ubuntu-environment-bootstrap)

        cp ubuntu-environment-bootstrap/Vagrantfile Vagrantfile

  6. Start-up vagrant. This may take a few minutes while vagrant initializes the machine.

        vagrant up

  7. SSH into the VM. The workspace directory should be mapped to your local workspace.

        vagrant ssh
        $> cd workspace
        $> ls

  8. cd into a project and run the development server.

        $> cd some-project
        $> app-server

  9. The app engine development server should start. You can now access it on your local machine via localhost:8080 and the admin console via localhost:8000.

  10. When you're done use ``vagrant suspend`` to pause the machine. Use ``vagrant resume`` to start it back up. If you need to delete it use ``vagrant destroy``.
