# PHPX - PHP eXtended Base Image

[![Docker Hub](https://img.shields.io/docker/pulls/kimtrien/phpx)](https://hub.docker.com/r/kimtrien/phpx)
[![GitHub Container Registry](https://img.shields.io/badge/ghcr-latest-blue)](https://github.com/kimtrien/phpx/pkgs/container/phpx)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Production-ready PHP base image powered by FrankenPHP with all common extensions pre-installed. Built for **multi-architecture** support (AMD64 & ARM64).

## Features

- **FrankenPHP 1.12** - Modern PHP application server
- **PHP 8.5 & 8.4** - Latest PHP versions
- **Alpine Linux** - Minimal footprint
- **Multi-Architecture** - Supports AMD64 and ARM64 (Apple Silicon, AWS Graviton)
- **Standard PHP Configuration** - Customize PHP with mounted or copied `.ini` files
- **Pre-installed Extensions:**
  - `pdo_mysql` - MySQL support
  - `pdo_pgsql` - PostgreSQL support
  - `gd` - Image processing
  - `intl` - Internationalization
  - `zip` - Archive handling
  - `bcmath` - Arbitrary precision math
  - `opcache` - Performance optimization
  - `redis` - Redis client
  - `imagick` - Advanced image processing
- **System Tools:**
  - ImageMagick
  - Git
  - Composer
  - Bash

## PHP Configuration

PHPX follows the standard PHP configuration model: use `.ini` files in `/usr/local/etc/php/conf.d/`.

### Mount a custom `.ini` file

```yaml
services:
  app:
    image: kimtrien/phpx
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

### Copy a custom `.ini` file into your image

```dockerfile
FROM kimtrien/phpx:php8.5

COPY docker/php/uploads.ini /usr/local/etc/php/conf.d/zzz-uploads.ini
```

### Verify active configuration

```bash
docker run --rm kimtrien/phpx:php8.5 php --ini
docker run --rm kimtrien/phpx:php8.5 php -i | grep -E "post_max_size|upload_max_filesize|memory_limit|max_execution_time"
```

### More examples

- English: [docs/php-ini-setup.md](docs/php-ini-setup.md)
- Vietnamese: [docs/php-ini-setup.vi.md](docs/php-ini-setup.vi.md)

## Quick Start

### Docker Hub

```dockerfile
FROM kimtrien/phpx:php8.5

WORKDIR /app

COPY . /app

RUN composer install --no-dev --optimize-autoloader
```

### GitHub Container Registry

```dockerfile
FROM ghcr.io/kimtrien/phpx:php8.5

WORKDIR /app

COPY . /app

RUN composer install --no-dev --optimize-autoloader
```

## Available Tags

### Docker Hub

**Latest/Stable:**
- `kimtrien/phpx:latest` - Latest stable (currently PHP 8.5)
- `kimtrien/phpx:php8.5` - PHP 8.5 (recommended)
- `kimtrien/phpx:php8.4` - PHP 8.4

**Version-specific (with FrankenPHP):**
- `kimtrien/phpx:php8.5-frankenphp1.12`
- `kimtrien/phpx:php8.4-frankenphp1.12`

**Release tags (when you push GitHub tags like `v1.0.0`):**
- `kimtrien/phpx:v1.0.0` - PHP 8.5 (default)
- `kimtrien/phpx:1.0.0` - PHP 8.5 (default)
- `kimtrien/phpx:1.0` - PHP 8.5 (default)
- `kimtrien/phpx:v1.0.0-php8.5` - PHP 8.5 explicit
- `kimtrien/phpx:v1.0.0-php8.4` - PHP 8.4 explicit
- `kimtrien/phpx:1.0.0-php8.5` - PHP 8.5 explicit
- `kimtrien/phpx:1.0.0-php8.4` - PHP 8.4 explicit

### GitHub Container Registry

**Latest/Stable:**
- `ghcr.io/kimtrien/phpx:latest` - Latest stable (currently PHP 8.5)
- `ghcr.io/kimtrien/phpx:php8.5` - PHP 8.5 (recommended)
- `ghcr.io/kimtrien/phpx:php8.4` - PHP 8.4

**Version-specific (with FrankenPHP):**
- `ghcr.io/kimtrien/phpx:php8.5-frankenphp1.12`
- `ghcr.io/kimtrien/phpx:php8.4-frankenphp1.12`

**Release tags (when you push GitHub tags like `v1.0.0`):**
- `ghcr.io/kimtrien/phpx:v1.0.0` - PHP 8.5 (default)
- `ghcr.io/kimtrien/phpx:1.0.0` - PHP 8.5 (default)
- `ghcr.io/kimtrien/phpx:1.0` - PHP 8.5 (default)
- `ghcr.io/kimtrien/phpx:v1.0.0-php8.5` - PHP 8.5 explicit
- `ghcr.io/kimtrien/phpx:v1.0.0-php8.4` - PHP 8.4 explicit
- `ghcr.io/kimtrien/phpx:1.0.0-php8.5` - PHP 8.5 explicit
- `ghcr.io/kimtrien/phpx:1.0.0-php8.4` - PHP 8.4 explicit

## Multi-Architecture Support

All images are built for multiple architectures:
- **linux/amd64** - Intel/AMD 64-bit processors
- **linux/arm64** - ARM 64-bit processors (Apple Silicon M1/M2/M3, AWS Graviton, Raspberry Pi 4+)

Docker automatically pulls the correct architecture for your platform.

## Building Locally

```bash
# Default: PHP 8.5, FrankenPHP 1.12
./build.sh

# PHP 8.4
PHP_VERSION=8.4 ./build.sh

# Custom versions
PHP_VERSION=8.3 FRANKENPHP_VERSION=1.3 ./build.sh

# Custom Docker Hub username
DOCKER_USERNAME=yourname ./build.sh
```

## Use Cases

Perfect for:
- PHP production deployments (Laravel, Symfony, etc.)
- CI/CD pipelines
- Development environments (including Apple Silicon Macs)
- Multi-stage Docker builds
- Cloud deployments (AWS Graviton, Azure, GCP)

## Build Time Savings

Using this base image vs building from scratch:
- **Before:** ~5-8 minutes (system deps + PHP extensions)
- **After:** ~30 seconds (pull base image)
- **Speedup:** 10-15x faster

## Version Support

| PHP Version | FrankenPHP Version | Status |
|-------------|-------------------|--------|
| 8.5 | 1.12 | ✅ Active |
| 8.4 | 1.12 | ✅ Active |
| 8.3 | 1.12 | 🔄 On request |

## GitHub Actions Setup

To enable automated builds, add these secrets to your repository:

1. **Docker Hub** (Settings → Secrets → Actions):
   - `DOCKER_USERNAME` - Your Docker Hub username
   - `DOCKER_PASSWORD` - Your Docker Hub access token

2. **GitHub Container Registry** - Automatically configured via `GITHUB_TOKEN`

The workflow automatically builds and pushes on:
- Push to `main` branch (builds both PHP 8.4 and 8.5)
- New version tags (`v*`) - automatically creates matching Docker tags
- Weekly schedule (Sunday at midnight UTC)
- Manual workflow dispatch

### Release Tagging

When you push a GitHub tag, Docker images are automatically tagged:

```bash
# Create and push a release tag
git tag v1.0.0
git push origin v1.0.0
```

This creates Docker images with tags:
- `v1.0.0`, `1.0.0`, `1.0` (PHP 8.5 default)
- `v1.0.0-php8.5`, `1.0.0-php8.5`, `1.0-php8.5` (PHP 8.5 explicit)
- `v1.0.0-php8.4`, `1.0.0-php8.4`, `1.0-php8.4` (PHP 8.4 explicit)

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

MIT - see [LICENSE](LICENSE) file for details.

## Maintainer

[@kimtrien](https://github.com/kimtrien)
