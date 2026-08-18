ARG PHP_VERSION=8.4
ARG FRANKENPHP_VERSION=1.12

FROM dunglas/frankenphp:${FRANKENPHP_VERSION}-php${PHP_VERSION}-alpine

ARG PHP_VERSION
ARG FRANKENPHP_VERSION

# Runtime packages: needed by the app/extensions while the container is running.
# Build-only packages live in the .build-deps virtual group below and are removed
# in this same RUN once the extensions are compiled, so the deleted files never
# land in the final layer diff.
RUN apk add --no-cache \
    postgresql-client \
    imagemagick \
    zip \
    unzip \
    gzip \
    tar \
    bash \
    && apk add --no-cache --virtual .build-deps \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libwebp-dev \
    libavif-dev \
    libzip-dev \
    icu-dev \
    oniguruma-dev \
    mysql-dev \
    postgresql-dev \
    libssh2-dev \
    imagemagick-dev \
    git \
    && docker-php-ext-configure gd --with-avif --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    pdo_pgsql \
    gd \
    intl \
    zip \
    bcmath \
    ftp \
    && install-php-extensions redis imagick ssh2 \
    && runDeps="$( \
    scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
    | tr ',' '\n' \
    | sort -u \
    | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --no-cache $runDeps \
    && apk del --no-network .build-deps

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
