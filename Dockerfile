FROM serversideup/php:8.3-fpm-apache

WORKDIR /var/www/html

COPY . .

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Switch to the root user to change the ownership of the files
USER root

# Ensure the www-data user owns the application files
RUN chown -R www-data:www-data /var/www/html || true

# Switch to the www-data user
USER www-data

# Install PHP dependencies
RUN composer install --prefer-dist --no-scripts --no-progress --no-interaction

# Switch back to root user to change the permissions back, if needed
USER root

RUN chown -R www-data:www-data /var/www/html

# Switch back to www-data user for running the application
USER www-data

EXPOSE 8080