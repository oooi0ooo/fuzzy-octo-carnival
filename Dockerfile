# Base image for the container
FROM php:7.4-apache

# Dependencies
RUN apt-get update -y && apt-get install -y ssh libpng-dev libmagickwand-dev libjpeg-dev libmemcached-dev zlib1g-dev libzip-dev git unzip subversion ca-certificates libicu-dev libxml2-dev libmcrypt-dev && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/

# PHP Extensions - PECL
RUN pecl install imagick-3.4.4 memcached mcrypt-1.0.4 && docker-php-ext-enable imagick memcached mcrypt

# PHP Extensions - docker-php-ext-install
RUN docker-php-ext-install zip gd mysqli exif pdo pdo_mysql opcache intl soap

# PHP Extensions - enable mysqli
RUN docker-php-ext-enable mysqli

# PHP Extensions - docker-php-ext-configure
RUN docker-php-ext-configure intl

# Make WordPress feel comfortable with mod-rewrite
RUN a2enmod rewrite && service apache2 restart