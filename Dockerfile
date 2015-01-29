FROM macadmins/sal

MAINTAINER Nick McSpadden <nmcspadden@gmail.com>

ADD https://github.com/nmcspadden/SalProfileGenerator/tarball/master /home/docker/master.tar.gz
RUN mkdir -p /home/docker/profiles/ && mkdir -p /usr/local/salprofilegenerator/ && tar -zxvf /home/docker/master.tar.gz --strip-components=1 -C /usr/local/salprofilegenerator/ && rm /home/docker/master.tar.gz
