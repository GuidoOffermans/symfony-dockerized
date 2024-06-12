FROM php:8.3-fpm-alpine3.20

WORKDIR /var/www/html/

# RUN apt-get update && apt-get install -y \
#     git \
#     unzip \
#     libpq-dev \
#     libonig-dev \
#     libzip-dev

# RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install --prefer-dist --no-scripts --no-progress --no-interaction

RUN chown -R www-data:www-data /var/www/html/var /var/www/html/public /var/www/html/vendor

CMD ["php-fpm"]