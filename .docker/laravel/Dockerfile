FROM php:8.2-fpm-alpine as laravel

ARG USER
ARG GROUP

RUN adduser -g ${GROUP} -s /bin/sh -D ${USER}
RUN sed -i "s/user = www-data/user = ${USER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${GROUP}/g" /usr/local/etc/php-fpm.d/www.conf

WORKDIR /var/www/laravel

# bug in alpine di paginaz in tinker, da vedere se poi risolto
RUN apk --update add less
RUN apk -U add libxml2 libxml2-dev git
RUN docker-php-ext-install pdo_mysql pcntl dom
#COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
#RUN install-php-extensions redis
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

USER ${USER}:${GROUP}

CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]

FROM laravel as worker

CMD ["php", "/var/www/laravel/artisan", "horizon"]
