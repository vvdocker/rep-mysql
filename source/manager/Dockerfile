FROM vvdocker/mha-node

RUN apt-get install -y libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl

# MHA manager
RUN apt-get install -y libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl
RUN git clone https://github.com/yoshinorim/mha4mysql-manager.git
WORKDIR mha4mysql-manager
RUN perl Makefile.PL
RUN make
RUN make install

# sample をコピー
RUN cp -p samples/scripts/master_ip_failover /usr/local/bin/
RUN chmod 555 /usr/local/bin/master_ip_failover
RUN mkdir -p /etc/masterha/conf
#コピー----------------------------------------
#ADD test.conf /etc/masterha/conf/test.conf
#----------------------------------------------

