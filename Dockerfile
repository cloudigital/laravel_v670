FROM php:7-fpm

ENV DEBIAN_FRONTEND noninteractive   
RUN apt-get update \
	&& apt-get install -y vim libzip-dev zlib1g-dev zip unzip net-tools libmcrypt-dev default-mysql-client\
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& pecl install mcrypt-1.0.3 \
	&& docker-php-ext-enable mcrypt \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip
    


ADD ./php.conf /usr/local/etc/php-fpm.conf
COPY ./php.ini /usr/local/etc/php/

ADD ./src /var/www/laravel670
RUN chown www-data:www-data -R /var/www/laravel670

#RUN apt-get install net-tools -y
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/laravel670
