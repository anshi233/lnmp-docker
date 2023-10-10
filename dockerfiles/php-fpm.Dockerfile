FROM php:7.4.32-fpm-alpine
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN adduser www -u 1001 -H -D && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd xdebug mysqli
