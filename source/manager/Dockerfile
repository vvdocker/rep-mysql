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

RUN apt-get -y install openssh-server ufw curl
RUN mkdir /var/run/sshd

#ssh
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/masterha/


# MHA manager
RUN apt-get install -y libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl
RUN git clone https://github.com/yoshinorim/mha4mysql-manager.git
WORKDIR mha4mysql-manager
RUN perl Makefile.PL
RUN make
RUN make install

RUN mkdir -p /var/log/masterha/mysql/
RUN cp -p samples/scripts/master_ip_failover /usr/local/bin/
RUN chmod 555 /usr/local/bin/master_ip_failover
RUN mkdir -p /etc/masterha/conf

WORKDIR /root
RUN mkdir -p /root/.ssh/keys
RUN touch /root/.ssh/config
RUN chmod 775 -R /root/.ssh
RUN chmod 600 /root/.ssh/config
RUN echo "Host *\n  User root\n  IdentityFile /root/.ssh/keys/id_rsa\n  StrictHostKeyChecking no\n  CheckHostIP no" > ~/.ssh/config
ADD ssh /root/.ssh/keys
RUN ls -la /root/.ssh/keys
RUN chmod 400 ~/.ssh/keys/id_rsa
RUN echo `cat ~/.ssh/keys/id_rsa.pub` >> ~/.ssh/authorized_keys

EXPOSE 22
CMD supervisord -n
