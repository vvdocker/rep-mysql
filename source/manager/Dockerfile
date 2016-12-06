FROM vvdocker/mha-node

RUN apt-get install -y libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl

# MHA manager
RUN apt-get install -y libconfig-tiny-perl liblog-dispatch-perl libparallel-forkmanager-perl
RUN git clone https://github.com/yoshinorim/mha4mysql-manager.git
WORKDIR mha4mysql-manager
RUN perl Makefile.PL
RUN make
RUN make install

ADD ServerManager.pm /usr/local/share/perl/5.20.2/MHA/ServerManager.pm

RUN mkdir -p /var/log/masterha/mysql/
RUN cat /usr/local/share/perl/5.20.2/MHA/ServerManager.pm

# sample をコピー
RUN cp -p samples/scripts/master_ip_failover /usr/local/bin/
RUN chmod 555 /usr/local/bin/master_ip_failover
RUN mkdir -p /etc/masterha/conf
#コピー----------------------------------------
ADD test.conf /etc/mha.conf
#----------------------------------------------

RUN apt-get -y install openssh-server ufw curl
RUN mkdir /var/run/sshd

RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/config
RUN chmod 775 -R ~/.ssh
RUN chmod 600 ~/.ssh/config
RUN echo -e "Host *\n  User root\n  IdentityFile /root/.ssh/id_rsa\n  StrictHostKeyChecking no\n  CheckHostIP no" > /root/.ssh/config
ADD id_rsa /root/.ssh/id_rsa
RUN ls -la ~/.ssh
RUN chmod 400 ~/.ssh/id_rsa

