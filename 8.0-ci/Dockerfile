FROM php:8.0-alpine

# Do not run Composer as root/super user!
ENV COMPOSER_ALLOW_SUPERUSER=1

EXPOSE 80

WORKDIR /app

# Install dependencies
RUN apk add --no-cache \
	bash \
	libxml2 \
	libzip \
	git \
	zlib && \
	# Reduce layer size
	rm -rf /var/cache/apk/* /tmp/*

# PHP Extensions
ENV PHPIZE_DEPS \
	autoconf \
	cmake \
	file \
	freetype-dev \
	g++ \
	gcc \
	icu-dev \
	libc-dev \
	libzip-dev \
	make \
	pcre-dev \
	pkgconf \
	re2c \
	zlib-dev

RUN apk add --no-cache --virtual .build-deps \
	$PHPIZE_DEPS && \
	docker-php-ext-install -j$(nproc) opcache zip && \
	apk del .build-deps && \
	rm -rf /var/cache/apk/* /tmp/*

# Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer
