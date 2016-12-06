#FROM ubuntu
FROM mysql:5.6

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

RUN mkdir -p /opt/mysql/server-5.6/data/
#mysql5.6
#RUN wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.14-debian6.0-x86_64.deb
#RUN dpkg -i mysql-5.6.14-debian6.0-x86_64.deb
#RUN apt-get -y upgrade
RUN apt-get install -y libaio1 m4

RUN apt-get -y install openssh-server ufw curl
RUN mkdir /var/run/sshd
#RUN install -d /data/mysql
#RUN /opt/mysql/server-5.6/scripts/mysql_install_db --datadir=/data/mysql
#ENV PATH "/opt/mysql/server-5.6/bin:$PATH"
#ENV MANPATH "/opt/mysql/server-5.6/man:$MANPATH"
RUN mysql --version
#ssh
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/masterha/


ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 22 3306
CMD mysql_install_db --datadir=/var/lib/mysql --user=mysql && supervisord -n 

#mha log

