FROM php:8.5.12-fpm-bookworm@sha256:740a5adab5af19504d8aa0754e903e20b40b0153cfd4013c11e4df2029a7b73c

LABEL org.opencontainers.image.title="PootEnterprise PHP" \
      org.opencontainers.image.description="PHP 8.5 FPM with GD and MySQLi" \
      org.opencontainers.image.source="https://github.com/Eagleman7/pootenterprise-php"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev; \
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
    docker-php-ext-install -j"$(nproc)" gd mysqli; \
    rm -rf /var/lib/apt/lists/*
