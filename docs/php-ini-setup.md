# PHP INI Setup Guide

PHPX uses the standard PHP configuration model. To customize PHP settings, add `.ini` files under:

```bash
/usr/local/etc/php/conf.d/
```

This works for all PHP execution modes in the container, including CLI commands and FrankenPHP.

## Option 1: Mount a custom `.ini` file

This is the simplest option for local development.

```yaml
services:
  app:
    image: kimtrien/phpx:php8.5
    volumes:
      - ./php-custom-ini/uploads.ini:/usr/local/etc/php/conf.d/zzz-uploads.ini:ro
```

Example `uploads.ini`:

```ini
post_max_size=64M
upload_max_filesize=64M
memory_limit=256M
max_execution_time=60
```

Use a filename such as `zzz-uploads.ini` if you want your overrides to load after the extension `.ini` files already included in the image.

## Option 2: Copy a custom `.ini` file into your application image

This is a good fit for production images.

```dockerfile
FROM kimtrien/phpx:php8.5

COPY docker/php/uploads.ini /usr/local/etc/php/conf.d/zzz-uploads.ini
```

Example `uploads.ini`:

```ini
post_max_size=64M
upload_max_filesize=64M
memory_limit=256M
max_execution_time=60
```

## Common settings

```ini
post_max_size=64M
upload_max_filesize=64M
memory_limit=256M
max_execution_time=60
date.timezone=Asia/Ho_Chi_Minh
opcache.enable=1
```

## Verify active configuration

Check which `.ini` files PHP loaded:

```bash
docker run --rm kimtrien/phpx:php8.5 php --ini
```

Check specific values:

```bash
docker run --rm kimtrien/phpx:php8.5 php -i | grep -E "post_max_size|upload_max_filesize|memory_limit|max_execution_time|date.timezone"
```

Inspect the mounted or copied file directly:

```bash
docker run --rm kimtrien/phpx:php8.5 sh -lc 'ls -la /usr/local/etc/php/conf.d'
```

## Recommended workflow

- Development: mount a `.ini` file from the host
- Production: copy a `.ini` file into the final image
- Prefer explicit `.ini` files over ad-hoc runtime environment variable conversions
