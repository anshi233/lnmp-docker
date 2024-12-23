# lnmp-docker
[ENGLISH](#ENGLISH)
# 中文
## 简介
又一个使用docker实现lnmp.org的docker-compose项目，所有的配置文件都来自lnmp.org的LNMP2.0安装脚本。
强烈推荐使用自己的配置文件替换掉原有的配置文件。
## 文件列表
```
├── docker-compose.yml       (docker compose主配置文件)
├── dockerfiles              (dockerfile文件夹)
│   ├── nginx.Dockerfile     (nginx dockerfile)
│   └── php-fpm.Dockerfile   (php-fpm dockerfile)
├── mysql                    (mysql配置和数据)
│   ├── conf.d               (mysql额外的.cnf配置文件)
│   └── mysql                (mysql数据)
├── nginx                    (nginx配置文件夹)
│   ├── conf                 (nginx配置)
│   ├── logs                 (nginx pid文件位置(未使用))
│   └── wwwlogs              (nginx日志)
├── php                      (php配置)
│   ├── etc                  (php配置)
│   │   ├── php-fpm.conf     (php-fpm主配置)
│   │   ├── php-fpm.d        (php-fpm额外配置文件夹)
│   │   └── php.ini          (php.ini)
│   └── var
│       └── log              (php日志文件夹)
├── ssl                      (https ssl证书文件夹)
├── www                      (网站文件夹)
└── wwwroot                  (lnmp模板网站文件夹)
```
## 使用方法
首先创建www和mysql用户并指定uid(这里是基于debian的例子，实际上的命令可能因为发行版的不同而不同)。
如果你已经有www和mysql用户了，可以跳过这一步。
```bash
#如果uid 1001 或者 1002 已经被使用了，请换成其他你喜欢的数字
#别忘了修改docker-compose.yml文件中的uid值为你的www和mysql用户的uid
useradd www -u 1001
useradd mysql -u 1002
```
下载这个repo
```bash
git clone https://github.com/anshi233/lnmp-docker.git
cd lnmp-docker
```
请务必修改mysql的root密码并在第一次启动后删除docker compose 文件上的这一行
```bash
nano docker-compose.yml

#修改为你的密码并在第一次启动后删除这一行
      MYSQL_ROOT_PASSWORD: CHANGE_TO_YOUR_PASSWORD
```

创建文件夹并分配权限
```bash
#你可以直接创建文件夹或者软链接到已有文件夹上
mkdir ./www
mkdir ./ssl
#如果你没有自己的mysql数据文件夹，请创建这个文件夹
mkdir ./mysql/mysql
chown -R www:www ./nginx
chown -R www:www ./php
chown -R www:www ./www
chown -R www:www ./wwwroot
chown -R www:www ./ssl

chown -R mysql:mysql ./mysql
```

运行服务
```bash
docker compose up -d
```
The Default web port is 80 and 443
To enable or disable each service only
```bash
#启动
#选择nginx php-fpm mysql中的一个
docker compose up [nginx | php-fpm | mysql] -d
#停止
docker compose down [nginx | php-fpm | mysql]
#查看对应服务的命令行输出
docker compose logs [nginx | php-fpm | mysql]
```

## PHP Cron定时服务
PHP所需的Cron定时服务可用使用宿主机上的Crontab配合```docker exec -t```解决
格式为
```
* *     * * *   root    /usr/bin/docker exec -t php-fpm sh -c 'php /home/www/the/php/file/you/want/to/run.php'
...
```


# ENGLISH
## Introduction
This project is a docker compose implementation of lnmp.org LNMP installation script. All of the configuration templates come from LNMP2.0.
Please replace the configuration files with your own version.

## File List
```
├── docker-compose.yml       (docker compose main config)
├── dockerfiles              (dockerfile folder)
│   ├── nginx.Dockerfile     (nginx dockerfile) 
│   └── php-fpm.Dockerfile   (php-fpm dockerfile)
├── mysql                    (mysql config and data)
│   ├── conf.d               (additional mysql .cnf config)
│   └── mysql                (mysql data)
├── nginx                    (nginx config folder)
│   ├── conf                 (nginx config)
│   ├── logs                 (nginx pid file location(not in use))
│   └── wwwlogs              (nginx log)
├── php                      (php config)
│   ├── etc                  (php config)
│   │   ├── php-fpm.conf     (php-fpm main config)
│   │   ├── php-fpm.d        (php-fpm additional config folder)
│   │   └── php.ini          (php.ini)
│   └── var                  
│       └── log              (php log folder)
├── ssl                      (https ssl cert folder)
├── www                      (website folder)
└── wwwroot                  (lnmp template website folder)
```
## Usage
First create your www and mysql user with uid (Here is debian example, command may differ based on OS).
If you already have www and mysql user, you can skip for this step.
```bash
#if 1001 or 1002 is not available, please replace to other number you like
#DONT FORGET to change uid value in docker compose file to your www and mysql user uid 
useradd www -u 1001
useradd mysql -u 1002
```
Clone this project
```bash
git clone https://github.com/anshi233/lnmp-docker.git
cd lnmp-docker
```
you MUST change the default password of the mysql root account and delete the line after first boot
```bash
nano docker-compose.yml

#Change to your password and delete this line after first successful mysql instance boot
      MYSQL_ROOT_PASSWORD: CHANGE_TO_YOUR_PASSWORD
```

Create and Assign ownership to folders
```bash
#you can create or soft link
mkdir ./www
mkdir ./ssl
#create it if you don't have you own mysql data folder from other location
mkdir ./mysql/mysql

chown -R www:www ./nginx
chown -R www:www ./php
chown -R www:www ./www
chown -R www:www ./wwwroot
chown -R www:www ./ssl

chown -R mysql:mysql ./mysql
```
Run the container
```bash
docker compose up -d
```
The Default web port is 80 and 443
To enable or disable each service only
```bash
#start
#select one of the nginx and php-fpm mysql keyword
docker compose up [nginx | php-fpm | mysql] -d
#stop
docker compose down [nginx | php-fpm | mysql]
#checking commandline output
docker compose logs [nginx | php-fpm | mysql]
```


