FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev git curl libpng-dev libonig-dev libxml2-dev zip \
    mariadb-client openssl \
    libfreetype-dev libjpeg-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli pdo pdo_mysql zip mbstring exif pcntl bcmath gd


WORKDIR /var/www/html

COPY ./src /var/www/html

COPY ./init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]
