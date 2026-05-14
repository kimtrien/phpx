# Hướng Dẫn Thiết Lập PHP INI

PHPX dùng cơ chế cấu hình PHP chuẩn. Để tùy chỉnh PHP, hãy thêm các file `.ini` vào thư mục:

```bash
/usr/local/etc/php/conf.d/
```

Cách này áp dụng cho mọi chế độ chạy PHP trong container, bao gồm cả CLI và FrankenPHP.

## Cách 1: Mount file `.ini` tùy chỉnh

Đây là cách đơn giản nhất cho môi trường local/development.

```yaml
services:
  app:
    image: kimtrien/phpx:php8.5
    volumes:
      - ./php-custom-ini/uploads.ini:/usr/local/etc/php/conf.d/zzz-uploads.ini:ro
```

Ví dụ `uploads.ini`:

```ini
post_max_size=64M
upload_max_filesize=64M
memory_limit=256M
max_execution_time=60
```

Nên dùng tên như `zzz-uploads.ini` nếu bạn muốn file override được load sau các file extension `.ini` đã có sẵn trong image.

## Cách 2: Copy file `.ini` vào image ứng dụng

Cách này phù hợp hơn cho production.

```dockerfile
FROM kimtrien/phpx:php8.5

COPY docker/php/uploads.ini /usr/local/etc/php/conf.d/zzz-uploads.ini
```

Ví dụ `uploads.ini`:

```ini
post_max_size=64M
upload_max_filesize=64M
memory_limit=256M
max_execution_time=60
```

## Một số cấu hình thường dùng

```ini
post_max_size=64M
upload_max_filesize=64M
memory_limit=256M
max_execution_time=60
date.timezone=Asia/Ho_Chi_Minh
opcache.enable=1
```

## Kiểm tra cấu hình đang hoạt động

Kiểm tra PHP đã load những file `.ini` nào:

```bash
docker run --rm kimtrien/phpx:php8.5 php --ini
```

Kiểm tra giá trị cụ thể:

```bash
docker run --rm kimtrien/phpx:php8.5 php -i | grep -E "post_max_size|upload_max_filesize|memory_limit|max_execution_time|date.timezone"
```

Kiểm tra trực tiếp các file trong thư mục config:

```bash
docker run --rm kimtrien/phpx:php8.5 sh -lc 'ls -la /usr/local/etc/php/conf.d'
```

## Cách dùng khuyến nghị

- Development: mount file `.ini` từ host
- Production: copy file `.ini` vào image cuối cùng
- Ưu tiên file `.ini` rõ ràng thay vì cơ chế chuyển đổi runtime từ environment variable
