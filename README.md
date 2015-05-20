# docker-ubuntu - Docker base images for Ubuntu

# ABOUT

docker-ubuntu is a collection of [debootstrap](https://wiki.debian.org/Debootstrap)-generated Ubuntu base images.

# DOCKER HUB

https://registry.hub.docker.com/u/mcandre/docker-ubuntu/

# EXAMPLE

```
$ make
docker run --rm --privileged -v $(pwd):/mnt -t mcandre/docker-ubuntu:trusty sh -c 'apt-get update && apt-get install -y debootstrap && mkdir /chroot && debootstrap quantal /chroot http://old-releases.ubuntu.com/ubuntu/ && cd /chroot && tar czvf /mnt/rootfs.tar.gz .'
...

docker build -t mcandre/docker-ubuntu:12.10 .
Step 0 : FROM scratch
Step 1 : MAINTAINER Andrew Pennebaker <andrew.pennebaker@gmail.com>
Step 2 : ADD rootfs.tar.gz /
Successfully built dcccd8a09292

docker run --rm mcandre/docker-ubuntu:12.10 sh -c 'cat /etc/*release*'
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=12.10
DISTRIB_CODENAME=quantal
DISTRIB_DESCRIPTION="Ubuntu 12.10"
NAME="Ubuntu"
VERSION="12.10, Quantal Quetzal"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu quantal (12.10)"
VERSION_ID="12.10"
```

# REQUIREMENTS

* [Docker](https://www.docker.com/)

## Optional

* [make](http://www.gnu.org/software/make/)

## Debian/Ubuntu

```
$ sudo apt-get install docker.io build-essential
```

## RedHat/Fedora/CentOS

```
$ sudo yum install docker-io
```

## non-Linux

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [boot2docker](http://boot2docker.io/)

### Mac OS X

* [Xcode](http://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12)
* [Homebrew](http://brew.sh/)
* [brew-cask](http://caskroom.io/)

```
$ brew cask install virtualbox vagrant
$ brew install boot2docker
```

### Windows

* [Chocolatey](https://chocolatey.org/)

```
> chocolatey install docker make
```
