FROM php:8.5-fpm-bookworm@sha256:0fed012de2202d7ef0314744ccfa274b870f07cd6a91f88b78f74a849bb03f02

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
