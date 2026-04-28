# Contributing to PHPX

Thank you for considering contributing to this project! This document outlines the process for contributing.

## How to Contribute

### Reporting Issues

- Check existing issues before creating a new one
- Provide clear description of the problem
- Include steps to reproduce
- Specify PHP/FrankenPHP versions affected

### Suggesting Enhancements

- Open an issue with the `enhancement` label
- Clearly describe the proposed feature
- Explain why it would be useful
- Consider backward compatibility

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow existing code style
   - Test your changes locally
   - Update documentation if needed

4. **Test the build**
   ```bash
   ./build.sh
   docker run --rm kimtrien/phpx:latest php -v
   ```

5. **Commit your changes**
   ```bash
   git commit -m "Add: brief description of changes"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**
   - Provide clear description of changes
   - Reference related issues
   - Wait for review

## Development Guidelines

### Adding PHP Extensions

When adding new extensions:
1. Add system dependencies to `apk add` section
2. Add extension to `docker-php-ext-install` or use `install-php-extensions`
3. Test on both AMD64 and ARM64 architectures
4. Update README.md with new extension

### Version Updates

- PHP version updates should be tested thoroughly
- FrankenPHP version updates require compatibility verification
- Update version tables in README.md

### Testing Checklist

Before submitting PR:
- [ ] Image builds successfully
- [ ] All extensions load correctly (`php -m`)
- [ ] Composer works
- [ ] Git is available
- [ ] Image size is reasonable
- [ ] Multi-arch build works (if applicable)

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow

## Questions?

Open an issue with the `question` label or reach out to [@kimtrien](https://github.com/kimtrien).

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
