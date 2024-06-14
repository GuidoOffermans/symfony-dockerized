# Stage 1: Get Caddy binary from the official image
FROM caddy:2.4.6-alpine as caddy-builder

# Stage 2: Build the PHP-FPM image and install Caddy
FROM php:8.3-fpm-alpine3.20

# Set working directory
WORKDIR /var/www/html

# Install dependencies required for Caddy
RUN apk add --no-cache curl nss-tools

# Copy Composer from the latest image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy Caddy binary from the builder stage
COPY --from=caddy-builder /usr/bin/caddy /usr/bin/caddy

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --prefer-dist --no-scripts --no-progress --no-interaction

# Optimize autoloading
RUN composer dump-autoload --optimize

# Copy Caddyfile to the proper location
COPY Caddyfile /etc/caddy/Caddyfile

# Expose ports for Caddy
EXPOSE 80
#EXPOSE 443

CMD ["sh", "-c", "php-fpm & caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]
