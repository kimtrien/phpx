ARG PHP_VERSION=8.4
ARG FRANKENPHP_VERSION=1.12

FROM dunglas/frankenphp:${FRANKENPHP_VERSION}-php${PHP_VERSION}-alpine

RUN apk add --no-cache \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libwebp-dev \
    libzip-dev \
    icu-dev \
    oniguruma-dev \
    postgresql-dev \
    imagemagick \
    imagemagick-dev \
    git \
    unzip \
    bash

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install \
    pdo_pgsql \
    gd \
    intl \
    zip \
    bcmath \
    opcache \
    && install-php-extensions redis imagick

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# OCI annotations
LABEL maintainer="kimtrien"
LABEL org.opencontainers.image.title="PHPX"
LABEL org.opencontainers.image.description="Production-ready PHP base image powered by FrankenPHP with pre-installed extensions"
LABEL org.opencontainers.image.authors="Kim Trien <https://github.com/kimtrien>"
LABEL org.opencontainers.image.vendor="kimtrien"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/kimtrien/phpx"
LABEL org.opencontainers.image.documentation="https://github.com/kimtrien/phpx#readme"
LABEL org.opencontainers.image.version="php${PHP_VERSION}-frankenphp${FRANKENPHP_VERSION}"
