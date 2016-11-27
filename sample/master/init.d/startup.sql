GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' IDENTIFIED BY 'replpass';
FLUSH PRIVILEGES;
SELECT user,password,host from mysql.user WHERE user='repl';
