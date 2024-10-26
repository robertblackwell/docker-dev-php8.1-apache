FROM php:8.1-apache
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli pdo pdo_mysql
COPY ./apachephp/modified_apache2.conf /etc/apache2/
WORKDIR /var/www/html
