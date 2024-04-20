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

ENV COMPOSER_ALLOW_SUPERUSER=1
COPY ./www/ /var/www/
WORKDIR /var/www/
RUN composer update
RUN composer install
RUN composer update --ignore-platform-reqs
RUN npm install
RUN npm run build 
RUN php artisan key:generate
RUN chmod -R 777 /var/www/storage 
