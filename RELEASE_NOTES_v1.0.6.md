# PHPX v1.0.6 - MySQL Support

## ✨ New Features

### MySQL Support

Added `pdo_mysql` as a pre-installed extension, enabling out-of-the-box MySQL/MariaDB connectivity.

- Added `mysql-dev` system dependency
- Added `pdo_mysql` PHP extension to the build

**Pre-installed Extensions (updated):**
- `pdo_mysql` - MySQL/MariaDB support *(new)*
- `pdo_pgsql` - PostgreSQL support
- `gd` - Image processing
- `intl` - Internationalization
- `zip` - Archive handling
- `bcmath` - Arbitrary precision math
- `opcache` - Performance optimization
- `redis` - Redis client
- `imagick` - Advanced image processing

## 📦 Available Images

**Docker Hub:**
```bash
docker pull kimtrien/phpx:v1.0.6
docker pull kimtrien/phpx:1.0.6
docker pull kimtrien/phpx:1.0
```

**GitHub Container Registry:**
```bash
docker pull ghcr.io/kimtrien/phpx:v1.0.6
docker pull ghcr.io/kimtrien/phpx:1.0.6
docker pull ghcr.io/kimtrien/phpx:1.0
```

## 📖 Documentation

Full documentation available at: https://github.com/kimtrien/phpx#readme

## 🔄 Upgrade from v1.0.5

No breaking changes. Simply pull the new image:
```bash
docker pull kimtrien/phpx:v1.0.6
```

## 📄 License

MIT License - see [LICENSE](https://github.com/kimtrien/phpx/blob/main/LICENSE) for details.
