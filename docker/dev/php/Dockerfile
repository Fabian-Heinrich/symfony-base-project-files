FROM php:8.0-fpm-buster

ARG PHP_TIMEZONE
ARG PHP_MEMORY_LIMIT

ARG USER_NAME=www-data
ARG USER_GROUP=www-data
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y \
        libicu-dev \
        libzip-dev \
        unzip \
        git

# Install PHP extensions
RUN docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_mysql \
        opcache \
        zip \
        intl

RUN pecl install \
    xdebug \
    apcu

RUN docker-php-ext-enable \
    xdebug \
    apcu

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \

# Set timezone
RUN ln -snf /usr/share/zoneinfo/Europe/Berlin /etc/localtime && echo Europe/Belin > /etc/timezone

# Copy xdebug and php config.
COPY docker/dev/php/conf.d/* /usr/local/etc/php/conf.d/

# Change www-data users uid and www-data groups gid
RUN usermod  --uid $USER_ID $USER_NAME && groupmod --gid $GROUP_ID $USER_GROUP

# set default user and working directory
USER www-data
WORKDIR /var/www/project
