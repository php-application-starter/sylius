FROM php:7.4-fpm
MAINTAINER Sylius Docker Team <docker@sylius.org>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_CODENAME buster
ENV TZ UTC

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
	&& echo $TZ > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata

# All things PHP
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	acl \
	unzip \
	libfreetype6-dev \
	libxpm-dev \
	libwebp-dev \
	libjpeg-dev \
	libzip-dev \
	libpng-dev \
	libicu-dev \
  vim \
	&& apt-get clean all \
	&& docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-xpm \
    --with-webp \
	&& docker-php-ext-enable \
		opcache \
	&& docker-php-ext-install \
		intl \
		zip \
		exif \
		gd \
		pdo \
		pdo_mysql \
	&& apt-get autoremove -y


# All things composer
RUN php -r 'readfile("https://getcomposer.org/installer");' > composer-setup.php \
	&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
	&& rm -f composer-setup.php \
	&& chown www-data.www-data /var/www

USER www-data
USER root

# PHP configuration
ADD php.ini /usr/local/etc/php/conf.d/php.ini
ADD php-cli.ini /usr/local/etc/php/php-cli.ini

# Copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
WORKDIR /srv/sylius

ENTRYPOINT /usr/local/bin/docker-entrypoint.sh php-fpm