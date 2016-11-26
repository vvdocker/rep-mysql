FROM ubuntu

RUN apt-get -y update
RUN apt-get -y install wget git

# perl Module
#RUN apt-get -y install build-essential cpanminus
#ENV PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB"
#ENV PATH="$HOME/perl5/bin:$PATH"


# MHA NODE
RUN apt-get -y install build-essential devscripts dh-make fakeroot dpkg-dev debhelper libdbi-perl libmysqlclient-dev zlib1g-dev
RUN apt-get -y install libmodule-install-perl

RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/libd/libdbd-mysql-perl/libdbd-mysql-perl_4.033.orig.tar.gz
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/libd/libdbd-mysql-perl/libdbd-mysql-perl_4.033-1build2.debian.tar.xz

RUN mkdir work
RUN cp libdbd-mysql-perl_4.033.orig.tar.gz work
RUN cd work && tar xf libdbd-mysql-perl_4.033.orig.tar.gz
RUN cd work && mv DBD-mysql-4.033 libdbd-mysql-perl_4.033
RUN cd work && tar xf ../libdbd-mysql-perl_4.033-1build2.debian.tar.xz -C libdbd-mysql-perl_4.033
RUN cd work/libdbd-mysql-perl_4.033 && dpkg-buildpackage -us -uc

RUN cd work && dpkg -i libdbd-mysql-perl_4.033-1build2_amd64.deb

RUN git clone https://github.com/yoshinorim/mha4mysql-node
RUN cd mha4mysql-node && perl Makefile.PL
RUN cd mha4mysql-node && make
RUN cd mha4mysql-node && make install

# MHA manager
RUN apt-get install -y libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl
RUN git clone https://github.com/yoshinorim/mha4mysql-manager.git
RUN cd mha4mysql-manager && perl Makefile.PL
RUN cd mha4mysql-manager && make
RUN cd mha4mysql-manager && make install






