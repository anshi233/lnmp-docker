# lnmp-docker
















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
#please if 1001 or 1002 is not available, please replace to other number you like
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

