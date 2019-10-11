# mysql

How to start MYSQL
```
$ cd mysql
$ export RAILS_DATABASE_PASSWORD=<THIS WILL BE MYSQL_ROOT_PASSWORD>
$ echo MYSQL_ROOT_PASSWORD=$RAILS_DATABASE_PASSWORD > .env
$ docker-compose up -d
$ mysql -u root -p -h 127.0.0.1 -P 3306   # connection test
```
