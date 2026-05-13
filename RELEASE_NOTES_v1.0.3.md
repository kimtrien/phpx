# PHPX v1.0.3 - Runtime PHP Configuration

## ✨ New Features

### Runtime PHP Configuration

Added a powerful runtime PHP configuration mechanism that allows you to configure PHP at container startup without rebuilding images.

**Layer 1: Quick Config via Environment Variables**
Set common PHP settings directly via environment variables:
- `PHP_MEMORY_LIMIT`, `PHP_POST_MAX_SIZE`, `PHP_UPLOAD_MAX_FILESIZE`
- `PHP_MAX_EXECUTION_TIME`, `PHP_MAX_INPUT_TIME`, `PHP_MAX_INPUT_VARS`
- `PHP_DATE_TIMEZONE`, `PHP_DISPLAY_ERRORS`, `PHP_ERROR_REPORTING`
- `PHP_LOG_ERRORS`, `PHP_ERROR_LOG`, `PHP_MAX_FILE_UPLOADS`
- `PHP_OUTPUT_BUFFERING`, `PHP_DEFAULT_CHARSET`
- `PHP_REALPATH_CACHE_SIZE`, `PHP_REALPATH_CACHE_TTL`
- `PHP_OPCACHE_ENABLE`, `PHP_OPCACHE_MEMORY_CONSUMPTION`
- `PHP_OPCACHE_MAX_ACCELERATED_FILES`, `PHP_OPCACHE_REVALIDATE_FREQ`
- `PHP_SESSION_SAVE_HANDLER`, `PHP_SESSION_SAVE_PATH`, `PHP_SESSION_GC_MAXLIFETIME`

**Layer 2: Deep Config via Custom `.ini` Files**
- Mount custom `.ini` files to `/etc/phpx/custom-ini/`
- Use `PHP_INI_EXTRA` environment variable for raw PHP directives

**Universal Application**
Configuration applies to all PHP execution modes:
- PHP CLI commands
- FrankenPHP web server
- Laravel Octane workers
- Laravel Horizon workers
- Laravel scheduler

## 📦 Available Images

**Docker Hub:**
```bash
docker pull kimtrien/phpx:v1.0.3
docker pull kimtrien/phpx:1.0.3
docker pull kimtrien/phpx:1.0
```

**GitHub Container Registry:**
```bash
docker pull ghcr.io/kimtrien/phpx:v1.0.3
docker pull ghcr.io/kimtrien/phpx:1.0.3
docker pull ghcr.io/kimtrien/phpx:1.0
```

## 📖 Documentation

Full documentation available at: https://github.com/kimtrien/phpx#readme

## 🔄 Upgrade from v1.0.2

No breaking changes. Simply pull the new image:
```bash
docker pull kimtrien/phpx:v1.0.3
```

## 📄 License

MIT License - see [LICENSE](https://github.com/kimtrien/phpx/blob/main/LICENSE) for details.
