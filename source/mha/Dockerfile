FROM ubuntu

RUN apt-get -y update
RUN apt-get -y install wget git

# MHA NODE
RUN apt-get -y install build-essential devscripts dh-make fakeroot dpkg-dev debhelper libdbi-perl libmysqlclient-dev zlib1g-dev
RUN apt-get -y install libmodule-install-perl

RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/libd/libdbd-mysql-perl/libdbd-mysql-perl_4.033.orig.tar.gz
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/libd/libdbd-mysql-perl/libdbd-mysql-perl_4.033-1build2.debian.tar.xz

RUN mkdir work
RUN cp libdbd-mysql-perl_4.033.orig.tar.gz work
WORKDIR work
RUN tar xf libdbd-mysql-perl_4.033.orig.tar.gz
RUN mv DBD-mysql-4.033 libdbd-mysql-perl_4.033
RUN tar xf ../libdbd-mysql-perl_4.033-1build2.debian.tar.xz -C libdbd-mysql-perl_4.033
RUN cd libdbd-mysql-perl_4.033 && dpkg-buildpackage -us -uc

RUN dpkg -i libdbd-mysql-perl_4.033-1build2_amd64.deb

RUN git clone https://github.com/yoshinorim/mha4mysql-node
WORKDIR mha4mysql-node
RUN perl Makefile.PL
RUN make
RUN make install

