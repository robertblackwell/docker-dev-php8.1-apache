FROM php:8.1-apache

COPY ./apachephp/modified_apache2.conf /etc/apache2/
RUN a2enmod rewrite

RUN docker-php-ext-install mysqli pdo pdo_mysql
WORKDIR /var/www/html
