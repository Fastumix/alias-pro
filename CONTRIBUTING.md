## Contributing to Alias Pro

Thank you for your interest in contributing to Alias Pro!

### Development Guidelines

#### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` before committing
- Run `flutter format .` to format code
- Maintain 80% test coverage for new features

#### Architecture Rules

1. **Clean Architecture**: Always separate presentation, domain, and data layers
2. **Riverpod Only**: Use Riverpod for state management (no GetX, Bloc, etc.)
3. **GoRouter**: Use GoRouter for navigation (no Navigator 1.0)
4. **Null Safety**: All code must be null-safe
5. **Type Safety**: Avoid `dynamic` types

#### Feature Development Process

1. **Create Feature Branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Follow Feature Structure**

   ```
   features/
     your-feature/
       ├── domain/
       │   ├── entities/
       │   └── usecases/
       ├── data/
       │   ├── datasources/
       │   └── repositories/
       └── presentation/
           ├── providers/
           ├── screens/
           └── widgets/
   ```

3. **Write Tests First** (TDD recommended)

   ```bash
   flutter test test/your_feature_test.dart
   ```

4. **Implement Feature**
   - Start with domain entities
   - Create providers
   - Build UI screens
   - Add navigation

5. **Code Review Checklist**
   - [ ] Tests pass (`flutter test`)
   - [ ] No analyzer issues (`flutter analyze`)
   - [ ] Code formatted (`flutter format .`)
   - [ ] Documentation updated
   - [ ] CHANGELOG.md updated

#### Pull Request Template

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing

- [ ] Unit tests added/updated
- [ ] Manual testing performed
- [ ] All tests pass

## Checklist

- [ ] Code follows style guidelines
- [ ] Self-review performed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings generated
```

#### Commit Message Convention

Use conventional commits:

```
feat: add multiplayer mode
fix: resolve timer sync issue
docs: update README with setup instructions
test: add game logic unit tests
refactor: simplify category repository
style: format code according to guidelines
```

#### Testing Standards

1. **Unit Tests**: Test all domain logic
2. **Widget Tests**: Test critical UI components
3. **Integration Tests**: Test complete user flows
4. **Coverage**: Maintain >80% coverage

```bash
# Run tests with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

#### Documentation

- Add dartdoc comments to public APIs
- Update README.md for new features
- Update CHANGELOG.md
- Add inline comments for complex logic

#### Questions?

Open an issue or discussion on GitHub.
