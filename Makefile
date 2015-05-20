IMAGE=mcandre/docker-ubuntu:7.04
ROOTFS=rootfs.tar.gz
define GENERATE
apt-get update && \
apt-get install -y debootstrap && \
mkdir /chroot && \
debootstrap feisty /chroot http://old-releases.ubuntu.com/ubuntu/ && \
cd /chroot && \
tar czvf /mnt/rootfs.tar.gz .
endef

all: run

$(ROOTFS):
	docker run --rm --privileged -v $$(pwd):/mnt -t mcandre/docker-ubuntu:hardy sh -c '$(GENERATE)'

build: Dockerfile $(ROOTFS)
	docker build -t $(IMAGE) .

run: clean-containers build
	docker run --rm $(IMAGE) sh -c 'cat /etc/*release*'

clean-containers:
	-docker ps -a | grep -v IMAGE | awk '{ print $$1 }' | xargs docker rm -f

clean-images:
	-docker images | grep -v IMAGE | grep $(IMAGE) | awk '{ print $$3 }' | xargs docker rmi -f

clean-layers:
	-docker images | grep -v IMAGE | grep none | awk '{ print $$3 }' | xargs docker rmi -f

clean-rootfs:
	-rm $(ROOTFS)

clean: clean-containers clean-images clean-layers clean-rootfs

publish:
	docker push $(IMAGE)
