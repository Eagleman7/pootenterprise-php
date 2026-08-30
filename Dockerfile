FROM php:8.3-fpm-bookworm@sha256:84ffb6f84362cd0cc74d6dea47cc1b376b4d7477f97c84b0e5bb287ab9df056c

LABEL org.opencontainers.image.title="PootEnterprise PHP" \
      org.opencontainers.image.description="PHP 8.3 FPM with GD and MySQLi" \
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
