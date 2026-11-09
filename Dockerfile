FROM php:8.5.12-fpm-bookworm@sha256:75dc898a8861a777f14c57b2afbb811a848735701593cbc354e4194807a88f3e

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
