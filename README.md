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
- **Runtime PHP Configuration** - Configure PHP at runtime via environment variables or custom .ini files
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

## Runtime PHP Configuration

PHPX supports **runtime PHP configuration** with two layers of flexibility. No need to rebuild images - configure PHP at container startup.

### Layer 1: Quick Config via Environment Variables

Set common PHP settings directly via environment variables. These are automatically converted to PHP `.ini` directives at runtime.

**Supported Environment Variables:**

| Environment Variable | PHP Directive | Description |
|---------------------|---------------|-------------|
| `PHP_MEMORY_LIMIT` | `memory_limit` | Memory limit for PHP scripts |
| `PHP_POST_MAX_SIZE` | `post_max_size` | Maximum size of POST data |
| `PHP_UPLOAD_MAX_FILESIZE` | `upload_max_filesize` | Maximum upload file size |
| `PHP_MAX_EXECUTION_TIME` | `max_execution_time` | Maximum execution time |
| `PHP_MAX_INPUT_TIME` | `max_input_time` | Maximum input parsing time |
| `PHP_MAX_INPUT_VARS` | `max_input_vars` | Maximum input variables |
| `PHP_DATE_TIMEZONE` | `date.timezone` | Default timezone |
| `PHP_DISPLAY_ERRORS` | `display_errors` | Display errors to output |
| `PHP_DISPLAY_STARTUP_ERRORS` | `display_startup_errors` | Display startup errors |
| `PHP_ERROR_REPORTING` | `error_reporting` | Error reporting level |
| `PHP_LOG_ERRORS` | `log_errors` | Log errors to file |
| `PHP_ERROR_LOG` | `error_log` | Error log file path |
| `PHP_MAX_FILE_UPLOADS` | `max_file_uploads` | Maximum file uploads |
| `PHP_OUTPUT_BUFFERING` | `output_buffering` | Output buffering |
| `PHP_DEFAULT_CHARSET` | `default_charset` | Default charset |
| `PHP_REALPATH_CACHE_SIZE` | `realpath_cache_size` | Realpath cache size |
| `PHP_REALPATH_CACHE_TTL` | `realpath_cache_ttl` | Realpath cache TTL |
| `PHP_OPCACHE_ENABLE` | `opcache.enable` | Enable OPcache |
| `PHP_OPCACHE_MEMORY_CONSUMPTION` | `opcache.memory_consumption` | OPcache memory |
| `PHP_OPCACHE_MAX_ACCELERATED_FILES` | `opcache.max_accelerated_files` | OPcache max files |
| `PHP_OPCACHE_REVALIDATE_FREQ` | `opcache.revalidate_freq` | OPcache revalidate frequency |
| `PHP_SESSION_SAVE_HANDLER` | `session.save_handler` | Session save handler |
| `PHP_SESSION_SAVE_PATH` | `session.save_path` | Session save path |
| `PHP_SESSION_GC_MAXLIFETIME` | `session.gc_maxlifetime` | Session GC max lifetime |

**Example:**

```yaml
services:
  app:
    image: kimtrien/phpx
    environment:
      - PHP_MEMORY_LIMIT=256M
      - PHP_POST_MAX_SIZE=64M
      - PHP_UPLOAD_MAX_FILESIZE=64M
      - PHP_MAX_EXECUTION_TIME=60
      - PHP_MAX_INPUT_TIME=60
      - PHP_MAX_INPUT_VARS=1000
      - PHP_DATE_TIMEZONE=Asia/Ho_Chi_Minh
```

### Layer 2: Deep Config via Custom `.ini` Files

For advanced configuration, mount custom `.ini` files or use `PHP_INI_EXTRA` for raw PHP directives.

**Option A: Mount Custom `.ini` Files**

```yaml
services:
  app:
    image: kimtrien/phpx
    volumes:
      - ./php-custom-ini:/etc/phpx/custom-ini
```

Create `.ini` files in `./php-custom-ini/` directory:

```ini
# ./php-custom-ini/custom-performance.ini
opcache.enable=1
opcache.memory_consumption=128
opcache.max_accelerated_files=10000
opcache.revalidate_freq=60
```

**Option B: Use `PHP_INI_EXTRA` Environment Variable**

```yaml
services:
  app:
    image: kimtrien/phpx
    environment:
      - PHP_INI_EXTRA=expose_php=Off\nshort_open_tag=Off\nmax_execution_time=300
```

### Configuration Priority

1. Base PHP defaults (from FrankenPHP image)
2. Custom `.ini` files from `/etc/phpx/custom-ini/` (alphabetical order)
3. `PHP_INI_EXTRA` environment variable
4. Individual `PHP_*` environment variables (highest priority)

### Universal Application

The runtime configuration applies to **all PHP execution modes**:
- PHP CLI commands
- FrankenPHP web server
- Laravel Octane workers
- Laravel Horizon workers
- Laravel scheduler

No need to configure separately for each mode.

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
