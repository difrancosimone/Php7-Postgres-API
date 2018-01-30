FROM php:7.2-apache

RUN export CFLAGS="-I/usr/src/php"

# Download extension dependencies 
RUN apt-get update && apt-get install -y libcurl3-dev libxml2-dev libzzip-dev libfreetype6-dev libjpeg62-turbo-dev mcrypt libmcrypt-dev libmcrypt-dev libicu-dev libpng-dev libjpeg-dev libedit-dev libpq-dev && rm -rf /var/lib/apt/lists/* 

# Install extensions 
RUN docker-php-ext-install pgsql pdo pdo_mysql pdo_pgsql && docker-php-ext-install pdo_mysql && docker-php-ext-install curl && docker-php-ext-install xml && docker-php-ext-install calendar && docker-php-ext-install zip && docker-php-ext-install gd && docker-php-ext-install bcmath && docker-php-ext-install mbstring && docker-php-ext-install intl && docker-php-ext-install readline && docker-php-ext-install sockets 

# Configure extension 
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && docker-php-ext-install pdo pdo_pgsql pgsql 

# Enable rewrite rules 
RUN a2enmod rewrite 
#RUN a2enmod ssl
