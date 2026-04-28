# PHPX v1.0.0 - Initial Release

## 🎉 Initial Release

**PHPX** is a production-ready PHP base image powered by FrankenPHP with pre-installed extensions.

### ✨ Features

- **PHP Versions**: 8.4 and 8.5
- **Multi-Architecture**: AMD64 and ARM64 (Apple Silicon, AWS Graviton)
- **FrankenPHP**: 1.12
- **Base**: Alpine Linux
- **Pre-installed Extensions**:
  - `pdo_pgsql` - PostgreSQL support
  - `gd` - Image processing
  - `intl` - Internationalization
  - `zip` - Archive handling
  - `bcmath` - Arbitrary precision math
  - `opcache` - Performance optimization
  - `redis` - Redis client
  - `imagick` - Advanced image processing
- **Tools**: Git, Composer, Bash

### 📦 Available Images

**Docker Hub:**
```bash
docker pull kimtrien/phpx:latest
docker pull kimtrien/phpx:php8.5
docker pull kimtrien/phpx:php8.4
```

**GitHub Container Registry:**
```bash
docker pull ghcr.io/kimtrien/phpx:latest
docker pull ghcr.io/kimtrien/phpx:php8.5
docker pull ghcr.io/kimtrien/phpx:php8.4
```

### 🚀 Quick Start

```dockerfile
FROM kimtrien/phpx:php8.5

WORKDIR /app
COPY . /app
RUN composer install --no-dev --optimize-autoloader
```

### 📖 Documentation

Full documentation available at: https://github.com/kimtrien/phpx#readme

### 🔧 Build Time Savings

Using this base image vs building from scratch:
- **Before:** ~5-8 minutes (system deps + PHP extensions)
- **After:** ~30 seconds (pull base image)
- **Speedup:** 10-15x faster

### 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](https://github.com/kimtrien/phpx/blob/main/CONTRIBUTING.md) for details.

### 📄 License

MIT License - see [LICENSE](https://github.com/kimtrien/phpx/blob/main/LICENSE) for details.
