FROM php:8.6.0-fpm-bookworm@sha256:a836c00ddc6d873275d40437eb74732bde56781ead316b9eff42fa46dc6d93db

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
