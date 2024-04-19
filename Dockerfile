FROM php:8.2-fpm-alpine

RUN apk --update add \
    libzip-dev \
    zip \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/cache/apk/*

RUN docker-php-ext-configure zip && \
    docker-php-ext-install pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./www/ /var/www/

WORKDIR /var/www/
