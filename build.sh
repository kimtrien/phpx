#!/bin/bash

set -e

DOCKER_USERNAME="${DOCKER_USERNAME:-kimtrien}"
IMAGE_NAME="phpx"
PHP_VERSION="${PHP_VERSION:-8.5}"
FRANKENPHP_VERSION="${FRANKENPHP_VERSION:-1.12}"

TAG_FULL="${DOCKER_USERNAME}/${IMAGE_NAME}:php${PHP_VERSION}-frankenphp${FRANKENPHP_VERSION}"
TAG_PHP="${DOCKER_USERNAME}/${IMAGE_NAME}:php${PHP_VERSION}"
TAG_LATEST="${DOCKER_USERNAME}/${IMAGE_NAME}:latest"

echo "🔨 Building PHPX base image"
echo "   PHP: ${PHP_VERSION}"
echo "   FrankenPHP: ${FRANKENPHP_VERSION}"
echo ""

docker build \
    --build-arg PHP_VERSION="${PHP_VERSION}" \
    --build-arg FRANKENPHP_VERSION="${FRANKENPHP_VERSION}" \
    -t "${TAG_FULL}" \
    -t "${TAG_PHP}" \
    -t "${TAG_LATEST}" \
    .

echo ""
echo "✅ Build complete!"
echo ""
echo "📦 Built tags:"
echo "  - ${TAG_FULL}"
echo "  - ${TAG_PHP}"
echo "  - ${TAG_LATEST}"
echo ""

read -p "🚀 Push to Docker Hub? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔐 Logging in to Docker Hub..."
    docker login
    
    echo "📤 Pushing ${TAG_FULL}..."
    docker push "${TAG_FULL}"
    
    echo "📤 Pushing ${TAG_PHP}..."
    docker push "${TAG_PHP}"
    
    echo "📤 Pushing ${TAG_LATEST}..."
    docker push "${TAG_LATEST}"
    
    echo ""
    echo "✅ Push complete!"
    echo ""
    echo "🎉 Image available at:"
    echo "  docker pull ${TAG_FULL}"
    echo "  docker pull ${TAG_PHP}"
    echo "  docker pull ${TAG_LATEST}"
else
    echo "⏭️  Skipped push"
fi
