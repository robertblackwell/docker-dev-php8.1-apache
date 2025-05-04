FROM php:8.4-apache

# COPY ./apachephp/modified_apache2.conf /etc/apache2/apache2.conf
# Its better to edit the apache2.conf already in pplace than make a
# custom copy. 
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf
COPY ./apachephp/sites-available/000-default.conf /etc/apache2/sites-available/
COPY ./apachephp/sites-available/whiteacorn.conf /etc/apache2/sites-available/
COPY ./apachephp/sites-available/phpmyadmin.conf /etc/apache2/sites-available/
COPY ./apachephp/sites-available/iracoon.conf /etc/apache2/sites-available/
COPY ./apachephp/sites-available/testhost.conf /etc/apache2/sites-available/
RUN a2enmod rewrite
RUN a2enmod userdir
RUN a2ensite 000-default
RUN a2ensite whiteacorn
RUN a2ensite iracoon
RUN a2ensite phpmyadmin
RUN a2ensite testhost

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN pecl install xdebug && docker-php-ext-enable xdebug
COPY ./php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d

WORKDIR /var/www/html
ENTRYPOINT ["apache2-foreground"]
