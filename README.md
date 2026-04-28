# PHPX - PHP eXtended Base Image

[![Docker Hub](https://img.shields.io/docker/pulls/kimtrien/phpx)](https://hub.docker.com/r/kimtrien/phpx)
[![GitHub Container Registry](https://img.shields.io/badge/ghcr-latest-blue)](https://github.com/kimtrien/phpx/pkgs/container/phpx)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Production-ready PHP base image powered by FrankenPHP with all common extensions pre-installed. Built for **multi-architecture** support (AMD64 & ARM64).

## Features

- **FrankenPHP 1.4** - Modern PHP application server
- **PHP 8.5 & 8.4** - Latest PHP versions
- **Alpine Linux** - Minimal footprint
- **Multi-Architecture** - Supports AMD64 and ARM64 (Apple Silicon, AWS Graviton)
- **Pre-installed Extensions:**
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
- `kimtrien/phpx:latest` - Latest stable (currently PHP 8.5)
- `kimtrien/phpx:php8.5` - PHP 8.5 (recommended)
- `kimtrien/phpx:php8.4` - PHP 8.4
- `kimtrien/phpx:php8.5-frankenphp1.4` - Specific versions
- `kimtrien/phpx:php8.4-frankenphp1.4` - Specific versions

### GitHub Container Registry
- `ghcr.io/kimtrien/phpx:latest` - Latest stable (currently PHP 8.5)
- `ghcr.io/kimtrien/phpx:php8.5` - PHP 8.5 (recommended)
- `ghcr.io/kimtrien/phpx:php8.4` - PHP 8.4
- `ghcr.io/kimtrien/phpx:php8.5-frankenphp1.4` - Specific versions
- `ghcr.io/kimtrien/phpx:php8.4-frankenphp1.4` - Specific versions

## Multi-Architecture Support

All images are built for multiple architectures:
- **linux/amd64** - Intel/AMD 64-bit processors
- **linux/arm64** - ARM 64-bit processors (Apple Silicon M1/M2/M3, AWS Graviton, Raspberry Pi 4+)

Docker automatically pulls the correct architecture for your platform.

## Building Locally

```bash
# Default: PHP 8.5, FrankenPHP 1.4
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
| 8.5 | 1.4 | ✅ Active |
| 8.4 | 1.4 | ✅ Active |
| 8.3 | 1.4 | 🔄 On request |

## GitHub Actions Setup

To enable automated builds, add these secrets to your repository:

1. **Docker Hub** (Settings → Secrets → Actions):
   - `DOCKER_USERNAME` - Your Docker Hub username
   - `DOCKER_PASSWORD` - Your Docker Hub access token

2. **GitHub Container Registry** - Automatically configured via `GITHUB_TOKEN`

The workflow automatically builds and pushes on:
- Push to `main` branch (builds both PHP 8.4 and 8.5)
- New version tags (`v*`)
- Weekly schedule (Sunday at midnight UTC)
- Manual workflow dispatch

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

MIT - see [LICENSE](LICENSE) file for details.

## Maintainer

[@kimtrien](https://github.com/kimtrien)
