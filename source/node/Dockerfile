#FROM mysql:5.6
FROM ubuntu

RUN apt-get -y update
RUN apt-get -y install wget git

RUN apt-get remove --purge mysql-server* mysql-common 
RUN apt-get autoremove --purge 
RUN rm -r /etc/mysql | true
RUN rm -r /var/lib/mysql | true

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
RUN apt-get install -y libaio1 m4

RUN apt-get -y install openssh-server ufw curl libmysqlclient-dev
RUN mkdir /var/run/sshd
RUN which mysql_config
#ssh
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/masterha/

WORKDIR /root
RUN mkdir -p /root/.ssh/keys
RUN touch /root/.ssh/config
RUN chmod 775 -R /root/.ssh
RUN chmod 600 /root/.ssh/config
RUN echo "Host *\n  User root\n  IdentityFile /root/.ssh/keys/id_rsa\n  StrictHostKeyChecking no\n  CheckHostIP no" > ~/.ssh/config
ADD keys/ /root/.ssh/keys
RUN chmod 400 ~/.ssh/keys/id_rsa
RUN echo `cat ~/.ssh/keys/id_rsa.pub` >> ~/.ssh/authorized_keys

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections && \
        apt-get -y install mysql-server
#ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 22 3306
#CMD mysql_install_db --datadir=/var/lib/mysql --user=mysql  && supervisord -n
#CMD mysqld

