FROM php:7.4-fpm-alpine

COPY ./sylius /var/www/html

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install bash
RUN apk update  && apk upgrade && apk add bash

# install  ALL module for Sylius check requirements
RUN set -xe \
    && apk add --update \
        icu \
    && apk add --no-cache --virtual .php-deps \
        make \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        zlib-dev \
        icu-dev \
        g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        intl \
        exif \
        fileinfo \
    && docker-php-ext-enable intl \
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*
RUN apk add --no-cache libpng libpng-dev && docker-php-ext-install gd && apk del libpng-dev
RUN docker-php-ext-install pdo pdo_mysql opcache


WORKDIR  /var/www/html

RUN chown www-data:www-data .
RUN apk update \
	 && apk add zip

RUN apk update && apk upgrade
RUN apk add php7-zip


EXPOSE 9000

CMD ["php-fpm"]
