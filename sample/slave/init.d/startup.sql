CHANGE MASTER TO MASTER_HOST='master_1', MASTER_USER='root',MASTER_PASSWORD='root', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=120;
grant all privileges on *.* to root@'%' identified by 'root';

FLUSH PRIVILEGES;
SHOW SLAVE STATUS \G
