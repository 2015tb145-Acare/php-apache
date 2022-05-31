FROM php:8.0-apache

# Do not run Composer as root/super user!
ENV COMPOSER_ALLOW_SUPERUSER=1

EXPOSE 80

WORKDIR /app

# Install dependencies
RUN apt-get update -qq && \
	apt-get install -qy \
	git \
	gnupg \
	unzip \
	zip \
	libpq-dev \
	nodejs\
	npm &&\
	# Reduce layer size
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# PHP Extensions (include postgresql, mysql, gd)
RUN docker-php-ext-install -j$(nproc) opcache pdo pdo_pgsql pdo_mysql
COPY conf/php.ini /usr/local/etc/php/conf.d/app.ini

# Apache
COPY conf/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY conf/apache.conf /etc/apache2/conf-available/z-app.conf
COPY index.php /app/index.php

RUN a2enmod rewrite remoteip && \
	a2enconf z-app

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
